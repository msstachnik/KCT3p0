function varargout = KukaGui_V2(varargin)
% KUKAGUI_V2 MATLAB code for KukaGui_V2.fig
%      KUKAGUI_V2, by itself, creates a new KUKAGUI_V2 or raises the existing
%      singleton*.
%
%      H = KUKAGUI_V2 returns the handle to a new KUKAGUI_V2 or the handle to
%      the existing singleton*.
%
%      KUKAGUI_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KUKAGUI_V2.M with the given input arguments.
%
%      KUKAGUI_V2('Property','Value',...) creates a new KUKAGUI_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KukaGui_V2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KukaGui_V2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KukaGui_V2

% Last Modified by GUIDE v2.5 22-May-2015 23:52:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KukaGui_V2_OpeningFcn, ...
                   'gui_OutputFcn',  @KukaGui_V2_OutputFcn, ...
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


% --- Executes just before KukaGui_V2 is made visible.
function KukaGui_V2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KukaGui_V2 (see VARARGIN)

% Choose default command line output for KukaGui_V2
handles.output = hObject;
load KR6R900
handles.KR6R900 = KR6R900;
kctdisprobot(handles.KR6R900)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KukaGui_V2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KukaGui_V2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PB_random_position.
function PB_random_position_Callback(hObject, eventdata, handles)
% hObject    handle to PB_random_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.KR6R900 = ranodm_position(handles.KR6R900); %ustaw losow� pozycje robota
handles.KR6R900 = kctdisprobot(handles.KR6R900);    %zaktualizuj po�o�enie robota
% Update handles structure
guidata(hObject, handles);

function Robot = ranodm_position(Robot)
% Funkcja u�ywana do ustalania losowej pozycji robota
Robot.Joint(1).Value = randp(1, Robot.Joint(1).Min, Robot.Joint(1).Max); %ustalanie losowej pozycji w zalezno�ci od ogranicze�
Robot.Joint(2).Value = randp(1, Robot.Joint(2).Min, Robot.Joint(2).Max);
Robot.Joint(3).Value = randp(1, Robot.Joint(3).Min, Robot.Joint(3).Max);
Robot.Joint(4).Value = randp(1, Robot.Joint(4).Min, Robot.Joint(4).Max);
Robot.Joint(5).Value = randp(1, Robot.Joint(5).Min, Robot.Joint(5).Max);
Robot.Joint(6).Value = randp(1, Robot.Joint(6).Min, Robot.Joint(6).Max);


% --- Executes on slider movement.
function S_Joint1_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(1).Value = get(hObject,'Value');                              % pobierz warto�� z slidera
set(handles.T_Joint1, 'String', num2str(handles.KR6R900.Joint(1).Value, 3));        % zaktualizuj warto�� polu tekstowym

handles.KR6R900 = kctdisprobot(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900                                                                % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Joint(1).Min);
set(hObject, 'Max', KR6R900.Joint(1).Max);
set(hObject, 'Value', KR6R900.Joint(1).Value);
set(hObject, 'String', num2str(KR6R900.Joint(1).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint1.
function T_Joint1_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint1, 'Min');
Max = get(handles.S_Joint1, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(1).Value = str2double(get(hObject,'String'));     % pobierz warto�� 
    set(handles.S_Joint1, 'String', handles.KR6R900.Joint(1).Value);        % zaktualizuj warto�c slidera
    set(handles.S_Joint1, 'Value', handles.KR6R900.Joint(1).Value);         % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint1, 'Value'));                 % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot(handles.KR6R900);                            %zaktualizuj po�o�enie robota
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900                                                                % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'String', num2str(KR6R900.Joint(1).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint2_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.KR6R900.Joint(2).Value = get(hObject,'Value');                              % pobierz warto�� z slidera
set(handles.T_Joint2, 'String', num2str(handles.KR6R900.Joint(2).Value, 3));        % zaktualizuj warto�� polu tekstowym

handles.KR6R900 = kctdisprobot(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_Joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900                                                                % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Joint(2).Min);
set(hObject, 'Max', KR6R900.Joint(2).Max);
set(hObject, 'Value', KR6R900.Joint(2).Value);
set(hObject, 'String', num2str(KR6R900.Joint(2).Value));
guidata(hObject, handles);


function T_Joint2_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Joint2 as text
%        str2double(get(hObject,'String')) returns contents of T_Joint2 as a double
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint2, 'Min');
Max = get(handles.S_Joint2, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(2).Value = str2double(get(hObject,'String'));     % pobierz warto�� 
    set(handles.S_Joint2, 'String', handles.KR6R900.Joint(2).Value);        % zaktualizuj warto�c slidera
    set(handles.S_Joint2, 'Value', handles.KR6R900.Joint(2).Value);         % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint2, 'Value'));                 % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot(handles.KR6R900);                            %zaktualizuj po�o�enie robota
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
load KR6R900                                                                % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'String', num2str(KR6R900.Joint(2).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint3_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(3).Value = get(hObject,'Value');                              % pobierz warto�� z slidera
set(handles.T_Joint3, 'String', num2str(handles.KR6R900.Joint(3).Value, 3));        % zaktualizuj warto�� polu tekstowym

handles.KR6R900 = kctdisprobot(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900                                                                % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Joint(3).Min);
set(hObject, 'Max', KR6R900.Joint(3).Max);
set(hObject, 'Value', KR6R900.Joint(3).Value);
set(hObject, 'String', num2str(KR6R900.Joint(3).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint3.
function T_Joint3_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint3, 'Min');
Max = get(handles.S_Joint3, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(3).Value = str2double(get(hObject,'String'));     % pobierz warto�� 
    set(handles.S_Joint3, 'String', handles.KR6R900.Joint(3).Value);        % zaktualizuj warto�c slidera
    set(handles.S_Joint3, 'Value', handles.KR6R900.Joint(3).Value);         % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint3, 'Value'));                 % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot(handles.KR6R900);                            %zaktualizuj po�o�enie robota
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900                                                                % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'String', num2str(KR6R900.Joint(3).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint4_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function S_Joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function T_Joint4_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Joint4 as text
%        str2double(get(hObject,'String')) returns contents of T_Joint4 as a double


% --- Executes during object creation, after setting all properties.
function T_Joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function S_Joint5_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function S_Joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function T_Joint5_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Joint5 as text
%        str2double(get(hObject,'String')) returns contents of T_Joint5 as a double


% --- Executes during object creation, after setting all properties.
function T_Joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function S_Joint6_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function S_Joint6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function T_Joint6_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Joint6 as text
%        str2double(get(hObject,'String')) returns contents of T_Joint6 as a double


% --- Executes during object creation, after setting all properties.
function T_Joint6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
