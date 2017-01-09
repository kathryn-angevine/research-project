function [ SkuMaster, averageFillRate ] = calcLostProjects( SkuMaster, workSheetDetail )

for h=1:length(SkuMaster(:,1))
    for i=1:length(SkuMaster(h,:)) %Sku specific Service Level

        SkuMaster(h,i).lostProjects = sum(SkuMaster(h,i).inventoryPositionHistory <0);
        
    end
end


end

