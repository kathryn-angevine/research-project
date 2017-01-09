function [ SkuMaster ] = setInventoryLevels(SkuMaster, workSheetDetail)

% ALL INVENTORY IN TILE UNITS

switch workSheetDetail(1).InventoryType
    
    case 1 % set inventory levels to 0
        for i=1:length(SkuMaster(:,1))  %  iterates through every cell in SkuMaster
            for j=1:length(SkuMaster(1,:))
            
                 SkuMaster(i,j).inventoryPosition = 0;
            
            end
        end
        
    
    case 2 % read inventory levels from file
        
        Path = 'C:\Users\Michael\Desktop\Artaic\Project 1 - Safety Stock Calculations\0_Matlab_Simulation\Excel_Import\InventoryLevels.xlsx';                        %[pathname, filename]
        [numeric, partname] = xlsread(Path,1);
        
        for i=1:length(SkuMaster(:,1))
            for j=1:length(partname)
                if strcmp(SkuMaster(i,1).name, partname(j))
                    
                    for k=1:length(SkuMaster(1,:))
                        SkuMaster(i,k).inventoryPosition(1) = numeric(j);
                    end
                end
            end
        end    
        
    case 3 % set inventory levels to reorder level 
        for i=1:length(SkuMaster(:,1))
            for j=1:length(SkuMaster(1,:))
                
               SkuMaster(i,j).inventoryPosition = SkuMaster(i,1).reorderLevel
            end
        end
        
end





end

