function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 12-Feb-2016 10:58:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = get(handles.editIterations,'String');


% --- Executes on button press in pushbutton_simulate.
function pushbutton_simulate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% reading data from GUI
var = get(handles.editIterations, 'String');
iterations = str2double(var);

var = get(handles.editInventoryCostRate, 'String');
inventoryCostRate = str2double(var);

var = get(handles.editWeeks, 'String');
weeks = str2double(var);

include375 = get(handles.checkboxInclude375, 'Value');
include5 = get(handles.checkboxInclude5, 'Value');
include1 = get(handles.checkboxInclude1, 'Value');

var = get(handles.editMoq375, 'String');
moq375 = str2double(var);
var = get(handles.editMoq5, 'String');
moq5 = str2double(var);
var = get(handles.editMoq1, 'String');
moq1 = str2double(var);

var = get(handles.editOrderCost375, 'String');
orderCost375 = str2double(var);
var = get(handles.editOrderCost5, 'String');
orderCost5 = str2double(var);
var = get(handles.editOrderCost1, 'String');
orderCost1 = str2double(var);

var = get(handles.editTiles375, 'String');
tiles375 = str2double(var);
var = get(handles.editTiles5, 'String');
tiles5 = str2double(var);
var = get(handles.editTiles1, 'String');
tiles1 = str2double(var);

pastDemandPath = get(handles.editPastDemandPath, 'String');
reportPath = get(handles.editReportPath, 'String');

inventoryType = get(handles.popupmenuInventoryType, 'Value');

dataType = get(handles.radiobuttonExcel, 'Value');

report = get(handles.checkboxReport, 'Value');

var = get(handles.editReorderInterval, 'String');
reorderInterval = str2double(var);

orderStrategy = get(handles.popupmenuOrderStrategy, 'Value');


workSheetDetail = struct('DataType', dataType, 'OrderStrategy', orderStrategy, 'ReorderInterval', reorderInterval, 'InventoryType', inventoryType, 'Iterations', iterations, 'InventoryCostRate', inventoryCostRate, 'Weeks', weeks, 'Tile375', include375, 'Moq375', moq375, 'ProcurementCost375', orderCost375,'TilesPerLbs375', tiles375, 'Tile5', include5, 'Moq5', moq5, 'ProcurementCost5', orderCost5, 'TilesPerLbs5', tiles5, 'Tile1', include1, 'Moq1', moq1, 'ProcurementCost1', orderCost1, 'TilesPerLbs1', tiles1, 'PastDemandPath', pastDemandPath, 'Output', reportPath, 'Report', report);

test

% ----------- starting simulation-------------

% make simulation results available to all functions
global simulationReturn; 

set(handles.text_info,'String', 'Simulating');
drawnow(); % updates queue of graphic events

simulationReturn = main_simulation(workSheetDetail);

% returning values to GUI

set(handles.textInventoryCost,'String', round(simulationReturn(1).meanInventoryCost));
set(handles.textMinInvCost,'String', round(simulationReturn(1).minInventoryCost));
set(handles.textMaxInvCost,'String', round(simulationReturn(1).maxInventoryCost));

set(handles.textInventoryCost375,'String', round(simulationReturn(1).meanInventoryCost375));
set(handles.textMinInvCost375,'String', round(simulationReturn(1).minInventoryCost375));
set(handles.textMaxInvCost375,'String', round(simulationReturn(1).maxInventoryCost375));

set(handles.textInventoryCost5,'String', round(simulationReturn(1).meanInventoryCost5));
set(handles.textMinInvCost5,'String', round(simulationReturn(1).minInventoryCost5));
set(handles.textMaxInvCost5,'String', round(simulationReturn(1).maxInventoryCost5));

set(handles.textInventoryCost1,'String', round(simulationReturn(1).meanInventoryCost1));
set(handles.textMinInvCost1,'String', round(simulationReturn(1).minInventoryCost1));
set(handles.textMaxInvCost1,'String', round(simulationReturn(1).maxInventoryCost1));

set(handles.textFillRate375,'String', round(simulationReturn(1).FillRate375*100));
set(handles.textFillRate5,'String', round(simulationReturn(1).FillRate5*100));
set(handles.textFillRate1,'String', round(simulationReturn(1).FillRate1*100));
set(handles.textFillRateTotal,'String', round(simulationReturn(1).FillRateTotal*100));

set(handles.textShippingCost375,'String', round(simulationReturn(1).shippingCostTotal375));
set(handles.textShippingCost5,'String', round(simulationReturn(1).shippingCostTotal5));
set(handles.textShippingCost1,'String', round(simulationReturn(1).shippingCostTotal1));
set(handles.textShippingCostTotal,'String', round(simulationReturn(1).shippingCostTotal));
set(handles.textSeaSavings,'String', round(simulationReturn(1).shippingAirSavings));


%importing SKU identifier into listbox element
for i = 1:length(simulationReturn(1).skuMaster(:,1))  
    SkuList(i) = simulationReturn(1).skuMaster(i,1).name;
end
SkuList = transpose(SkuList);
set(handles.SKU_listbox,'String',SkuList)

%importing the years into listbox element
for i = 1:length(simulationReturn(1).skuMaster(1,:))  
    YearList(i) = i;
end
set(handles.Year_listbox,'String',YearList)


% print label that simulation calculation is over
set(handles.text_info,'String', simulationReturn(1).simulationOver);


% --- Executes on button press in pushbutton_calculateOrder.
function pushbutton_calculateOrder_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculateOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% reading data from GUI

% reading data from GUI
var = get(handles.editIterations, 'String');
iterations = str2double(var);

var = get(handles.editInventoryCostRate, 'String');
inventoryCostRate = str2double(var);

var = get(handles.editWeeks, 'String');
weeks = str2double(var);

include375 = get(handles.checkboxInclude375, 'Value');
include5 = get(handles.checkboxInclude5, 'Value');
include1 = get(handles.checkboxInclude1, 'Value');

var = get(handles.editMoq375, 'String');
moq375 = str2double(var);
var = get(handles.editMoq5, 'String');
moq5 = str2double(var);
var = get(handles.editMoq1, 'String');
moq1 = str2double(var);

var = get(handles.editOrderCost375, 'String');
orderCost375 = str2double(var);
var = get(handles.editOrderCost5, 'String');
orderCost5 = str2double(var);
var = get(handles.editOrderCost1, 'String');
orderCost1 = str2double(var);

var = get(handles.editTiles375, 'String');
tiles375 = str2double(var);
var = get(handles.editTiles5, 'String');
tiles5 = str2double(var);
var = get(handles.editTiles1, 'String');
tiles1 = str2double(var);

pastDemandPath = get(handles.editPastDemandPath, 'String');
reportPath = get(handles.editReportPath, 'String');

inventoryType = get(handles.popupmenuInventoryType, 'Value');

dataType = get(handles.radiobuttonExcel, 'Value');

report = get(handles.checkboxReport, 'Value');

var = get(handles.editReorderInterval, 'String');
reorderInterval = str2double(var);

orderStrategy = get(handles.popupmenuOrderStrategy, 'Value');

workSheetDetail = struct('DataType', dataType, 'OrderStrategy', orderStrategy, 'ReorderInterval', reorderInterval, 'InventoryType', inventoryType, 'Iterations', iterations, 'InventoryCostRate', inventoryCostRate, 'Weeks', weeks, 'Tile375', include375, 'Moq375', moq375, 'ProcurementCost375', orderCost375,'TilesPerLbs375', tiles375, 'Tile5', include5, 'Moq5', moq5, 'ProcurementCost5', orderCost5, 'TilesPerLbs5', tiles5, 'Tile1', include1, 'Moq1', moq1, 'ProcurementCost1', orderCost1, 'TilesPerLbs1', tiles1, 'PastDemandPath', pastDemandPath, 'Output', reportPath, 'Report', report);

% starting main_orderCalculation
set(handles.text_info,'String', 'Calculating Order');
drawnow(); % updates queue of graphic events
main_orderCalculation(workSheetDetail);


set(handles.text_info,'String', 'Calculation Over');







% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel1 is resized.
function uipanel1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editIterations_Callback(hObject, eventdata, handles)
% hObject    handle to editIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIterations as text
%        str2double(get(hObject,'String')) returns contents of editIterations as a double



% --- Executes during object creation, after setting all properties.
function editIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWeeks_Callback(hObject, eventdata, handles)
% hObject    handle to editWeeks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWeeks as text
%        str2double(get(hObject,'String')) returns contents of editWeeks as a double


% --- Executes during object creation, after setting all properties.
function editWeeks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWeeks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInventoryCostRate_Callback(hObject, eventdata, handles)
% hObject    handle to editInventoryCostRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInventoryCostRate as text
%        str2double(get(hObject,'String')) returns contents of editInventoryCostRate as a double


% --- Executes during object creation, after setting all properties.
function editInventoryCostRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInventoryCostRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBackorderCostRate_Callback(hObject, eventdata, handles)
% hObject    handle to editBackorderCostRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBackorderCostRate as text
%        str2double(get(hObject,'String')) returns contents of editBackorderCostRate as a double


% --- Executes during object creation, after setting all properties.
function editBackorderCostRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBackorderCostRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuDataType.
function popupmenuDataType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuDataType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuDataType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuDataType


% --- Executes during object creation, after setting all properties.
function popupmenuDataType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuDataType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxInclude1.
function checkboxInclude1_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxInclude1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxInclude1



function editMoq1_Callback(hObject, eventdata, handles)
% hObject    handle to editMoq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMoq1 as text
%        str2double(get(hObject,'String')) returns contents of editMoq1 as a double


% --- Executes during object creation, after setting all properties.
function editMoq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMoq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOrderCost1_Callback(hObject, eventdata, handles)
% hObject    handle to editOrderCost1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOrderCost1 as text
%        str2double(get(hObject,'String')) returns contents of editOrderCost1 as a double


% --- Executes during object creation, after setting all properties.
function editOrderCost1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOrderCost1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTiles1_Callback(hObject, eventdata, handles)
% hObject    handle to editTiles1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTiles1 as text
%        str2double(get(hObject,'String')) returns contents of editTiles1 as a double


% --- Executes during object creation, after setting all properties.
function editTiles1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTiles1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxInclude375.
function checkboxInclude375_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxInclude375 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxInclude375



function editMoq375_Callback(hObject, eventdata, handles)
% hObject    handle to editMoq375 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMoq375 as text
%        str2double(get(hObject,'String')) returns contents of editMoq375 as a double


% --- Executes during object creation, after setting all properties.
function editMoq375_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMoq375 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOrderCost375_Callback(hObject, eventdata, handles)
% hObject    handle to editOrderCost375 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOrderCost375 as text
%        str2double(get(hObject,'String')) returns contents of editOrderCost375 as a double


% --- Executes during object creation, after setting all properties.
function editOrderCost375_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOrderCost375 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTiles375_Callback(hObject, eventdata, handles)
% hObject    handle to editTiles375 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTiles375 as text
%        str2double(get(hObject,'String')) returns contents of editTiles375 as a double


% --- Executes during object creation, after setting all properties.
function editTiles375_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTiles375 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxInclude5.
function checkboxInclude5_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxInclude5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxInclude5



function editMoq5_Callback(hObject, eventdata, handles)
% hObject    handle to editMoq5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMoq5 as text
%        str2double(get(hObject,'String')) returns contents of editMoq5 as a double


% --- Executes during object creation, after setting all properties.
function editMoq5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMoq5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOrderCost5_Callback(hObject, eventdata, handles)
% hObject    handle to editOrderCost5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOrderCost5 as text
%        str2double(get(hObject,'String')) returns contents of editOrderCost5 as a double


% --- Executes during object creation, after setting all properties.
function editOrderCost5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOrderCost5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTiles5_Callback(hObject, eventdata, handles)
% hObject    handle to editTiles5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTiles5 as text
%        str2double(get(hObject,'String')) returns contents of editTiles5 as a double


% --- Executes during object creation, after setting all properties.
function editTiles5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTiles5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxReport.
function checkboxReport_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxReport



function editPastDemandPath_Callback(hObject, eventdata, handles)
% hObject    handle to editPastDemandPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPastDemandPath as text
%        str2double(get(hObject,'String')) returns contents of editPastDemandPath as a double


% --- Executes during object creation, after setting all properties.
function editPastDemandPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPastDemandPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editReportPath_Callback(hObject, eventdata, handles)
% hObject    handle to editReportPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editReportPath as text
%        str2double(get(hObject,'String')) returns contents of editReportPath as a double


% --- Executes during object creation, after setting all properties.
function editReportPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editReportPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pushbuttonPastDemandSelect.
function pushbuttonPastDemandSelect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPastDemandSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.xlsx;*.xls; *.json','Excel/JSON (*.xlsx, *.xls, *.json)';'*.*','All Files'},'Choose Demand History Data File');
set(handles.editPastDemandPath,'String',strcat(pathname,filename));



% --- Executes on button press in pushbuttonReportSelect.
function pushbuttonReportSelect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonReportSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.xlsx;*.xls','Excel (*.xlsx, *.xls)';'*.*','All Files'},'Choose Demand History Data File');
set(handles.editReportPath,'String',strcat(pathname,filename));


% --- Executes on selection change in popupmenuInventoryType.
function popupmenuInventoryType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuInventoryType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuInventoryType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuInventoryType


% --- Executes during object creation, after setting all properties.
function popupmenuInventoryType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuInventoryType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editOpportunities_Callback(hObject, eventdata, handles)
% hObject    handle to editOpportunities (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOpportunities as text
%        str2double(get(hObject,'String')) returns contents of editOpportunities as a double


% --- Executes during object creation, after setting all properties.
function editOpportunities_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOpportunities (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editInventory_Callback(hObject, eventdata, handles)
% hObject    handle to editInventory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInventory as text
%        str2double(get(hObject,'String')) returns contents of editInventory as a double


% --- Executes during object creation, after setting all properties.
function editInventory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInventory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8



function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit43_Callback(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit43 as text
%        str2double(get(hObject,'String')) returns contents of edit43 as a double


% --- Executes during object creation, after setting all properties.
function edit43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editReorderInterval_Callback(hObject, eventdata, handles)
% hObject    handle to editReorderInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editReorderInterval as text
%        str2double(get(hObject,'String')) returns contents of editReorderInterval as a double


% --- Executes during object creation, after setting all properties.
function editReorderInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editReorderInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuOrderStrategy.
function popupmenuOrderStrategy_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuOrderStrategy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuOrderStrategy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuOrderStrategy


% --- Executes during object creation, after setting all properties.
function popupmenuOrderStrategy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuOrderStrategy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit44_Callback(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit44 as text
%        str2double(get(hObject,'String')) returns contents of edit44 as a double


% --- Executes during object creation, after setting all properties.
function edit44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function SKU_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SKU_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'));
    set(hObject,'BackgroundColor','white');
end  

% populates the listbox on creation of GUI
    


% --- Executes on selection change in SKU_listbox.
function SKU_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to SKU_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% make the simulations results available to all funtions
global simulationReturn
global skuIndex
global iterationIndex

% extract what has been selected in the listbox
contents = cellstr(get(hObject,'String'));
stringSelected = contents{get(hObject,'Value')};

[tf, skuIndex] = ismember(stringSelected, contents);

% number of weeks simulated
weeks = str2num(get(handles.editWeeks, 'String'));

axes(handles.axes1);
x=1:weeks;
plot(x, simulationReturn(1).skuMaster(skuIndex,iterationIndex).demandOverSimulationLength, x,simulationReturn(1).skuMaster(skuIndex,iterationIndex).backorderHistory, x,simulationReturn(1).skuMaster(skuIndex,iterationIndex).inventoryPositionHistory);
legend('Demand','Backorder', 'Inventory Position', 'Location','southoutside','Orientation','horizontal');




% Hints: contents = cellstr(get(hObject,'String')) returns SKU_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SKU_listbox


% --- Executes on selection change in Year_listbox.
function Year_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to Year_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global simulationReturn
global skuIndex
global iterationIndex

% extract what has been selected in the listbox
contents = cellstr(get(hObject,'String'));
iterationIndex =str2num(contents{get(hObject,'Value')});

% number of weeks simulated
weeks = str2num(get(handles.editWeeks, 'String'));

axes(handles.axes1);
x=1:weeks; 
plot(x, simulationReturn(1).skuMaster(skuIndex,iterationIndex).demandOverSimulationLength, x,simulationReturn(1).skuMaster(skuIndex,iterationIndex).backorderHistory, x,simulationReturn(1).skuMaster(skuIndex,iterationIndex).inventoryPositionHistory);
legend('Demand','Backorder', 'Inventory Position', 'Location','southoutside','Orientation','horizontal');





% --- Executes during object creation, after setting all properties.
function Year_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Year_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'));
    set(hObject,'BackgroundColor','white');
end



function edit54_Callback(hObject, eventdata, handles)
% hObject    handle to edit54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit54 as text
%        str2double(get(hObject,'String')) returns contents of edit54 as a double


% --- Executes during object creation, after setting all properties.
function edit54_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'));
    set(hObject,'BackgroundColor','white');
end



function edit53_Callback(hObject, eventdata, handles)
% hObject    handle to edit53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit53 as text
%        str2double(get(hObject,'String')) returns contents of edit53 as a double


% --- Executes during object creation, after setting all properties.
function edit53_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit52_Callback(hObject, eventdata, handles)
% hObject    handle to edit52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit52 as text
%        str2double(get(hObject,'String')) returns contents of edit52 as a double


% --- Executes during object creation, after setting all properties.
function edit52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10
