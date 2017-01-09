function [ SkuMaster, shippingCost ] = calculateShippingCost(SkuMaster)

variableShippingCostPerIterationTotal = zeros(1,length(SkuMaster(1,:))); % total variable shipping cost in each iteration i
variableShippingCostPerIteration375 = zeros(1,length(SkuMaster(1,:)));
variableShippingCostPerIteration5 = zeros(1,length(SkuMaster(1,:)));
variableShippingCostPerIteration1 = zeros(1,length(SkuMaster(1,:)));

fixedShippingCostPerIterationTotal = zeros(1,length(SkuMaster(1,:))); % total fixed shipping cost in each iteration i
fixedShippingCostPerIteration375 = zeros(1,length(SkuMaster(1,:)));
fixedShippingCostPerIteration5 = zeros(1,length(SkuMaster(1,:)));
fixedShippingCostPerIteration1 = zeros(1,length(SkuMaster(1,:)));

totalOrdersInPeriod375 = zeros(length(SkuMaster(1,:)), length(SkuMaster(1,1).orders(:)));   % Total amount of VG orders placed in each week j, for each iteration i over all SKUs
totalOrdersInPeriod5 = zeros(length(SkuMaster(1,:)), length(SkuMaster(1,1).orders(:)));   %
totalOrdersInPeriod1 = zeros(length(SkuMaster(1,:)), length(SkuMaster(1,1).orders(:))); 

airComparison = zeros(1,length(SkuMaster(1,:))); % costs occured for air shipping

% calculate order amount in lbs in each iteration and week 
for i=1:1 %length(SkuMaster(1,:))  
    for h=1:length(SkuMaster(:,1)) 
        for j=1:length(SkuMaster(h,i).orders(:))
          
            if SkuMaster(h,i).skuSize == 375
               
                totalOrdersInPeriod375(i,j) = totalOrdersInPeriod375(i,j) + SkuMaster(h,i).orders(j).orderAmount;
                    
            elseif SkuMaster(h,i).skuSize == 5
                
                totalOrdersInPeriod5(i,j) = totalOrdersInPeriod5(i,j) + SkuMaster(h,i).orders(j).orderAmount;
                
            elseif SkuMaster(h,i).skuSize == 1
            
                totalOrdersInPeriod1(i,j) = totalOrdersInPeriod1(i,j) + SkuMaster(h,i).orders(j).orderAmount;
            
            end
        end
    end
end

% totalOrdersInPeriod5(:,13:39)
% totalOrdersInPeriod375(:,13:39)
% totalOrdersInPeriod1(:,13:39)



% calculate variable shipping costs

for i=1:1 %length(SkuMaster(1,:)) 
 
    variableShippingCostPerIteration375(i) = variableCostVG(sum(totalOrdersInPeriod375(i,:)));
    variableShippingCostPerIteration5(i) = variableCostSG(sum(totalOrdersInPeriod5(i,:)));
    variableShippingCostPerIteration1(i) = variableCostSG(sum(totalOrdersInPeriod1(i,:)));
    variableShippingCostPerIterationTotal(i) = variableShippingCostPerIteration375(i) +  variableShippingCostPerIteration5(i) +  variableShippingCostPerIteration1(i);
    
end


% calculate fixed shipping costs

for i=1:length(SkuMaster(1,:))
    
    fixedShippingCostPerIteration375(i) = sum(totalOrdersInPeriod375(i,:)>0)* 667.5;
        
    for j=1:length(SkuMaster(1,1).orders(:))
        
        if totalOrdersInPeriod5(i,j)>0 && totalOrdersInPeriod1(i,j)>0 % 5SG and 1SG are sharing fixed costs
            
            fixedShippingCostPerIteration5(i) = fixedShippingCostPerIteration5(i) + 375/2;
            fixedShippingCostPerIteration1(i) = fixedShippingCostPerIteration1(i) + 375/2;
            
        elseif totalOrdersInPeriod5(i,j)>0
          
            fixedShippingCostPerIteration5(i) = fixedShippingCostPerIteration5(i) + 375;
            
        elseif totalOrdersInPeriod1(i,j)>0
                
            fixedShippingCostPerIteration1(i) = fixedShippingCostPerIteration1(i) + 375;
        end
    end
   
    fixedShippingCostPerIterationTotal(i) = fixedShippingCostPerIteration375(i) +  fixedShippingCostPerIteration5(i) +  fixedShippingCostPerIteration1(i);

    %airComparison
    
end


shippingCost(1,:) = variableShippingCostPerIterationTotal + fixedShippingCostPerIterationTotal; 
shippingCost(2,:) = variableShippingCostPerIteration375 + fixedShippingCostPerIteration375;
shippingCost(3,:) = variableShippingCostPerIteration5 + fixedShippingCostPerIteration5;
shippingCost(4,:) = variableShippingCostPerIteration1 + fixedShippingCostPerIteration1;
shippingCost(5,:) = airComparison;

end

function [cost] = variableCostSG(weight)
    
    weight = weight/2.20462; % calculate to kg to yield cost formula below that expects kg

    cost =  max(weight*285/1000,325)+max(weight*116/1000,116)+max(weight*125/1000,125)+max(weight*58/1000,118)+weight*45/1000+weight*3/1000;
end

function [cost] = variableCostVG(weight)

    weight = weight/2.20462; % calculate to kg to yield cost formula below that expects kg

    cost = max(weight*6/1000,6)+max(weight*3/1000,3)+max(weight*25/1000,50)+max(weight*2/363,2)+max(weight*35/1000,100)+max(weight*14.95/1000,96.8)+60/1000*weight+0.15*(60/1000*weight);
end

