function [orderCalculationReturn] = main_orderCalculation()%workSheetDetail)

workSheetDetail = struct('DataType', 1, 'InventoryType', 1,'OrderStrategy', 2, 'ReorderInterval', 13, 'Iterations', 2, 'InventoryCostRate', 20, 'Weeks', 52, 'BackorderCostRate', 20, 'Tile375', 1, 'Moq375', 22, 'ProcurementCost375', 3.7,'TilesPerLbs375', 660, 'Tile5', true, 'Moq5', 50, 'ProcurementCost5', 3.74, 'TilesPerLbs5', 365, 'Tile1', true, 'Moq1', 50, 'ProcurementCost1', 3.74, 'TilesPerLbs1', 84, 'PastDemandPath', 'C:\Users\Michael\Desktop\Artaic\Project 1 - Safety Stock Calculations\0_Matlab_Simulation\Excel_Import\OrderHistory.xlsx', 'Output','C:\Users\Michael\Desktop\Artaic\Project 1 - Safety Stock Calculations\0_Matlab_Simulation\Excel_Import\Output.xlsx', 'Report', false);


% ---        Initialize      ---- %

% initialize Sku list and reorderLevels
% SkuMaster(i,j) with i: SKU # and j: iteration
SkuMaster = readData(workSheetDetail); 

% Set inventory levels
SkuMaster = setInventoryLevels(SkuMaster, workSheetDetail);


% Type of demand created: 
% SkuMaster = createDemand(SkuMaster, workSheetDetail);  % assign future demand to each Sku

 % same initilization as simulation > no iterations needed
%SkuMaster = SkuMaster(:,1)


for j=1:length(SkuMaster(:,1)) % iterate through all SKUs
    if SkuMaster(j,1).inventoryPosition <= SkuMaster(j,1).reorderLevel
        
        SkuMaster(j,1).orders(1) = SupplierOrder(1, SkuMaster(j,1).reorderLevel-SkuMaster(j,1).inventoryPosition, SkuMaster(j,1));
    end
end

% calculate shipping cost

    
    
orderCalculationReturn = SkuMaster;

end
