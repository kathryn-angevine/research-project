function [ SkuMaster, InvCost] = calcInventoryCost( SkuMaster, numberOfWeeksSimulated)
% Calculates the inventory costs and returns the InvCost array

InvCostPerRun = zeros(1,length(SkuMaster(1,:))); %zeros creates matrix of all zeros, but really an array because first param is one
InvCost375 = zeros(1,length(SkuMaster(1,:)));
InvCost5 = zeros(1,length(SkuMaster(1,:)));
InvCost1 = zeros(1,length(SkuMaster(1,:)));

% Sku specific inventory cost in each iteration
  for h=1:length(SkuMaster(:,1))  
    for i=1:length(SkuMaster(h,:)) 
        for j=1:numberOfWeeksSimulated

            if SkuMaster(h,i).inventoryPositionHistory(j) >= 0 % there is inventory in the period
                
                SkuMaster(h,i).simulatedInventoryCost = SkuMaster(h,i).simulatedInventoryCost + SkuMaster(h,i).inventoryPositionHistory(j) / SkuMaster(h,i).tilesPerWeight *  SkuMaster(h,i).inventoryCostRate;
                
            else % no inventory but backorders
                
            end
        end
    end
  end
  
  % sum up all inventory costs over all SKU for each simulation repetition
  % to get InvCostPerRun and InvCost per Tile Line
  
  for h=1:length(SkuMaster(h,:)) 
    for i=1:length(SkuMaster(:,1)) 
        
        InvCostPerRun(h) = InvCostPerRun(h) + SkuMaster(i,h).simulatedInventoryCost; 
     
        if SkuMaster(i,h).skuSize == 375 
            InvCost375(h) = InvCost375(h) + SkuMaster(i,h).simulatedInventoryCost;
        
        elseif SkuMaster(i,h).skuSize == 5 
            InvCost5(h) = InvCost5(h) + SkuMaster(i,h).simulatedInventoryCost;
                
        elseif SkuMaster(i,h).skuSize == 1 
            InvCost1(h) = InvCost1(h) + SkuMaster(i,h).simulatedInventoryCost;
        end
        
        
    end
  end
  
  %fill empty array created at beginning
  
  InvCost(1,:) = InvCostPerRun; %/length(SkuMaster(:,1));
  InvCost(2,:) = InvCost375;
  InvCost(3,:) = InvCost5;
  InvCost(4,:) = InvCost1;

end

