function varargout = KukaGui_V4(varargin)
% KUKAGUI_V4 MATLAB code for KukaGui_V4.fig
%      KUKAGUI_V4, by itself, creates a new KUKAGUI_V4 or raises the existing
%      singleton*.
%
%      H = KUKAGUI_V4 returns the handle to a new KUKAGUI_V4 or the handle to
%      the existing singleton*.
%
%      KUKAGUI_V4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KUKAGUI_V4.M with the given input arguments.
%
%      KUKAGUI_V4('Property','Value',...) creates a new KUKAGUI_V4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KukaGui_V4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KukaGui_V4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KukaGui_V4

% Last Modified by GUIDE v2.5 31-May-2015 22:49:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KukaGui_V4_OpeningFcn, ...
                   'gui_OutputFcn',  @KukaGui_V4_OutputFcn, ...
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


% --- Executes just before KukaGui_V4 is made visible.
function KukaGui_V4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KukaGui_V4 (see VARARGIN)

% Choose default command line output for KukaGui_V4
handles.output = hObject;
load KR6R900_V4
handles.KR6R900 = KR6R900;
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);

handles.mess.AXIS_ACT=[0;0;0;13;0;0;10;36;65;88;73;83;95;65;67;84];                 % wiadomo�c o rz�danie pozycji przeg�b�w
handles.mess.POS_ACT=[0;0;0;12;0;0;9;36;80;79;83;32;65;67;84];  

set(handles.RobotDisplay,'Value',1);
handles.CommunicationSts = 0; %no communication
% Update handles structure
guidata(hObject, handles);
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector


% UIWAIT makes KukaGui_V4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KukaGui_V4_OutputFcn(hObject, eventdata, handles) 
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

handles.KR6R900 = ranodm_position(handles.KR6R900);                                 %ustaw losow� pozycje robota
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
% Update handles structure
guidata(hObject, handles);
update_panels(handles)                                                              %zaktualizuj wartosci sliders panel
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector


function Robot = ranodm_position(Robot)
% Funkcja u�ywana do ustalania losowej pozycji robota
Robot.Joint(1).Value = randp(1, Robot.Joint(1).Min, Robot.Joint(1).Max);            %ustalanie losowej pozycji w zalezno�ci od ogranicze�
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

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);   
%zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
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
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
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
    handles.KR6R900.Joint(1).Value = str2double(get(hObject,'String'));             % pobierz warto�� 
    set(handles.S_Joint1, 'String', handles.KR6R900.Joint(1).Value);                % zaktualizuj warto�c slidera
    set(handles.S_Joint1, 'Value', handles.KR6R900.Joint(1).Value);                 % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint1, 'Value'));                         % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
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

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
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
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
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
    handles.KR6R900.Joint(2).Value = str2double(get(hObject,'String'));             % pobierz warto�� 
    set(handles.S_Joint2, 'String', handles.KR6R900.Joint(2).Value);                % zaktualizuj warto�c slidera
    set(handles.S_Joint2, 'Value', handles.KR6R900.Joint(2).Value);                 % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint2, 'Value'));                         % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
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
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
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

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
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
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
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
    handles.KR6R900.Joint(3).Value = str2double(get(hObject,'String'));             % pobierz warto�� 
    set(handles.S_Joint3, 'String', handles.KR6R900.Joint(3).Value);                % zaktualizuj warto�c slidera
    set(handles.S_Joint3, 'Value', handles.KR6R900.Joint(3).Value);                 % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint3, 'Value'));                         % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'String', num2str(KR6R900.Joint(3).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint4_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(4).Value = get(hObject,'Value');                              % pobierz warto�� z slidera
set(handles.T_Joint4, 'String', num2str(handles.KR6R900.Joint(4).Value, 3));        % zaktualizuj warto�� polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Joint(4).Min);
set(hObject, 'Max', KR6R900.Joint(4).Max);
set(hObject, 'Value', KR6R900.Joint(4).Value);
set(hObject, 'String', num2str(KR6R900.Joint(4).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint4.
function T_Joint4_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint4, 'Min');
Max = get(handles.S_Joint4, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(4).Value = str2double(get(hObject,'String'));             % pobierz warto�� 
    set(handles.S_Joint4, 'String', handles.KR6R900.Joint(4).Value);                % zaktualizuj warto�c slidera
    set(handles.S_Joint4, 'Value', handles.KR6R900.Joint(4).Value);                 % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint4, 'Value'));                         % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'String', num2str(KR6R900.Joint(4).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint5_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(5).Value = get(hObject,'Value');                              % pobierz warto�� z slidera
set(handles.T_Joint5, 'String', num2str(handles.KR6R900.Joint(5).Value, 3));        % zaktualizuj warto�� polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Joint(5).Min);
set(hObject, 'Max', KR6R900.Joint(5).Max);
set(hObject, 'Value', KR6R900.Joint(5).Value);
set(hObject, 'String', num2str(KR6R900.Joint(5).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint5.
function T_Joint5_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint5, 'Min');
Max = get(handles.S_Joint5, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(5).Value = str2double(get(hObject,'String'));             % pobierz warto�� 
    set(handles.S_Joint5, 'String', handles.KR6R900.Joint(5).Value);                % zaktualizuj warto�c slidera
    set(handles.S_Joint5, 'Value', handles.KR6R900.Joint(5).Value);                 % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint5, 'Value'));                         % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'String', num2str(KR6R900.Joint(5).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint6_Callback(hObject, eventdata, handles)
% hObject    handle to S_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(6).Value = get(hObject,'Value');                              % pobierz warto�� z slidera
set(handles.T_Joint6, 'String', num2str(handles.KR6R900.Joint(6).Value, 3));        % zaktualizuj warto�� polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Joint(6).Min);
set(hObject, 'Max', KR6R900.Joint(6).Max);
set(hObject, 'Value', KR6R900.Joint(6).Value);
set(hObject, 'String', num2str(KR6R900.Joint(6).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint6.
function T_Joint6_Callback(hObject, eventdata, handles)
% hObject    handle to T_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint6, 'Min');
Max = get(handles.S_Joint6, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(6).Value = str2double(get(hObject,'String'));             % pobierz warto�� 
    set(handles.S_Joint6, 'String', handles.KR6R900.Joint(6).Value);                % zaktualizuj warto�c slidera
    set(handles.S_Joint6, 'Value', handles.KR6R900.Joint(6).Value);                 % zaktualizuj warto�c slidera
else
    set(hObject, 'String', get(handles.S_Joint6, 'Value'));                         % obs�uga b��dnej warto�ci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function T_Joint6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'String', num2str(KR6R900.Joint(6).Value));
guidata(hObject, handles);


% --- Executes on button press in Home.
function Home_Callback(hObject, eventdata, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load KR6R900_V4
handles.KR6R900 = KR6R900;
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);
guidata(hObject, handles);
update_panels(handles)                                                              %zaktualizuj wartosci sliders panel
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector

function update_panels(handles)

precision = 5;
set(handles.S_Joint1, 'String', handles.KR6R900.Joint(1).Value);                    % zaktualizuj warto�c slidera
set(handles.S_Joint1, 'Value', handles.KR6R900.Joint(1).Value);                     % zaktualizuj warto�c slidera
set(handles.T_Joint1, 'String', num2str(handles.KR6R900.Joint(1).Value, precision));        % zaktualizuj warto�� polu tekstowym

set(handles.S_Joint2, 'String', handles.KR6R900.Joint(2).Value);                    % zaktualizuj warto�c slidera
set(handles.S_Joint2, 'Value', handles.KR6R900.Joint(2).Value);                     % zaktualizuj warto�c slidera
set(handles.T_Joint2, 'String', num2str(handles.KR6R900.Joint(2).Value, precision));        % zaktualizuj warto�� polu tekstowym

set(handles.S_Joint3, 'String', handles.KR6R900.Joint(3).Value);                    % zaktualizuj warto�c slidera
set(handles.S_Joint3, 'Value', handles.KR6R900.Joint(3).Value);                     % zaktualizuj warto�c slidera
set(handles.T_Joint3, 'String', num2str(handles.KR6R900.Joint(3).Value, precision));        % zaktualizuj warto�� polu tekstowym

set(handles.S_Joint4, 'String', handles.KR6R900.Joint(4).Value);                    % zaktualizuj warto�c slidera
set(handles.S_Joint4, 'Value', handles.KR6R900.Joint(4).Value);                     % zaktualizuj warto�c slidera
set(handles.T_Joint4, 'String', num2str(handles.KR6R900.Joint(4).Value, precision));        % zaktualizuj warto�� polu tekstowym

set(handles.S_Joint5, 'String', handles.KR6R900.Joint(5).Value);                    % zaktualizuj warto�c slidera
set(handles.S_Joint5, 'Value', handles.KR6R900.Joint(5).Value);                     % zaktualizuj warto�c slidera
set(handles.T_Joint5, 'String', num2str(handles.KR6R900.Joint(5).Value, precision));        % zaktualizuj warto�� polu tekstowym

set(handles.S_Joint6, 'String', handles.KR6R900.Joint(6).Value);                    % zaktualizuj warto�c slidera
set(handles.S_Joint6, 'Value', handles.KR6R900.Joint(6).Value);                     % zaktualizuj warto�c slidera
set(handles.T_Joint6, 'String', num2str(handles.KR6R900.Joint(6).Value, precision));        % zaktualizuj warto�� polu tekstowym


if handles.CommunicationSts == 1 % je�li jest komunikacja to jest mo�liwos� zadawania pozycji
    enable_sts = 'on';
    visible_sts = 'on';
else
    enable_sts = 'off';
    visible_sts = 'off';
end
set(handles.S_X, 'enable', enable_sts);                    % zaktualizuj warto�c slidera
set(handles.X_value, 'enable', enable_sts);   

set(handles.S_Y, 'enable', enable_sts);                    % zaktualizuj warto�c slidera
set(handles.Y_value, 'enable', enable_sts);   

set(handles.S_Z, 'enable', enable_sts);                    % zaktualizuj warto�c slidera
set(handles.Z_value, 'enable', enable_sts);   

set(handles.S_A, 'enable', enable_sts);                    % zaktualizuj warto�c slidera
set(handles.A_value, 'enable', enable_sts);   

set(handles.S_B, 'enable', enable_sts);                    % zaktualizuj warto�c slidera
set(handles.B_value, 'enable', enable_sts);   

set(handles.S_C, 'enable', enable_sts);                    % zaktualizuj warto�c slidera
set(handles.C_value, 'enable', enable_sts);   

set(handles.S_X, 'Value', handles.KR6R900.End.X);                     % zaktualizuj warto�c slidera
set(handles.X_value, 'String', num2str(handles.KR6R900.End.X, precision +1));        % zaktualizuj warto�� polu tekstowym

set(handles.S_Y, 'Value', handles.KR6R900.End.Y);                     % zaktualizuj warto�c slidera
set(handles.Y_value, 'String', num2str(handles.KR6R900.End.Y, precision +1));        % zaktualizuj warto�� polu tekstowym

set(handles.S_Z, 'Value', handles.KR6R900.End.Z);                     % zaktualizuj warto�c slidera
set(handles.Z_value, 'String', num2str(handles.KR6R900.End.Z, precision +1));        % zaktualizuj warto�� polu tekstowym

set(handles.S_A, 'Value', handles.KR6R900.End.A1);                     % zaktualizuj warto�c slidera
set(handles.A_value, 'String', num2str(handles.KR6R900.End.A1, precision));        % zaktualizuj warto�� polu tekstowym

set(handles.S_B, 'Value', handles.KR6R900.End.B1);                     % zaktualizuj warto�c slidera
set(handles.B_value, 'String', num2str(handles.KR6R900.End.B1, precision));        % zaktualizuj warto�� polu tekstowym

set(handles.S_C, 'Value', handles.KR6R900.End.C1);                     % zaktualizuj warto�c slidera
set(handles.C_value, 'String', num2str(handles.KR6R900.End.C1, precision));        % zaktualizuj warto�� polu tekstowym

% % ukryj pola A B C je�li jest ofline - nieaktualne
% set(handles.S_A, 'Visible', visible_sts);
% set(handles.A_value, 'Visible', visible_sts);
% set(handles.A_text, 'Visible', visible_sts);
% 
% set(handles.S_B, 'Visible', visible_sts);
% set(handles.B_value, 'Visible', visible_sts);
% set(handles.B_text, 'Visible', visible_sts);
% 
% set(handles.S_C, 'Visible', visible_sts);
% set(handles.C_value, 'Visible', visible_sts);
% set(handles.C_text, 'Visible', visible_sts);

% zakltualizuj communication panel
if handles.CommunicationSts == 1 % je�li jest komunikacja to jest mo�liwos� zadawania pozycji
    set(handles.Communications_Status, 'String', 'on');
else
    set(handles.Communications_Status, 'String', 'off');

end




function update_1edn_of_effector(handles)
% funckja s�u��ca do aktualizacji wizualizzacji pocyji ko�c�wki efektora
precision = 3;
set(handles.X_value, 'String', num2str(handles.KR6R900.End.X,precision))                    
set(handles.Y_value, 'String', num2str(handles.KR6R900.End.Y,precision))
set(handles.Z_value, 'String', num2str(handles.KR6R900.End.Z,precision))
set(handles.A_value, 'String', num2str(handles.KR6R900.End.A1,precision))                    
set(handles.B_value, 'String', num2str(handles.KR6R900.End.B1,precision))
set(handles.C_value, 'String', num2str(handles.KR6R900.End.C1,precision))


% --- Executes on button press in Init_Communication.
function Init_Communication_Callback(hObject, eventdata, handles)
% hObject    handle to Init_Communication (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% %%% TEST:
% load CommunicationExample
% joint_message = d2;
% %%% End of test
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by�a ju� rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju� w stanie open
    
else
    fopen(Robot);
end

fwrite(Robot,handles.mess.AXIS_ACT);   
wait_for_BytesAvailable(Robot, 2) % max timeout
if Robot.BytesAvailable > 0 %warunek pojawienia si� wiadomo�ci

    joint_message = fread(Robot,Robot.BytesAvailable);

    Joints = KukaData2Joint(joint_message);
    
    if sum(isnan(Joints)) > 0 % obs�uga b��du
        h = msgbox({'Wrong meesage format.', 'Message read:',char(joint_message'), 'Joints read:', num2str(Joints)},'Fail');
        waitfor(h)                                          % poczekaj na zamkni�cie okna
    else % je�li wszystko ok
        h = msgbox('Communication OK, position of robot will be updated','Information');
        waitfor(h)                                          % poczekaj na zamkni�cie okna
        handles = Update_GUI_by_Joints(Joints, handles);    % kompleksowa funkcja aktualizuj�ca GUI
        handles.Robot = Robot;
    end
    
else %w przeciwnym wypadku fail
    h = msgbox('Communication Failed', 'Fail');
    waitfor(h)  
end
handles.CommunicationSts = 1; % there is communication
update_panels(handles) 
guidata(hObject, handles);

% Robot.Status
% Robot.TransferStatus

function handles = Update_GUI_by_Joints(Joints, handles)
% funkcja do aktualizacji Gui na podstawie wektora aktualnych pozycji 
for i=1:length(Joints)
    handles.KR6R900.Joint(i).Value = Joints(i);
end
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);
update_panels(handles)                                                              %zaktualizuj wartosci sliders panel


function Y=randp(n,min,max)
%rand of size n from min to max
Y=rand(1,n)*(max-min)+min;

function wait_for_BytesAvailable(oRobot, fTimeout) %in seconds
interval = 0.01;
time = interval;

while time < fTimeout
    pause(interval)
    time = time + interval;
    
    if strcmp(oRobot.TransferStatus, 'idle') && oRobot.BytesAvailable > 0
        % je�li jest ju� w iddle to mo�na dzia�a� dalej
        break;
    end
    
end
pause(interval)

function wait_for_idle_state(oRobot, fTimeout) %in seconds
interval = 0.001;
time = interval;

while time < fTimeout
    pause(interval)
    time = time + interval;
    
    if strcmp(oRobot.TransferStatus, 'idle')
        % je�li jest ju� w iddle to mo�na dzia�a� dalej
        break;
    end
    
end
pause(interval)


% --- Executes on button press in Get_Position.
function Get_Position_Callback(hObject, eventdata, handles)
% hObject    handle to Get_Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by�a ju� rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju� w stanie open
    
else
    fopen(Robot);
end

fwrite(Robot,handles.mess.AXIS_ACT);   
wait_for_BytesAvailable(Robot, 2) % max timeout
if Robot.BytesAvailable > 0 %warunek pojawienia si� wiadomo�ci

    joint_message = fread(Robot,Robot.BytesAvailable);

    Joints = KukaData2Joint(joint_message);
    
    if sum(isnan(Joints)) > 0 % obs�uga b��du
        h = msgbox({'Wrong meesage format.', 'Message read:',char(joint_message'), 'Joints read:', num2str(Joints)},'Fail');
        waitfor(h)                                          % poczekaj na zamkni�cie okna
    else % je�li wszystko ok

        handles = Update_GUI_by_Joints(Joints, handles);    % kompleksowa funkcja aktualizuj�ca GUI
        handles.Robot = Robot;
    end
    
else %w przeciwnym wypadku fail
    h = msgbox('Communication Failed', 'Fail');
    waitfor(h)  
end
handles.CommunicationSts = 1;
update_panels(handles) 
guidata(hObject, handles);


% --- Executes on button press in Monitor.
function Monitor_Callback(hObject, eventdata, handles)
% hObject    handle to Monitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% preconditions
global RobotData;
global StopCommand;
RobotData = []; % wyczys� zawartos� RobotData
set(handles.Number_of_Data, 'String',0); % zaktualizuj wartos� Numbre of data na panelu - reset danych
set(handles.Actual_time, 'String',0); % zaktualizuj wartos� czasu na panelu
StopCommand = 0; % reset stop command - flaga zatrzymujaca pomiary
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by�a ju� rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju� w stanie open
    
else
    fopen(Robot);
end
timeout = str2double(get(handles.Monitor_Value, 'String'));
time = 0;
tic % rozpocz�cie odliczania
i = 1; %kolejna dana
while time < timeout
    fwrite(Robot,handles.mess.AXIS_ACT);   
    wait_for_BytesAvailable(Robot, 2) % max timeout
    if Robot.BytesAvailable > 0 %warunek pojawienia si� wiadomo�ci

        joint_message = fread(Robot,Robot.BytesAvailable);

        Joints = KukaData2Joint(joint_message);

        if sum(isnan(Joints)) > 0 % obs�uga b��du
            h = msgbox({'Wrong meesage format.', 'Message read:',char(joint_message'), 'Joints read:', num2str(Joints)},'Fail');
            waitfor(h)
            break; % poczekaj na zamkni�cie okna
        else % je�li wszystko ok
            RobotData(i).time = toc;
            RobotData(i).Joints = Joints;
            handles = Update_GUI_by_Joints(Joints, handles);    % kompleksowa funkcja aktualizuj�ca GUI
            RobotData(i).End = [handles.KR6R900.End.X handles.KR6R900.End.Y handles.KR6R900.End.Z handles.KR6R900.End.A1 handles.KR6R900.End.B1 handles.KR6R900.End.C1];
            set(handles.Number_of_Data, 'String',i); % zaktualizuj wartos� Numbre of data na panelu
            i = i+1;
            handles.Robot = Robot;

        end

    else %w przeciwnym wypadku fail
        h = msgbox('Communication Failed', 'Fail');
        waitfor(h)
        break;
    end
    if StopCommand
        break;
    end
    
    time = toc; %we� aktualna wartos� czasu
    set(handles.Actual_time, 'String',time); % zaktualizuj wartos� czasu na panelu
    
end
handles.CommunicationSts = 1;
update_panels(handles) 
guidata(hObject, handles);


function Monitor_Value_Callback(hObject, eventdata, handles)
% hObject    handle to Monitor_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Monitor_Value as text
%        str2double(get(hObject,'String')) returns contents of Monitor_Value as a double


% --- Executes during object creation, after setting all properties.
function Monitor_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Monitor_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global StopCommand;
StopCommand = 1; % u�ywane w Monitor_Callback


% --- Executes on button press in VIS_Joint.
function VIS_Joint_Callback(hObject, eventdata, handles)
% hObject    handle to VIS_Joint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RobotData;
if isfield(RobotData,'time') && isfield(RobotData,'Joints') && isfield(RobotData,'End')
    time = [RobotData.time];
    for i = 1 : length(RobotData)
        Joint1(i) = RobotData(i).Joints(1);
        Joint2(i) = RobotData(i).Joints(2);
        Joint3(i) = RobotData(i).Joints(3);
        Joint4(i) = RobotData(i).Joints(4);
        Joint5(i) = RobotData(i).Joints(5);
        Joint6(i) = RobotData(i).Joints(6);
        X(i) = RobotData(i).End(1);
        Y(i) = RobotData(i).End(2);
        Z(i) = RobotData(i).End(3);
        A(i) = RobotData(i).End(4);
        B(i) = RobotData(i).End(5);
        C(i) = RobotData(i).End(6);
    end
    figure(1); %position of joints
    
    subplot(3,2,1) %joint 1
    plot(time, Joint1)
    title('Joint 1')
    xlabel('time [s]')
    ylabel('position [deg]')
    
    subplot(3,2,2) %joint 2
    plot(time, Joint2)
    title('Joint 2')
    xlabel('time [s]')
    ylabel('position [deg]')
       
    subplot(3,2,3) %joint 3
    plot(time, Joint3)
    title('Joint 3')
    xlabel('time [s]')
    ylabel('position [deg]')
       
    subplot(3,2,4) %joint 4
    plot(time, Joint4)
    title('Joint 4')
    xlabel('time [s]')
    ylabel('position [deg]')
       
    subplot(3,2,5) %joint 5
    plot(time, Joint5)
    title('Joint 5')
    xlabel('time [s]')
    ylabel('position [deg]')
       
    subplot(3,2,6) %joint 6
    plot(time, Joint6)
    title('Joint 6')
    xlabel('time [s]')
    ylabel('position [deg]')
    

    
    
else
    h = msgbox('No data'); % je�li nie ma nic do wy�wietlenia
    waitfor(h) 
end


% --- Executes on button press in RobotDisplay.
function RobotDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to RobotDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RobotDisplay
handles.KR6R900.display = get(hObject,'Value');
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);   
%zaktualizuj po�o�enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes on slider movement.
function S_X_Callback(hObject, eventdata, handles)
% hObject    handle to S_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
X_pos = get(hObject,'Value');
set(handles.X_value, 'String', num2str(X_pos, 3)); 
send_request(handles, 'XP1.X', X_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Workspace(1,1));
set(hObject, 'Max', KR6R900.Workspace(1,2));


guidata(hObject, handles);



function X_value_Callback(hObject, eventdata, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_value as text
%        str2double(get(hObject,'String')) returns contents of X_value as a double
X_pos = str2double(get(hObject,'String'));
Min = get(handles.S_X, 'Min');
Max = get(handles.S_X, 'Max');

if isnumeric(Value) && X_pos >= Min && X_pos <= Max
    % je�li wszystko jest ok aktualizuj slider i wy�lij polecenie do robota
    set(handles.S_X, 'String', X_pos);                % zaktualizuj warto�c slidera
    set(handles.S_X, 'Value', X_pos);                 % zaktualizuj warto�c slidera
    send_request(handles, 'XP1.X', X_pos)
else
    %je�li nie jest ok zachowaj poprzednia wartos�
    set(hObject, 'String', get(handles.S_X, 'Value'));                         % obs�uga b��dnej warto�ci
    
end
guidata(hObject, handles);






% --- Executes during object creation, after setting all properties.
function X_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on slider movement.
function S_Y_Callback(hObject, eventdata, handles)
% hObject    handle to S_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Y_pos = get(hObject,'Value');
set(handles.Y_value, 'String', num2str(Y_pos, 3)); 
send_request(handles, 'XP1.Y', Y_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Workspace(1,3));
set(hObject, 'Max', KR6R900.Workspace(1,4));


guidata(hObject, handles);



function Y_value_Callback(hObject, eventdata, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_value as text
%        str2double(get(hObject,'String')) returns contents of X_value as a double
Y_pos = str2double(get(hObject,'String'));
Min = get(handles.S_Y, 'Min');
Max = get(handles.S_Y, 'Max');

if isnumeric(Value) && Y_pos >= Min && Y_pos <= Max
    % je�li wszystko jest ok aktualizuj slider i wy�lij polecenie do robota
    set(handles.S_Y, 'String', Y_pos);                % zaktualizuj warto�c slidera
    set(handles.S_Y, 'Value', Y_pos);                 % zaktualizuj warto�c slidera
    send_request(handles, 'XP1.Y', Y_pos)
else
    %je�li nie jest ok zachowaj poprzednia wartos�
    set(hObject, 'String', get(handles.S_Y, 'Value'));                         % obs�uga b��dnej warto�ci
    
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Y_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function S_Z_Callback(hObject, eventdata, handles)
% hObject    handle to S_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Z_pos = get(hObject,'Value');
set(handles.Z_value, 'String', num2str(Z_pos, 3)); 
send_request(handles, 'XP1.Z', Z_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.Workspace(1,5));
set(hObject, 'Max', KR6R900.Workspace(1,6));

guidata(hObject, handles);



function Z_value_Callback(hObject, eventdata, handles)
% hObject    handle to Z_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_value as text
%        str2double(get(hObject,'String')) returns contents of Z_value as a double
Z_pos = str2double(get(hObject,'String'));
Min = get(handles.S_Z, 'Min');
Max = get(handles.S_Z, 'Max');

if isnumeric(Value) && Z_pos >= Min && Z_pos <= Max
    % je�li wszystko jest ok aktualizuj slider i wy�lij polecenie do robota
    set(handles.S_Z, 'String', Z_pos);                % zaktualizuj warto�c slidera
    set(handles.S_Z, 'Value', Z_pos);                 % zaktualizuj warto�c slidera
    send_request(handles, 'XP1.Z', Z_pos)
else
    %je�li nie jest ok zachowaj poprzednia wartos�
    set(hObject, 'String', get(handles.S_Z, 'Value'));                         % obs�uga b��dnej warto�ci
    
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Z_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function S_A_Callback(hObject, eventdata, handles)
% hObject    handle to S_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
A_pos = get(hObject,'Value');
set(handles.A_value, 'String', num2str(A_pos, 3)); 
send_request(handles, 'XP5.A', A_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
                                                                      % wczytaj parametry robota i przypisz warto�ci domy�lne
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.A.min);
set(hObject, 'Max', KR6R900.A.max);

guidata(hObject, handles);



function A_value_Callback(hObject, eventdata, handles)
% hObject    handle to A_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_value as text
%        str2double(get(hObject,'String')) returns contents of A_value as a double
A_pos = str2double(get(hObject,'String'));
Min = get(handles.S_A, 'Min');
Max = get(handles.S_A, 'Max');

if isnumeric(Value) && A_pos >= Min && A_pos <= Max
    % je�li wszystko jest ok aktualizuj slider i wy�lij polecenie do robota
    set(handles.S_A, 'String', A_pos);                % zaktualizuj warto�c slidera
    set(handles.S_A, 'Value', A_pos);                 % zaktualizuj warto�c slidera
    send_request(handles, 'XP5.A', A_pos)
else
    %je�li nie jest ok zachowaj poprzednia wartos�
    set(hObject, 'String', get(handles.S_A, 'Value'));                         % obs�uga b��dnej warto�ci
    
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function A_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function S_B_Callback(hObject, eventdata, handles)
% hObject    handle to S_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
B_pos = get(hObject,'Value');
set(handles.B_value, 'String', num2str(B_pos, 3)); 
send_request(handles, 'XP1.B', B_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
                                                                      % wczytaj parametry robota i przypisz warto�ci domy�lne
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.B.min);
set(hObject, 'Max', KR6R900.B.max);

guidata(hObject, handles);



function B_value_Callback(hObject, eventdata, handles)
% hObject    handle to B_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_value as text
%        str2double(get(hObject,'String')) returns contents of B_value as a double
B_pos = str2double(get(hObject,'String'));
Min = get(handles.S_B, 'Min');
Max = get(handles.S_B, 'Max');

if isnumeric(Value) && B_pos >= Min && B_pos <= Max
    % je�li wszystko jest ok aktualizuj slider i wy�lij polecenie do robota
    set(handles.S_B, 'String', B_pos);                % zaktualizuj warto�c slidera
    set(handles.S_B, 'Value', B_pos);                 % zaktualizuj warto�c slidera
    send_request(handles, 'XP5.B', B_pos)
else
    %je�li nie jest ok zachowaj poprzednia wartos�
    set(hObject, 'String', get(handles.S_B, 'Value'));                         % obs�uga b��dnej warto�ci
    
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function B_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function S_C_Callback(hObject, eventdata, handles)
% hObject    handle to S_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
C_pos = get(hObject,'Value');
set(handles.C_value, 'String', num2str(C_pos, 3)); 
send_request(handles, 'XP5.C', C_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
                                                                    % wczytaj parametry robota i przypisz warto�ci domy�lne
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz warto�ci domy�lne
set(hObject, 'Min', KR6R900.C.min);
set(hObject, 'Max', KR6R900.C.max);

guidata(hObject, handles);



function C_value_Callback(hObject, eventdata, handles)
% hObject    handle to C_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_value as text
%        str2double(get(hObject,'String')) returns contents of C_value as a double
C_pos = str2double(get(hObject,'String'));
Min = get(handles.S_C, 'Min');
Max = get(handles.S_C, 'Max');

if isnumeric(Value) && C_pos >= Min && C_pos <= Max
    % je�li wszystko jest ok aktualizuj slider i wy�lij polecenie do robota
    set(handles.S_C, 'String', C_pos);                % zaktualizuj warto�c slidera
    set(handles.S_C, 'Value', C_pos);                 % zaktualizuj warto�c slidera
    send_request(handles, 'XP5.C', C_pos)
else
    %je�li nie jest ok zachowaj poprzednia wartos�
    set(hObject, 'String', get(handles.S_C, 'Value'));                         % obs�uga b��dnej warto�ci
    
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function C_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_value (see GCBO)
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


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function A2_Value_Callback(hObject, eventdata, handles)
% hObject    handle to A2_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A2_Value as text
%        str2double(get(hObject,'String')) returns contents of A2_Value as a double


% --- Executes during object creation, after setting all properties.
function A2_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A2_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B2_Value_Callback(hObject, eventdata, handles)
% hObject    handle to B2_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B2_Value as text
%        str2double(get(hObject,'String')) returns contents of B2_Value as a double


% --- Executes during object creation, after setting all properties.
function B2_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B2_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C2_Value_Callback(hObject, eventdata, handles)
% hObject    handle to C2_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C2_Value as text
%        str2double(get(hObject,'String')) returns contents of C2_Value as a double


% --- Executes during object creation, after setting all properties.
function C2_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C2_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function send_request(handles, name, data)
% funkcja s�u��ca do wysy�ania polece� do robota
% preconditions
pre_mess = [0 1 0 15 1 0];
value = double(num2str(data,5));
identifier = [length(name) double(name) 0 length(value)];
mess = [pre_mess identifier value]';
mess(4) = length(mess)-4;
% char(mess')
% mess'
    
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by�a ju� rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju� w stanie open
    
else
    fopen(Robot);
end
wait_for_idle_state(Robot, 2); % max timeout
fwrite(Robot,mess);
handles.CommunicationSts = 1;


% --- Executes on button press in Stop_Communication.
function Stop_Communication_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_Communication (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.CommunicationSts = 0;
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by�a ju� rozpoczynana komunikacja
    
    if strcmp(handles.Robot.Status,'closed') %sprawdzenie czy Robot jest ju� w stanie closed
    
    else
        fclose(handles.Robot);
    end
    
else
    % nie trzeba nic robi�
end
update_panels(handles)
guidata(hObject, handles);



function Logs_Name_Callback(hObject, eventdata, handles)
% hObject    handle to Logs_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Logs_Name as text
%        str2double(get(hObject,'String')) returns contents of Logs_Name as a double


% --- Executes during object creation, after setting all properties.
function Logs_Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Logs_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save_As_txt.
function Save_As_txt_Callback(hObject, eventdata, handles)
% hObject    handle to Save_As_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RobotData
if isfield(RobotData,'time') && isfield(RobotData,'Joints') && isfield(RobotData,'End')
    File_name = get(handles.Logs_Name,'String');
    File_name = strcat(File_name,'.txt');

    time = [RobotData.time];
    for i = 1 : length(RobotData)
        Joint1(i) = RobotData(i).Joints(1);
        Joint2(i) = RobotData(i).Joints(2);
        Joint3(i) = RobotData(i).Joints(3);
        Joint4(i) = RobotData(i).Joints(4);
        Joint5(i) = RobotData(i).Joints(5);
        Joint6(i) = RobotData(i).Joints(6);
        X(i) = RobotData(i).End(1);
        Y(i) = RobotData(i).End(2);
        Z(i) = RobotData(i).End(3);
        A(i) = RobotData(i).End(4);
        B(i) = RobotData(i).End(5);
        C(i) = RobotData(i).End(6);
    end
    header = 'time	Joint1	Joint2	Joint3	Joint4	Joint5	Joint6	X	Y	Z	A	B	C';
    % Data = [time' Joint1' Joint2' Joint3' Joint4' Joint5' Joint6' X' Y' Z' A' B' C'];
    % Data = [time Joint1 Joint2 Joint3 Joint4 Joint5 Joint6 X Y Z A B C];
    Data_format = '%12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f \n';
    file = fopen(File_name,'wt');
    fprintf(file, '%50s\n', header);
    for i=1:length(time)
        Data = [time(i) Joint1(i) Joint2(i) Joint3(i) Joint4(i) Joint5(i) Joint6(i) X(i) Y(i) Z(i) A(i) B(i) C(i)];
        fprintf(file, Data_format, Data);
    end
    fclose(file);
else
    h = msgbox('No data'); % je�li nie ma nic do wy�wietlenia
    waitfor(h) 
end



    
    


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in Set_Actual_Position.
function Set_Actual_Position_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Actual_Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

X_pos = get(handles.S_X,'Value');
send_request(handles, 'XP1.X', X_pos);

Y_pos = get(handles.S_Y,'Value');
send_request(handles, 'XP1.Y', Y_pos);

Z_pos = get(handles.S_Z,'Value');
send_request(handles, 'XP1.Z', Z_pos);


% --- Executes on button press in VIS_end_of_efector.
function VIS_end_of_efector_Callback(hObject, eventdata, handles)
% hObject    handle to VIS_end_of_efector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global RobotData;
if isfield(RobotData,'time') && isfield(RobotData,'Joints') && isfield(RobotData,'End')
    time = [RobotData.time];
    for i = 1 : length(RobotData)
        Joint1(i) = RobotData(i).Joints(1);
        Joint2(i) = RobotData(i).Joints(2);
        Joint3(i) = RobotData(i).Joints(3);
        Joint4(i) = RobotData(i).Joints(4);
        Joint5(i) = RobotData(i).Joints(5);
        Joint6(i) = RobotData(i).Joints(6);
        X(i) = RobotData(i).End(1);
        Y(i) = RobotData(i).End(2);
        Z(i) = RobotData(i).End(3);
        A(i) = RobotData(i).End(4);
        B(i) = RobotData(i).End(5);
        C(i) = RobotData(i).End(6);
    end

    figure(2); %position of end of efector
    plot3(X,Y,Z)
    title('position of end of efector')
    xlabel('x [mm]')
    ylabel('y [mm]')
    zlabel('z [mm]')
    
    
else
    h = msgbox('No data'); % je�li nie ma nic do wy�wietlenia
    waitfor(h) 
end


% --- Executes on button press in VIS_velocity.
function VIS_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to VIS_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global RobotData;
if isfield(RobotData,'time') && isfield(RobotData,'Joints') && isfield(RobotData,'End')
    time = [RobotData.time];
    for i = 1 : length(RobotData)
        Joint1(i) = RobotData(i).Joints(1);
        Joint2(i) = RobotData(i).Joints(2);
        Joint3(i) = RobotData(i).Joints(3);
        Joint4(i) = RobotData(i).Joints(4);
        Joint5(i) = RobotData(i).Joints(5);
        Joint6(i) = RobotData(i).Joints(6);
        X(i) = RobotData(i).End(1);
        Y(i) = RobotData(i).End(2);
        Z(i) = RobotData(i).End(3);
        A(i) = RobotData(i).End(4);
        B(i) = RobotData(i).End(5);
        C(i) = RobotData(i).End(6);
    end


    
    vJoint1 = differenction(Joint1, time);
    vJoint2 = differenction(Joint2, time);
    vJoint3 = differenction(Joint3, time);
    vJoint4 = differenction(Joint4, time);
    vJoint5 = differenction(Joint5, time);
    vJoint6 = differenction(Joint6, time);
    
    VJoints= [vJoint1; vJoint2; vJoint3; vJoint4; vJoint5; vJoint6];
    
    vX = differenction(X, time);
    vY = differenction(Y, time);
    vZ = differenction(Z, time);
    
    VXYZ = [vX; vY; vZ];
    
    V = sqrt(vX.^2 + vY.^2 + vZ.^2);
    figure(3); %position of end of efector
    
    subplot(3,1,1)
    title('Joint Velocity')
    xlabel('time [s]')
    ylabel('Joint speed [deg /s]')
    plot(time, VJoints);
    legend('Joint 1', 'Joint 2', 'Joint 3', 'Joint 4', 'Joint 5', 'Joint 6');

    subplot(3,1,2)
    title('End of Effector Velocity')
    xlabel('time [s]')
    ylabel(' speed [mm /s]')
    plot(time, VXYZ);
    legend('v_X', 'v_Y', 'v_Z');
    
    subplot(3,1,3)
    title('Absolute End of Effector Velocity')
    xlabel('time [s]')
    ylabel('speed [mm /s]')
    plot(time, V);
    
    
else
    h = msgbox('No data'); % je�li nie ma nic do wy�wietlenia
    waitfor(h) 
end


% --- Executes on button press in VIS_acceleration.
function VIS_acceleration_Callback(hObject, eventdata, handles)
% hObject    handle to VIS_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global RobotData;
if isfield(RobotData,'time') && isfield(RobotData,'Joints') && isfield(RobotData,'End')
    time = [RobotData.time];
    for i = 1 : length(RobotData)
        Joint1(i) = RobotData(i).Joints(1);
        Joint2(i) = RobotData(i).Joints(2);
        Joint3(i) = RobotData(i).Joints(3);
        Joint4(i) = RobotData(i).Joints(4);
        Joint5(i) = RobotData(i).Joints(5);
        Joint6(i) = RobotData(i).Joints(6);
        X(i) = RobotData(i).End(1);
        Y(i) = RobotData(i).End(2);
        Z(i) = RobotData(i).End(3);
        A(i) = RobotData(i).End(4);
        B(i) = RobotData(i).End(5);
        C(i) = RobotData(i).End(6);
    end
    
    
    
    aJoint1 = differenction(differenction(Joint1, time),time);
    aJoint2 = differenction(differenction(Joint2, time),time);
    aJoint3 = differenction(differenction(Joint3, time),time);
    aJoint4 = differenction(differenction(Joint4, time),time);
    aJoint5 = differenction(differenction(Joint5, time),time);
    aJoint6 = differenction(differenction(Joint6, time),time);
    
    aJoints= [aJoint1; aJoint2; aJoint3; aJoint4; aJoint5; aJoint6];
    
    aX = differenction(differenction(X, time),time);
    aY = differenction(differenction(Y, time),time);
    aZ = differenction(differenction(Z, time),time);
    
    AXYZ = [aX; aY; aZ];
    
    A = sqrt(aX.^2 + aY.^2 + aZ.^2);
    figure(4); 
    
    subplot(3,1,1)
    title('Joint Acceleration')
    xlabel('time [s]')
    ylabel('Joint speed [deg /s]')
    plot(time, aJoints);
    legend('Joint 1', 'Joint 2', 'Joint 3', 'Joint 4', 'Joint 5', 'Joint 6');

    subplot(3,1,2)
    title('End of Effector Acceleration')
    xlabel('time [s]')
    ylabel(' speed [mm /s]')
    plot(time, AXYZ);
    legend('v_X', 'v_Y', 'v_Z');
    
    subplot(3,1,3)
    title('Absolute End of Effector Acceleration')
    xlabel('time [s]')
    ylabel('speed [mm /s]')
    plot(time, A);
    
    
else
    h = msgbox('No data'); % je�li nie ma nic do wy�wietlenia
    waitfor(h) 
end