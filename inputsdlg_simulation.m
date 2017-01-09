function[Answer, Cancelled]= inputsdlg_simulation()
   
clear; close all;

Title = 'Artaic Simulation Dialog';

%%%% SETTING DIALOG OPTIONS
Options.WindowStyle = 'modal';
Options.Resize = 'on';
Options.Interpreter = 'tex';
Options.CancelButton = 'on';
Options.ApplyButton = 'off';
Options.ButtonNames = {'Simulate','Cancel'}; 
Options.AlignControls = 'off'; % Allign Columns
Option.Dim = 10; % Horizontal dimension in fields

%  Alternatively, PROMPT can have up to 4 columns. The first column sppecifies the prompt string. The second column to specify the struct
%  field names to output ANSWER as a structure. The third column specifies units (i.e., post-fix labels to the right of controls) to display. The
%  fourth column specifies the tooltip string. The tooltip string is ignored for text type.

Prompt = {};
Formats = {};
DefAns = struct([]);

Prompt(1,:) = {'# Iterations:          ', 'Iterations',[]};
Formats(1,1).type = 'edit';
Formats(1,1).format = 'integer';
Formats(1,1).size = 40; % automatically assign the height
DefAns(1).Iterations = 2;

Prompt(end+1,:) = {'Inventory Cost Rate:   ', 'InventoryCostRate','%'};
Formats(1,2).type = 'edit';
Formats(1,2).format = 'integer';
Formats(1,2).size = 40; % automatically assign the height
DefAns.InventoryCostRate = 20;

Prompt(end+1,:) = {'Weeks Simulated:', 'Weeks',[]};
Formats(2,1).type = 'edit';
Formats(2,1).format = 'integer';
Formats(2,1).size = 40; % automatically assign the height
DefAns.Weeks = 52;

Prompt(end+1,:) = {'Backorder Cost Rate: ', 'BackorderCostRate','%'};
Formats(2,2).type = 'edit';
Formats(2,2).format = 'integer';
Formats(2,2).size = 40; % automatically assign the height
DefAns.BackorderCostRate = 20;

Prompt(end+1,:) = {['Choose the tile types you would like to include'],[],[]};
Formats(3,1).type = 'text';
Formats(3,1).size = [-1 0];
Formats(3,1).span = [1 2];

Prompt(end+1,:) = {'0.375 VG' 'Tile375',[]};
Formats(4,1).type = 'check';
DefAns.Tile375 = true;

Prompt(end+1,:) = {'MOQ : ', 'Moq375','in lbs'};
Formats(4,2).type = 'edit';
Formats(4,2).format = 'integer';
Formats(4,2).size = 40; % automatically assign the height
Formats(4,2).unitsloc = 'rightmiddle'; % where the unit label should be placed 
DefAns.Moq375 = 22;

Prompt(end+1,:) = {'  Order cost [MOQ]:', 'ProcurementCost375','$'};
Formats(4,3).type = 'edit';
Formats(4,3).format = 'float';
Formats(4,3).size = 40; % automatically assign the height
DefAns.ProcurementCost375 = 3.70;

Prompt(end+1,:) = {'  # Tiles per lbs: ', 'TilesPerLbs375',[]};
Formats(4,4).type = 'edit';
Formats(4,4).format = 'integer';
Formats(4,4).size = 40; % automatically assign the height
DefAns.TilesPerLbs375 = 660;

Prompt(end+1,:) = {'0.5 SG' 'Tile5',[]};
Formats(6,1).type = 'check';
DefAns.Tile5 = true;

Prompt(end+1,:) = {'MOQ : ', 'Moq5','in kg'};
Formats(6,2).type = 'edit';
Formats(6,2).format = 'integer';
Formats(6,2).size = 40; % automatically assign the height
Formats(6,2).unitsloc = 'rightmiddle'; % where the unit label should be placed 
DefAns.Moq5 = 50;

Prompt(end+1,:) = {'  Order cost [MOQ]:', 'ProcurementCost5','$'};
Formats(6,3).type = 'edit';
Formats(6,3).format = 'float';
Formats(6,3).size = 40; % automatically assign the height
DefAns.ProcurementCost5 = 3.74;

Prompt(end+1,:) = {'  # Tiles per lbs: ', 'TilesPerLbs5',[]};
Formats(6,4).type = 'edit';
Formats(6,4).format = 'integer';
Formats(6,4).size = 40; % automatically assign the height
DefAns.TilesPerLbs5 = 365;

Prompt(end+1,:) = {'1 SG' 'Tile1',[]};
Formats(7,1).type = 'check';
DefAns.Tile1 = true;

Prompt(end+1,:) = {'MOQ : ', 'Moq1','in kg'};
Formats(7,2).type = 'edit';
Formats(7,2).format = 'integer';
Formats(7,2).size = 40; % automatically assign the height
Formats(7,2).unitsloc = 'rightmiddle'; % where the unit label should be placed 
DefAns.Moq1 = 50;

Prompt(end+1,:) = {'  Order cost [MOQ]:', 'ProcurementCost1','$'};
Formats(7,3).type = 'edit';
Formats(7,3).format = 'float';
Formats(7,3).size = 40; % automatically assign the height
DefAns.ProcurementCost1 = 3.74;

Prompt(end+1,:) = {'  # Tiles per lbs: ', 'TilesPerLbs1',[]};
Formats(7,4).type = 'edit';
Formats(7,4).format = 'integer';
Formats(7,4).size = 40; % automatically assign the height
DefAns.TilesPerLbs1 = 84;

Prompt(end+1,:) = {['Choose the file associations: '],[],[]};
Formats(8,1).type = 'text';
Formats(8,1).size = [-1 0];

Prompt(end+1,:) = {'Past Demand:','PastDemand',[]};
Formats(9,1).type = 'edit';
Formats(9,1).format = 'file';
Formats(9,1).items = {'*.xlsx','Excel(*.xlsx)';'*.*','All Files'};
%Formats(9,1).limits = [0 1]; % single file get
%Formats(9,1).size = [-1 0];
%d = dir;
DefAns.PastDemand = 'C:\Users\Michael\Desktop\Artaic\Project 1 - Safety Stock Calculations\0_Matlab_Simulation\Excel\OrderHistory.xlsx';

Prompt(end+1,:) = {'Output File:    ','Output',[]};
Formats(10,1).type = 'edit';
Formats(10,1).format = 'file';
Formats(10,1).items = {'*.xlsx','Excel(*.xlsx)';'*.*','All Files'};
%Formats(10,1).limits = [0 1]; % single file get
%Formats(10,1).size = [-1 0];
%d = dir;
DefAns.Output = 'C:\Users\Michael\Desktop\Artaic\Project 1 - Safety Stock Calculations\0_Matlab_Simulation\Excel\Output.xlsx'; 

Prompt(end+1,:) = {'Include Report' 'Report',[]};
Formats(11,1).type = 'check';
DefAns.Report = false;


[Answer, Cancelled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);

close all

end