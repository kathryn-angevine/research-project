classdef SupplierOrder  % array of SupplierOrders makeup 'orders' attribute of Sku

	properties
	
    timePlaced;
	timeExpected;
    timeArrived;
    orderAmount;
    orderCost;
    
    
    end
    
    methods
        function obj = SupplierOrder(timePlaced, orderAmount, Sku)
            
            if nargin~=0 % if not zero, allows you to create empty SupplierOrder objects
                obj.timePlaced = timePlaced;
                obj.timeExpected = timePlaced+7; % replace 7 with leadTime variable input from GUI
                obj.timeArrived = obj.timeExpected; % can add random delay(probably distribution of plus/minus one week here to simulate supplier backlog
                obj.orderAmount = calcOrderAmount(orderAmount, Sku);
            end
            
        end
    end
    
end

function [orderAmount] = calcOrderAmount(orderAmountNeeded, Sku)

% orderAmount in number of tiles
orderAmount = ceil(orderAmountNeeded/Sku.tilesPerWeight/Sku.moq)*Sku.moq; %moq really batch size, ceil rounds up to batch size

end