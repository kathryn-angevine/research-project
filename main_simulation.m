function [simulationReturn] = main_simulation(workSheetDetail)


format long g % no scientific notation
tic  % timer, not operational

% ------ Initialize Simulation & Read Data ------ %

global SkuMaster;

% stores all simulation parameters usually retrieved from the GUI
% uncomment to run 'main_simulation' without the GUI
workSheetDetail = struct('DataType', 1, 'InventoryType', 1,'OrderStrategy', 2, 'ReorderInterval', 13, 'Iterations', 2, 'InventoryCostRate', 20, 'Weeks', 52, 'BackorderCostRate', 20, 'Tile375', 1, 'Moq375', 22, 'ProcurementCost375', 3.7,'TilesPerLbs375', 660, 'Tile5', true, 'Moq5', 50, 'ProcurementCost5', 3.74, 'TilesPerLbs5', 365, 'Tile1', true, 'Moq1', 50, 'ProcurementCost1', 3.74, 'TilesPerLbs1', 84, 'PastDemandPath', '/Users/Kat/Desktop/Artaic/Artaic Simulation/Excel_Import/OrderHistory.xlsx', 'Output','Users/Kat/Desktop/Artaic/Artaic Simulation/Excel_Import/Output.xlsx', 'Report', false);


% SkuMaster is an array of all SKUs. Each element is an SKU object of
% SKU.m class. 
% SkuMaster(i,j) with i: SKU # and j: iteration simulated
SkuMaster = readData(workSheetDetail); % all Sku objects in SkuMaster initilized


 
% Set your starting inventory level - zero, reorder, or from file
SkuMaster = setInventoryLevels(SkuMaster, workSheetDetail);

% Create all future demand for each period and iteration Demand for each
% period is saved in the 'demandOverSimulationLength array' in the SKU
% object
SkuMaster = createDemand(SkuMaster, workSheetDetail);  % assign future demand to each Sku


% ------ ITERATION (SIMULATION) ------ %

% Simulate inventory depletion and supply over given weeks and repeat as
% specified (iterations)

for h=1:workSheetDetail(1).Iterations 
    for i=1:workSheetDetail(1).Weeks
                    
        % initialize the order array with an empty order empty order will
        % be overwritten in case there is an order in the period
        for j=1:length(SkuMaster(:,h)) % iterate through all SKUs, and all of the weeks in the Sku, then more on to next iteration
            SkuMaster(j,h).orders(i) = SupplierOrder(i, 0, SkuMaster(j,h));  %timePlaced, orderAmount, Sku
        end
        
        
        % depending on specified ordering rule, check if orders need to be
        % placed (every week)
        if mod(i,workSheetDetail(1).ReorderInterval)==0 % if i is a multiple of reorder interval
            for j=1:length(SkuMaster(:,h)) % iterate through all SKUs for that week of that iteration
                if SkuMaster(j,h).inventoryPosition < SkuMaster(j,h).reorderLevel
                    
                    SkuMaster(j,h).orders(i) = SupplierOrder(i, SkuMaster(j,h).reorderLevel-SkuMaster(j,h).inventoryPosition, SkuMaster(j,h));  
                    % place order to bring up to reorder level
                end
            end
         end
                
        
        % iterate through all outstanding SupplierOrders and check if order
        % arrived and update inventory
                
        for j=1:length(SkuMaster(:,h)) % for all Skus
            for k=1:length(SkuMaster(j,h).orders) % for all the orders
                if SkuMaster(j,h).orders(k).timeArrived == i %check if arrived, if did update current inventory
                    
                   SkuMaster(j,h).inventoryPosition = SkuMaster(j,h).inventoryPosition + SkuMaster(j,h).orders(k).orderAmount*SkuMaster(j,h).tilesPerWeight;
                    
                end
            end
        end
        
        
        % decrease inventory according to customer orders that day
        
        for j=1:length(SkuMaster(:,h)) % for all Skus in iteration
        
            % check if inventory is available
            if SkuMaster(j,h).inventoryPosition > 0
                
                % inventory enough to fulfill entire order?
                if (SkuMaster(j,h).inventoryPosition - SkuMaster(j,h).demandOverSimulationLength(i)) > 0
                    SkuMaster(j,h).inventoryPosition = SkuMaster(j,h).inventoryPosition - SkuMaster(j,h).demandOverSimulationLength(i);
                
                    % only part of the order can be fullfilled
                else
                    SkuMaster(j,h).currentBackorder = SkuMaster(j,h).demandOverSimulationLength(i) - SkuMaster(j,h).inventoryPosition;
                    SkuMaster(j,h).backorderHistory(i) = SkuMaster(j,h).demandOverSimulationLength(i) - SkuMaster(j,h).inventoryPosition;
                    SkuMaster(j,h).inventoryPosition = 0;
                end
                    
            % no inventory available
            else
                
                SkuMaster(j,h).currentBackorder = SkuMaster(j,h).currentBackorder - SkuMaster(j,h).demandOverSimulationLength(i);
                SkuMaster(j,h).inventoryPosition = SkuMaster(j,h).inventoryPosition - SkuMaster(j,h).demandOverSimulationLength(i);
                SkuMaster(j,h).backorderHistory(i) = - SkuMaster(j,h).demandOverSimulationLength(i);
            end % store backorder log in backorderHistory
        end
        

        % record inventory for this period for every Sku in iteration, an
        % array of inventory values
        
        for j=1:length(SkuMaster(:,h))
            
           SkuMaster(j,h).inventoryPositionHistory(i) = SkuMaster(j,h).inventoryPosition;
        end
        
               
    end
    
end




%  ------ Calculate output ------ %

% Inventory Cost
    [SkuMaster, averageInvCostPerRun] = calcInventoryCost(SkuMaster, workSheetDetail(1).Weeks);
    
% Shipping Cost
    [SkuMaster, averageShippingCostPerRun] = calculateShippingCost(SkuMaster);
    

% Beta Service level - percentage of Skus within each project that can be
% fulfilled 
    [SkuMaster, averageFillRate] = calcFillRate(SkuMaster, workSheetDetail);

% Number of lost projects
    % For project based strategy: > easy For cumulative, make each week one
    % project and count that. [SkuMaster, lostProjects] =
    % calcLostProjects(SkuMaster, workSheetDetail);

    
    
% Test Plot

%   x=1:workSheetDetail(1).Weeks; figure plot(x,
%   SkuMaster(1,1).demandOverSimulationLength,
%   x,SkuMaster(1,1).backorderHistory,
%   x,SkuMaster(1,1).inventoryPositionHistory) legend('Demand','Backorder',
%   'Inventory Position',
%   'Location','southoutside','Orientation','horizontal');


% Confidence Interval
  SEM = std(averageInvCostPerRun)/sqrt(length(averageInvCostPerRun));              % Standard Error
 % ts = tinv([0.025  0.975],length(averageInvCostPerRun)-1);
 % % T-Score



%  ------ Excel output ------  %
%can document simulation output in Excel file

if workSheetDetail(1).Report==1
    
    outputsheet = 1;
    
    % Settings
    xlswrite(workSheetDetail(1).Output,{date},outputsheet,'C2');
    xlswrite(workSheetDetail(1).Output,workSheetDetail(1).Iterations,outputsheet,'C3');
    xlswrite(workSheetDetail(1).Output,workSheetDetail(1).Weeks,outputsheet,'C4');
    xlswrite(workSheetDetail(1).Output,SkuMaster(1,1).inventoryCostRate,outputsheet,'C5');
    
    xlswrite(workSheetDetail(1).Output,start,outputsheet,'C7');
    xlswrite(workSheetDetail(1).Output,type,outputsheet,'C8');
    xlswrite(workSheetDetail(1).Output,type,orderRule,'C9');
    
    % Result: Overview
    timeElapsed = toc/60;
    xlswrite(workSheetDetail(1).Output,timeElapsed,outputsheet,'C17');
    xlswrite(workSheetDetail(1).Output,mean(averageInvCostPerRun),outputsheet,'C18');
    xlswrite(workSheetDetail(1).Output,min(averageInvCostPerRun),outputsheet,'C19');
    xlswrite(workSheetDetail(1).Output,max(averageInvCostPerRun),outputsheet,'C20');
    xlswrite(workSheetDetail(1).Output,mean(averageInvCostPerRun) + ts*SEM,outputsheet,'C21');
    xlswrite(workSheetDetail(1).Output,mean(averageFillRate),outputsheet,'C23');
    
    % Result: Details
    xlswrite(workSheetDetail(1).Output,(1:1:workSheetDetail(1).Iterations)',outputsheet,'E2');
    xlswrite(workSheetDetail(1).Output,averageInvCostPerRun',outputsheet,'F2');
    xlswrite(workSheetDetail(1).Output,averageFillRate',outputsheet,'H2');
    
    %PlotInExcel(workSheetDetail(1).Output, 1,
    %SkuMaster(1,1).backorderHistory,
    %SkuMaster(1,1).inventoryPositionHistory);
    
   
end


% ------ Output to GUI ------ %

meanInventoryCost = mean(averageInvCostPerRun(1,:));
minInventoryCost = min(averageInvCostPerRun(1,:));
maxInventoryCost = max(averageInvCostPerRun(1,:));
meanInventoryCost375 = mean(averageInvCostPerRun(2,:));
minInventoryCost375 = min(averageInvCostPerRun(2,:));
maxInventoryCost375 = max(averageInvCostPerRun(2,:));
meanInventoryCost5 = mean(averageInvCostPerRun(3,:));
minInventoryCost5 = min(averageInvCostPerRun(3,:));
maxInventoryCost5 = max(averageInvCostPerRun(3,:));
meanInventoryCost1 = mean(averageInvCostPerRun(4,:));
minInventoryCost1 = min(averageInvCostPerRun(4,:));
maxInventoryCost1 = max(averageInvCostPerRun(4,:));

fillRateTotal = mean(averageFillRate(1,:));
fillRate375 = mean(averageFillRate(2,:));
fillRate5 = mean(averageFillRate(3,:));
fillRate1 = mean(averageFillRate(4,:));


shippingCostTotal = mean(averageShippingCostPerRun(1,:));
shippingCostTotal375 = mean(averageShippingCostPerRun(2,:));
shippingCostTotal5 = mean(averageShippingCostPerRun(3,:));
shippingCostTotal1 = mean(averageShippingCostPerRun(4,:));
shippingAirSavings= mean(averageShippingCostPerRun(5,:)) - shippingCostTotal;

simulationDone='Simulation Done';

simulationReturn = struct('skuMaster', SkuMaster, 'shippingAirSavings', shippingAirSavings, 'shippingCostTotal', shippingCostTotal, 'shippingCostTotal375', shippingCostTotal375, 'shippingCostTotal5', shippingCostTotal5, 'shippingCostTotal1', shippingCostTotal1, 'maxInventoryCost375', maxInventoryCost375, 'minInventoryCost375', minInventoryCost375, 'meanInventoryCost375', meanInventoryCost375,'maxInventoryCost5', maxInventoryCost5, 'minInventoryCost5', minInventoryCost5, 'meanInventoryCost5', meanInventoryCost5,'maxInventoryCost1', maxInventoryCost1, 'minInventoryCost1', minInventoryCost1, 'meanInventoryCost1', meanInventoryCost1,'maxInventoryCost', maxInventoryCost, 'minInventoryCost', minInventoryCost, 'meanInventoryCost', meanInventoryCost, 'FillRate375', fillRate375,'FillRate5', fillRate5,'FillRate1', fillRate1,'FillRateTotal', fillRateTotal, 'simulationOver', simulationDone);


 end