function [ SkuMaster, averageFillRate ] = calcFillRate( SkuMaster, workSheetDetail )

% creates empty arrays
averageFillRate=zeros(1,length(SkuMaster(1,:)));
averageFillRate375 = zeros(1,length(SkuMaster(1,:)));
averageFillRate5 = zeros(1,length(SkuMaster(1,:)));
averageFillRate1 = zeros(1,length(SkuMaster(1,:)));

for h=1:length(SkuMaster(:,1)) % for all Skus
    for i=1:length(SkuMaster(h,:)) %for all iterations

        backorderPeriods = sum(SkuMaster(h,i).inventoryPositionHistory <0);
        SkuMaster(h,i).fillRate = (1 - (backorderPeriods/workSheetDetail(1).Weeks)); % every Sku has a fill rate, can see if stategy works for all Skus, or only some

    end
end


for h=1:length(SkuMaster(h,:)) % going through each cell in SkuMaster
    for i=1:length(SkuMaster(:,1)) 
        
        % fill rate in each iteration h for all Skus
        averageFillRate(h) = averageFillRate(h) + SkuMaster(i,h).fillRate; %not really average yet, divide by # of Skus at end
        
        if SkuMaster(i,h).skuSize == 375 
            averageFillRate375(h) = averageFillRate375(h) + SkuMaster(i,h).fillRate;
        
        elseif SkuMaster(i,h).skuSize == 5 
            averageFillRate5(h) = averageFillRate5(h) + SkuMaster(i,h).fillRate;
                
        elseif SkuMaster(i,h).skuSize == 1 
            averageFillRate1(h) = averageFillRate1(h) + SkuMaster(i,h).fillRate;
        end
            
    end
end

  averageFillRate(1,:) = averageFillRate/length(SkuMaster(:,1));
  averageFillRate(2,:) = averageFillRate375/SkuMaster(1,1).countSku375;
  averageFillRate(3,:) = averageFillRate5/SkuMaster(1,1).countSku5;
  averageFillRate(4,:) = averageFillRate1/SkuMaster(1,1).countSku1;

end

