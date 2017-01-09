% Create Demand Function
% Case 1: random sample from the past

function [ SkuMaster] = createDemand(SkuMaster, workSheetDetail)


switch workSheetDetail(1).DataType
    
    case 1 % random sample from cumulative past demand (sampled from entire columns and not from each SKU individually)
        
        for h=1:length(SkuMaster(1,:)) % number of iterations 
            
            for j=1:length(SkuMaster(:,1)) % number of SKU's in the simulation
           
                for i=1:workSheetDetail(1).Weeks       % weeks simulated
                    index = ceil(length(SkuMaster(j,1).customerOrderHistory)*rand); % draw a new sample for each week i
                    % index = randsample(length(SkuMaster(j,1).customerOrderHistory),1); 
                
                    SkuMaster(j,h).demandOverSimulationLength(i) = SkuMaster(j,h).customerOrderHistory(index);
                    
                end
            end
        end
        
    case 2
        
        % Project Arrival ~ Pois + Draw projects 
        % Project in each week > Summarize SKUs and draw like before > How to keep track of projects realized? > Substract projects consecutively and kepp track if not enough SKUs on hand 
        
          
        
        
        
end






end

