function PlotInExcel(fileName, sheet, x, DataY, DataZ, DataZZ)
%Decription: This script lets you save your plot in Excel
%Aut her: Amit Doshi


% Plotting to make sure that you have right plot
      plot(x,DataY, x, DataZ, x, DataZZ);
      xlabel('Week');
      ylabel('Inventory Level');
      print -dmeta;                             %Copying to clipboard
      
% Excel file path and Name

try
     SheetName = ' Results'; 
     SheetIndex = sheet;
     Range = 'K2'; 
     
% ------------- Excel COM object ----------------------
     
    Excel = actxserver ('Excel.Application');
     Excel.Visible = 0;

     invoke(Excel.Workbooks,'Open',fileName);       % Open the file
     Sheets = Excel.ActiveWorkBook.Sheets;
     if gt(SheetIndex,3)
         for i=1:SheetIndex-3
            Excel.ActiveWorkBook.Sheets.Add;
         end
      
     end 
        ActiveSheet = get(Sheets, 'Item', SheetIndex);
     
     set(ActiveSheet,'Name',SheetName)
     ActiveSheet.Select;
     ActivesheetRange = get(ActiveSheet,'Range',Range);
     ActivesheetRange.Select;
     ActivesheetRange.PasteSpecial;                 % Pasting the figure to the selected location
     Excel.ActiveWorkbook.Save                      % Now save the workbook
     
     if eq(Excel.ActiveWorkbook.Saved,1)
         Excel.ActiveWorkbook.Close;
     else
         Excel.ActiveWorkbook.Save;
     end
     
     invoke(Excel, 'Quit');                         % Quit Excel
     delete(Excel);                                 % End process
     close gcf;

catch
    msgbox(lasterr)

end

 

