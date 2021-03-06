classdef Sku 

	properties
	name;			% SKU identifier
	skuSize;        % 375, 5 or 1
    skuType;        % VG or SG
    moq;            % Minimum Order Quantity of this type / batch quantity
    countSku375 = 0;   % count the number of SKUs of type 375 in the simulation
    countSku5 = 0;     % count the number of SKUs of type 5 in the simulation
    countSku1 = 0;     % count the number of SKUs of type 1 in the simulation
    tilesPerWeight;
    inventoryCostRate; % cost to hold excess tiles in inventory, could get from user input eventually
    procurementCost;   % cost of the Sku
    meanDemand;				
	varianceDemand;
	reorderLevel;
	deliveryTime = 7;  % update when add leadTime feild to GUI
    lostProjects; % count of lost projects for this SKU
    
    opp;
    orders;                 % List of orders to the supplier, in the form of an array of SupplierOrder objects
    customerOrderHistory;   % Customer demand history for this SKU (actual demand in real life)
    
    currentInventory;
        
    currentBackorder=0;
    backorderHistory=0;
    
    inventoryPosition=0;
    inventoryPositionHistory=0;
    
    demandOverSimulationLength; % simulation demand, cumulative or project arrival based?
    
    fillRate = 0;
    fillRate375 = 0;
    fillRate5 = 0;
    fillRate1 = 0;
    simulatedInventoryCost = 0; % saves and sums the cost for holding inventory
    simulatedBackorderCost = 0; % saves and sums the cost for backordering inventory
    simulatedOrderCost = 0;
    
    
    end
    
    methods
        function obj = Sku(name, skuSize, skuType, customerOrderHistory, workSheetDetail) % constructor
            obj.name = name;
            obj.skuSize = skuSize;
            obj.skuType = skuType;
            [obj.moq, obj.tilesPerWeight, obj.procurementCost] = skuDistinction(skuSize, workSheetDetail);
            obj.inventoryCostRate = (workSheetDetail.InventoryCostRate/100 *obj.procurementCost)/52; % weekly inventory cost
            obj.customerOrderHistory = customerOrderHistory;
            obj.meanDemand = mean(customerOrderHistory);
            obj.varianceDemand = var(customerOrderHistory);
            obj.opp = 0; % opportunity functionality 
            obj.orders = SupplierOrder;
            obj.reorderLevel = calcReorderLevel(obj.meanDemand, obj.varianceDemand, obj.opp, obj.skuSize, workSheetDetail);
            obj.backorderHistory=zeros(1,workSheetDetail(1).Weeks);
                        
        end
        
    end
        
end

function reorderLevel = calcReorderLevel(mean, variance, opp, skuSize, workSheetDetail)

switch workSheetDetail(1).OrderStrategy
    case 1 %newsvendor model
        if skuSize == 5 || 1 % SG
            reorderLevel = norminv(0.934, (13+7)*mean*1.05, sqrt((13+7)*variance));          %(2*sqrt(1.33*19)*sqrt(variance)+max(1.33*mean, opp)+11*(1.33*mean))*1.05;
            
        else % VG
            reorderLevel = norminv(0.931, (13+7)*mean*1.05, sqrt((13+7)*variance)); % 13 reorder interval, 7 is the leadtime
            
        end
        
    case 2
        reorderLevel = (2*sqrt(1.33*19)*sqrt(variance)+max(1.33*mean, opp)+11*(1.33*mean))*1.05;
        
    % case 2- use order strategy in Excel Model which incorporates
    % Opportunity functionality 
end

end

function [sku, tilesPerWeight, procurementCost] = skuDistinction(skuSize, workSheetDetail)

    
    if skuSize == 375
            sku = workSheetDetail.Moq375;
            tilesPerWeight = workSheetDetail.TilesPerLbs375;
            procurementCost = workSheetDetail.ProcurementCost375;
        
    elseif skuSize == 5
           sku = workSheetDetail.Moq5;
           tilesPerWeight = workSheetDetail.TilesPerLbs5;
           procurementCost = workSheetDetail.ProcurementCost5;
        
    elseif skuSize == 1
           sku = workSheetDetail.Moq1; 
           tilesPerWeight = workSheetDetail.TilesPerLbs1;
           procurementCost = workSheetDetail.ProcurementCost1;
    end

    
end




