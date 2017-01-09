function [ SkuMaster ] = readData(workSheetDetail)

switch workSheetDetail(1).DataType
    
    case 1 %Excel Import
    
        countSku375 = 0;
        countSku5 = 0;
        countSku1 = 0;
        
        
        % Distinguises between String and Numbers
        % numeric: contains the matrix of observed past demand (each column is a part)
        % partname: column of all partnames
        
        % check to include 0.375 of not
        if workSheetDetail(1).Tile375==1
            [numeric375, partname375] = xlsread(workSheetDetail(1).PastDemandPath,1);
            
            for i=1:length(partname375)
                SkuList375(i) = Sku(partname375(i), 375, 'VG', numeric375(i,:), workSheetDetail);
            end
            
            countSku375 = length(partname375);
            SkuList = [SkuList375];
        end
        
        
        if workSheetDetail(1).Tile5==1
            [numeric5, partname5] = xlsread(workSheetDetail(1).PastDemandPath,2);
            
            for i=1:length(partname5)
                SkuList5(i) = Sku(partname5(i), 5, 'SG', numeric5(i,:), workSheetDetail);
            end
            
            if exist('SkuList','var')==1
                SkuList = [SkuList SkuList5];
            else
                SkuList = [SkuList5];
            end
            
            countSku5 = length(partname5);
        end
        
        if workSheetDetail(1).Tile1==1
            [numeric1, partname1] = xlsread(workSheetDetail(1).PastDemandPath,4);
            
            for i=1:length(partname1)
                SkuList1(i) = Sku(partname1(i), 1, 'SG', numeric1(i,:), workSheetDetail);
            end
            
            if exist('SkuList','var')==1
                SkuList = [SkuList SkuList1];
            else
                SkuList = [SkuList1];
            end
            
            countSku1 = length(partname1);
        end
        
        if exist('SkuList','var')==0
            return
        end
        
        
        for i=1:(workSheetDetail(1).Iterations)
            SkuMaster(:,i) = SkuList;
        end
        
        for h=1:length(SkuMaster(:,1))  % how many lines in SkuMaster / length of the column
            for i=1:length(SkuMaster(h,:)) % going through every column / keep line fixed, go through column
                SkuMaster(h,i).countSku375 = countSku375;
                SkuMaster(h,i).countSku5 = countSku5;
                SkuMaster(h,i).countSku1 = countSku1;
                
            end
        end
        
        
        
    case 0 %JSON
        
        jsonStructure = loadjson(workSheetDetail(1).PastDemandPath, 'SimplifyCell',1)
   
        % create Skus instances that have been used in the past 
        % create Project instances to draw from each week in 'createDemand()'
        
    
    SkuMaster = 0
 
end
       
end