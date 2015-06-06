function varargout = KukaGui_V4(varargin)
% KUKAGUI_V4 MATLAB code for KukaGui_V4.fig
%      KUKAGUI_V4, by itself, creates a new KUKAGUI_V4 or raises the existing
%      singleton*.
%
%      H = KUKAGUI_V4 returns the handle to a new KUKAGUI_V4 or the handle to
%      the existing singleton*.
%
%      KUKAGUI_V4('CALLBACK',hObject,~,handles,...) calls the local
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

% Last Modified by GUIDE v2.5 03-Jun-2015 01:08:49

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
function KukaGui_V4_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KukaGui_V4 (see VARARGIN)

% Choose default command line output for KukaGui_V4

% funkcja wywo³ywana przed pojawieniem sie GUI wywi³uje wszyskie
% preconditions opróc Create_function

handles.output = hObject;
load KR6R900_V4
handles.KR6R900 = KR6R900;
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);

handles.mess.AXIS_ACT=[0;0;0;13;0;0;10;36;65;88;73;83;95;65;67;84];                 % wiadomoœc o rz¹danie pozycji przegóbów
handles.mess.POS_ACT=[0;0;0;13;0;0;10;36;80;79;83;95;65;67;84];  

set(handles.RobotDisplay,'Value',1);
handles.CommunicationSts = 0; %no communication
% Update handles structure
guidata(hObject, handles);
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector


% UIWAIT makes KukaGui_V4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KukaGui_V4_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PB_random_position.
function PB_random_position_Callback(hObject, ~, handles)
% hObject    handle to PB_random_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funckaj do ustawiania losowej pozycji robota z przestrzeni dostepnych
% ruchów
handles.KR6R900 = ranodm_position(handles.KR6R900);                                 %ustaw losow¹ pozycje robota
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
% Update handles structure
guidata(hObject, handles);
update_panels(handles)                                                              %zaktualizuj wartosci sliders panel
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector


function Robot = ranodm_position(Robot)
% Funkcja u¿ywana do ustalania losowej pozycji robota u¿ywana w wywo³aniu 
% PB_random_position_Callback
Robot.Joint(1).Value = randp(1, Robot.Joint(1).Min, Robot.Joint(1).Max);            %ustalanie losowej pozycji w zaleznoœci od ograniczeñ
Robot.Joint(2).Value = randp(1, Robot.Joint(2).Min, Robot.Joint(2).Max);
Robot.Joint(3).Value = randp(1, Robot.Joint(3).Min, Robot.Joint(3).Max);
Robot.Joint(4).Value = randp(1, Robot.Joint(4).Min, Robot.Joint(4).Max);
Robot.Joint(5).Value = randp(1, Robot.Joint(5).Min, Robot.Joint(5).Max);
Robot.Joint(6).Value = randp(1, Robot.Joint(6).Min, Robot.Joint(6).Max);

function Y=randp(n,min,max)
%rand of size n from min to max
Y=rand(1,n)*(max-min)+min;

% --- Executes on slider movement.
function S_Joint1_Callback(hObject, ~, handles)
% hObject    handle to S_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% Ka¿dy sukaw ma w zasadzie tak¹ sam¹ strukture wywo³ania. Pobierana jest
% wartoœæ suwaka do struktury robota, nastepnie aktualizowana jest wartoœæ
% tekstowa w GUI, a na koñcu aktualizowana jest pozycja robota

handles.KR6R900.Joint(1).Value = get(hObject,'Value');                              % pobierz wartoœæ z slidera
set(handles.T_Joint1, 'String', num2str(handles.KR6R900.Joint(1).Value, 3));        % zaktualizuj wartoœæ polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);   
%zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint1_CreateFcn(hObject, ~, handles)
% hObject    handle to S_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.

% Ka¿dy suwak ma t¹ sam¹ strukture inicjalizacji po pierwsze wczytywana
% jest struktura robota po drugie okreœlane s¹ wartosci minimalne i
% maksymalne a po trzecie okreslana jest wartoœæ pocz¹tkowa suwaka
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Joint(1).Min);
set(hObject, 'Max', KR6R900.Joint(1).Max);
set(hObject, 'Value', KR6R900.Joint(1).Value);
set(hObject, 'String', num2str(KR6R900.Joint(1).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint1.
function T_Joint1_Callback(hObject, ~, handles)
% hObject    handle to T_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ka¿de odwo³anie tekstowe ma podobn¹ strukture najpierw pobierana jest
% wartoœæ, nasepnie sprawdzany jest warunek czy pobrana wartoœæ mieœci siê
% w dopuszczalnych zakresach, a na koñcu uakatualniana jest pozycja robota
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint1, 'Min');
Max = get(handles.S_Joint1, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(1).Value = str2double(get(hObject,'String'));             % pobierz wartoœæ 
    set(handles.S_Joint1, 'String', handles.KR6R900.Joint(1).Value);                % zaktualizuj wartoœc slidera
    set(handles.S_Joint1, 'Value', handles.KR6R900.Joint(1).Value);                 % zaktualizuj wartoœc slidera
else
    set(hObject, 'String', get(handles.S_Joint1, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint1_CreateFcn(hObject, ~, handles)
% hObject    handle to T_Joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Ka¿da inicjalizacja tekstu ma podobn¹ strukture, najpierw wczytywana jest
% struktura robota a nastepnie zapisywana jest wartosæ domyœlna tekstu
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'String', num2str(KR6R900.Joint(1).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint2_Callback(hObject, ~, handles)
% hObject    handle to S_Joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.KR6R900.Joint(2).Value = get(hObject,'Value');                              % pobierz wartoœæ z slidera
set(handles.T_Joint2, 'String', num2str(handles.KR6R900.Joint(2).Value, 3));        % zaktualizuj wartoœæ polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_Joint2_CreateFcn(hObject, ~, handles)
% hObject    handle to S_Joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Joint(2).Min);
set(hObject, 'Max', KR6R900.Joint(2).Max);
set(hObject, 'Value', KR6R900.Joint(2).Value);
set(hObject, 'String', num2str(KR6R900.Joint(2).Value));
guidata(hObject, handles);


function T_Joint2_Callback(hObject, ~, handles)
% hObject    handle to T_Joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Joint2 as text
%        str2double(get(hObject,'String')) returns contents of T_Joint2 as a double
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint2, 'Min');
Max = get(handles.S_Joint2, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(2).Value = str2double(get(hObject,'String'));             % pobierz wartoœæ 
    set(handles.S_Joint2, 'String', handles.KR6R900.Joint(2).Value);                % zaktualizuj wartoœc slidera
    set(handles.S_Joint2, 'Value', handles.KR6R900.Joint(2).Value);                 % zaktualizuj wartoœc slidera
else
    set(hObject, 'String', get(handles.S_Joint2, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint2_CreateFcn(hObject, ~, handles)
% hObject    handle to T_Joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'String', num2str(KR6R900.Joint(2).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint3_Callback(hObject, ~, handles)
% hObject    handle to S_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(3).Value = get(hObject,'Value');                              % pobierz wartoœæ z slidera
set(handles.T_Joint3, 'String', num2str(handles.KR6R900.Joint(3).Value, 3));        % zaktualizuj wartoœæ polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint3_CreateFcn(hObject, ~, handles)
% hObject    handle to S_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Joint(3).Min);
set(hObject, 'Max', KR6R900.Joint(3).Max);
set(hObject, 'Value', KR6R900.Joint(3).Value);
set(hObject, 'String', num2str(KR6R900.Joint(3).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint3.
function T_Joint3_Callback(hObject, ~, handles)
% hObject    handle to T_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint3, 'Min');
Max = get(handles.S_Joint3, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(3).Value = str2double(get(hObject,'String'));             % pobierz wartoœæ 
    set(handles.S_Joint3, 'String', handles.KR6R900.Joint(3).Value);                % zaktualizuj wartoœc slidera
    set(handles.S_Joint3, 'Value', handles.KR6R900.Joint(3).Value);                 % zaktualizuj wartoœc slidera
else
    set(hObject, 'String', get(handles.S_Joint3, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint3_CreateFcn(hObject, ~, handles)
% hObject    handle to T_Joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'String', num2str(KR6R900.Joint(3).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint4_Callback(hObject, ~, handles)
% hObject    handle to S_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(4).Value = get(hObject,'Value');                              % pobierz wartoœæ z slidera
set(handles.T_Joint4, 'String', num2str(handles.KR6R900.Joint(4).Value, 3));        % zaktualizuj wartoœæ polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint4_CreateFcn(hObject, ~, handles)
% hObject    handle to S_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Joint(4).Min);
set(hObject, 'Max', KR6R900.Joint(4).Max);
set(hObject, 'Value', KR6R900.Joint(4).Value);
set(hObject, 'String', num2str(KR6R900.Joint(4).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint4.
function T_Joint4_Callback(hObject, ~, handles)
% hObject    handle to T_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint4, 'Min');
Max = get(handles.S_Joint4, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(4).Value = str2double(get(hObject,'String'));             % pobierz wartoœæ 
    set(handles.S_Joint4, 'String', handles.KR6R900.Joint(4).Value);                % zaktualizuj wartoœc slidera
    set(handles.S_Joint4, 'Value', handles.KR6R900.Joint(4).Value);                 % zaktualizuj wartoœc slidera
else
    set(hObject, 'String', get(handles.S_Joint4, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint4_CreateFcn(hObject, ~, handles)
% hObject    handle to T_Joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'String', num2str(KR6R900.Joint(4).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint5_Callback(hObject, ~, handles)
% hObject    handle to S_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(5).Value = get(hObject,'Value');                              % pobierz wartoœæ z slidera
set(handles.T_Joint5, 'String', num2str(handles.KR6R900.Joint(5).Value, 3));        % zaktualizuj wartoœæ polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint5_CreateFcn(hObject, ~, handles)
% hObject    handle to S_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Joint(5).Min);
set(hObject, 'Max', KR6R900.Joint(5).Max);
set(hObject, 'Value', KR6R900.Joint(5).Value);
set(hObject, 'String', num2str(KR6R900.Joint(5).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint5.
function T_Joint5_Callback(hObject, ~, handles)
% hObject    handle to T_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint5, 'Min');
Max = get(handles.S_Joint5, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(5).Value = str2double(get(hObject,'String'));             % pobierz wartoœæ 
    set(handles.S_Joint5, 'String', handles.KR6R900.Joint(5).Value);                % zaktualizuj wartoœc slidera
    set(handles.S_Joint5, 'Value', handles.KR6R900.Joint(5).Value);                 % zaktualizuj wartoœc slidera
else
    set(hObject, 'String', get(handles.S_Joint5, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_Joint5_CreateFcn(hObject, ~, handles)
% hObject    handle to T_Joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'String', num2str(KR6R900.Joint(5).Value));
guidata(hObject, handles);

% --- Executes on slider movement.
function S_Joint6_Callback(hObject, ~, handles)
% hObject    handle to S_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.KR6R900.Joint(6).Value = get(hObject,'Value');                              % pobierz wartoœæ z slidera
set(handles.T_Joint6, 'String', num2str(handles.KR6R900.Joint(6).Value, 3));        % zaktualizuj wartoœæ polu tekstowym

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function S_Joint6_CreateFcn(hObject, ~, handles)
% hObject    handle to S_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Joint(6).Min);
set(hObject, 'Max', KR6R900.Joint(6).Max);
set(hObject, 'Value', KR6R900.Joint(6).Value);
set(hObject, 'String', num2str(KR6R900.Joint(6).Value));
guidata(hObject, handles);


% --- Executes on button press in T_Joint6.
function T_Joint6_Callback(hObject, ~, handles)
% hObject    handle to T_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2double(get(hObject,'String'));
Min = get(handles.S_Joint6, 'Min');
Max = get(handles.S_Joint6, 'Max');

if isnumeric(Value) && Value >= Min && Value <= Max
    handles.KR6R900.Joint(6).Value = str2double(get(hObject,'String'));             % pobierz wartoœæ 
    set(handles.S_Joint6, 'String', handles.KR6R900.Joint(6).Value);                % zaktualizuj wartoœc slidera
    set(handles.S_Joint6, 'Value', handles.KR6R900.Joint(6).Value);                 % zaktualizuj wartoœc slidera
else
    set(hObject, 'String', get(handles.S_Joint6, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end

handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);                                    %zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function T_Joint6_CreateFcn(hObject, ~, handles)
% hObject    handle to T_Joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'String', num2str(KR6R900.Joint(6).Value));
guidata(hObject, handles);


% --- Executes on button press in Home.
function Home_Callback(hObject, ~, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funkcja s³u¿¹ca do przywrócenia pozycji pocz¹kwej. W tym celu musi byc
% zaczytana struktura robota - która nie powinna siê zmieniaæ przez czas
% dzialania toolboxa, nastepnie aktualizaowany jest robot jak i wartosci na
% panelu
load KR6R900_V4
handles.KR6R900 = KR6R900;
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);
guidata(hObject, handles);
update_panels(handles)                                                              %zaktualizuj wartosci sliders panel


function update_panels(handles)
% funkcja s³u¿aca do uaktualnienia wartoœci pól w panelach na podstawie
% aktualanej pozycji robota
precision = 5;
set(handles.S_Joint1, 'String', handles.KR6R900.Joint(1).Value);                    % zaktualizuj wartoœc slidera
set(handles.S_Joint1, 'Value', handles.KR6R900.Joint(1).Value);                     % zaktualizuj wartoœc slidera
set(handles.T_Joint1, 'String', num2str(handles.KR6R900.Joint(1).Value, precision));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_Joint2, 'String', handles.KR6R900.Joint(2).Value);                    % zaktualizuj wartoœc slidera
set(handles.S_Joint2, 'Value', handles.KR6R900.Joint(2).Value);                     % zaktualizuj wartoœc slidera
set(handles.T_Joint2, 'String', num2str(handles.KR6R900.Joint(2).Value, precision));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_Joint3, 'String', handles.KR6R900.Joint(3).Value);                    % zaktualizuj wartoœc slidera
set(handles.S_Joint3, 'Value', handles.KR6R900.Joint(3).Value);                     % zaktualizuj wartoœc slidera
set(handles.T_Joint3, 'String', num2str(handles.KR6R900.Joint(3).Value, precision));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_Joint4, 'String', handles.KR6R900.Joint(4).Value);                    % zaktualizuj wartoœc slidera
set(handles.S_Joint4, 'Value', handles.KR6R900.Joint(4).Value);                     % zaktualizuj wartoœc slidera
set(handles.T_Joint4, 'String', num2str(handles.KR6R900.Joint(4).Value, precision));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_Joint5, 'String', handles.KR6R900.Joint(5).Value);                    % zaktualizuj wartoœc slidera
set(handles.S_Joint5, 'Value', handles.KR6R900.Joint(5).Value);                     % zaktualizuj wartoœc slidera
set(handles.T_Joint5, 'String', num2str(handles.KR6R900.Joint(5).Value, precision));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_Joint6, 'String', handles.KR6R900.Joint(6).Value);                    % zaktualizuj wartoœc slidera
set(handles.S_Joint6, 'Value', handles.KR6R900.Joint(6).Value);                     % zaktualizuj wartoœc slidera
set(handles.T_Joint6, 'String', num2str(handles.KR6R900.Joint(6).Value, precision));        % zaktualizuj wartoœæ polu tekstowym


if handles.CommunicationSts == 1 % jeœli jest komunikacja to jest mo¿liwosæ zadawania pozycji
    enable_sts = 'on';
    visible_sts = 'on';
else
    enable_sts = 'off';
    visible_sts = 'off';
end
set(handles.S_X, 'enable', enable_sts);                    % zaktualizuj wartoœc slidera
set(handles.X_value, 'enable', enable_sts);   

set(handles.S_Y, 'enable', enable_sts);                    % zaktualizuj wartoœc slidera
set(handles.Y_value, 'enable', enable_sts);   

set(handles.S_Z, 'enable', enable_sts);                    % zaktualizuj wartoœc slidera
set(handles.Z_value, 'enable', enable_sts);   

set(handles.S_A, 'enable', enable_sts);                    % zaktualizuj wartoœc slidera
set(handles.A_value, 'enable', enable_sts);   

set(handles.S_B, 'enable', enable_sts);                    % zaktualizuj wartoœc slidera
set(handles.B_value, 'enable', enable_sts);   

set(handles.S_C, 'enable', enable_sts);                    % zaktualizuj wartoœc slidera
set(handles.C_value, 'enable', enable_sts);   

set(handles.S_X, 'Value', handles.KR6R900.End.X);                     % zaktualizuj wartoœc slidera
set(handles.X_value, 'String', num2str(handles.KR6R900.End.X, precision +1));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_Y, 'Value', handles.KR6R900.End.Y);                     % zaktualizuj wartoœc slidera
set(handles.Y_value, 'String', num2str(handles.KR6R900.End.Y, precision +1));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_Z, 'Value', handles.KR6R900.End.Z);                     % zaktualizuj wartoœc slidera
set(handles.Z_value, 'String', num2str(handles.KR6R900.End.Z, precision +1));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_A, 'Value', handles.KR6R900.End.A1);                     % zaktualizuj wartoœc slidera
set(handles.A_value, 'String', num2str(handles.KR6R900.End.A1, precision));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_B, 'Value', handles.KR6R900.End.B1);                     % zaktualizuj wartoœc slidera
set(handles.B_value, 'String', num2str(handles.KR6R900.End.B1, precision));        % zaktualizuj wartoœæ polu tekstowym

set(handles.S_C, 'Value', handles.KR6R900.End.C1);                     % zaktualizuj wartoœc slidera
set(handles.C_value, 'String', num2str(handles.KR6R900.End.C1, precision));        % zaktualizuj wartoœæ polu tekstowym

% % ukryj pola A B C jeœli jest ofline - nieaktualne
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
if handles.CommunicationSts == 1 % jeœli jest komunikacja to jest mo¿liwosæ zadawania pozycji
    set(handles.Communications_Status, 'String', 'on');
else
    set(handles.Communications_Status, 'String', 'off');

end
set(handles.RobotDisplay, 'Value' ,handles.KR6R900.display);


% 
% function update_1edn_of_effector(handles)
% % funckja s³u¿¹ca do aktualizacji wizualizzacji pocyji koñcówki efektora
% % niepotrzebna - wszystko odbywa siê w update_panels
% precision = 3;
% set(handles.X_value, 'String', num2str(handles.KR6R900.End.X,precision))                    
% set(handles.Y_value, 'String', num2str(handles.KR6R900.End.Y,precision))
% set(handles.Z_value, 'String', num2str(handles.KR6R900.End.Z,precision))
% set(handles.A_value, 'String', num2str(handles.KR6R900.End.A1,precision))                    
% set(handles.B_value, 'String', num2str(handles.KR6R900.End.B1,precision))
% set(handles.C_value, 'String', num2str(handles.KR6R900.End.C1,precision))


% --- Executes on button press in Init_Communication.
function Init_Communication_Callback(hObject, ~, handles)
% hObject    handle to Init_Communication (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funkcja s³u¿¹ca do zainicjowania po³¹czania tcpip, najpierw sprawdzane
% jest czy takie po³¹czenie nie zosta³o ju¿ zainicjonowane, jeœli by³o
% zainicjonowane to nastepuje procedura pobrania aktualnej pozyci robota i
% zaktualizowania pozcyji robota (wizualizacja) na podstawie tej wiadomoœci 

% %%% TEST:
% load CommunicationExample
% joint_message = d2;
% %%% End of test
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by³a ju¿ rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju¿ w stanie open
    
else
    fopen(Robot);
end

fwrite(Robot,handles.mess.AXIS_ACT);   
wait_for_BytesAvailable(Robot, 2) % max timeout
if Robot.BytesAvailable > 0 %warunek pojawienia siê wiadomoœci

    joint_message = fread(Robot,Robot.BytesAvailable);

    Joints = KukaData2Joint(joint_message);
    
    if sum(isnan(Joints)) > 0 % obs³uga b³êdu
        h = msgbox({'Wrong meesage format.', 'Message read:',char(joint_message'), 'Joints read:', num2str(Joints)},'Fail');
        waitfor(h)                                          % poczekaj na zamkniêcie okna
    else % jeœli wszystko ok
        h = msgbox('Communication OK, position of robot will be updated','Information');
        waitfor(h)                                          % poczekaj na zamkniêcie okna
        handles = Update_GUI_by_Joints(Joints, handles);    % kompleksowa funkcja aktualizuj¹ca strukturê robora KR6R900
        handles.Robot = Robot;
        
    end
    
else %w przeciwnym wypadku fail
    h = msgbox('Communication Failed', 'Fail');
    waitfor(h)  
end
handles.CommunicationSts = 1; % there is communication
update_panels(handles) 
handles = Get_Position_XYZ_ABC(handles); % pobieranie rzeczywistej pozcyji z robota
guidata(hObject, handles);



function handles = Update_GUI_by_Joints(Joints, handles)
% funkcja do aktualizacji Gui na podstawie wektora aktualnych pozycji 
for i=1:length(Joints)
    handles.KR6R900.Joint(i).Value = Joints(i);
end
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);
                                                            %zaktualizuj wartosci sliders panel




function wait_for_BytesAvailable(oRobot, fTimeout) %in seconds
% funkcja s³u¿¹ca do oczekiwania na stan spoczynku sieci komunikacyjnej z
% uwzglenieniem odebrania woadomoœci z aktualna pozycj¹ robota
interval = 0.0001;
time = interval;

while time < fTimeout
    
    
    if strcmp(oRobot.TransferStatus, 'idle') && oRobot.BytesAvailable > 0
        % jeœli jest ju¿ w iddle to mo¿na dzia³aæ dalej
        break;
    end
    pause(interval)
    time = time + interval;
    
end
% pause(interval)

function wait_for_idle_state(oRobot, fTimeout) %in seconds
% funkcja s³u¿¹ca do oczekiwania na stan spoczynku sieci komunikacyjnej
interval = 0.001;
time = interval;

while time < fTimeout
    pause(interval)
    time = time + interval;
    
    if strcmp(oRobot.TransferStatus, 'idle')
        % jeœli jest ju¿ w iddle to mo¿na dzia³aæ dalej
        break;
    end
    
end
pause(interval)


% --- Executes on button press in Get_Position.
function Get_Position_Callback(hObject, ~, handles)
% hObject    handle to Get_Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%funkcja podobna do Init_Communication_Callback z t¹ ró¿nic¹ ¿e w przypadku
%odebrania prawid³owej ramki nie jest pokazywany komunikat prawidlowego
%po³¹czenia
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by³a ju¿ rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju¿ w stanie open
    
else
    fopen(Robot);
end

fwrite(Robot,handles.mess.AXIS_ACT);   % wys³anie zapytania o ramke z aktualn¹ pozycj¹ Jointów
wait_for_BytesAvailable(Robot, 2) % max timeout
if Robot.BytesAvailable > 0 %warunek pojawienia siê wiadomoœci

    joint_message = fread(Robot,Robot.BytesAvailable); % pobranie ramki do zmiennej

    Joints = KukaData2Joint(joint_message); % wyciagniêcie z ramki 6 pozcyji
    
    if sum(isnan(Joints)) > 0 % obs³uga b³êdu
        h = msgbox({'Wrong meesage format.', 'Message read:',char(joint_message'), 'Joints read:', num2str(Joints)},'Fail');
        waitfor(h)                                          % poczekaj na zamkniêcie okna
    else % jeœli wszystko ok

        handles = Update_GUI_by_Joints(Joints, handles);    % kompleksowa funkcja aktualizuj¹ca GUI
        handles.Robot = Robot;
    end
    
else %w przeciwnym wypadku fail
    h = msgbox('Communication AXIS_ACT Failed', 'Fail');
    waitfor(h)  
end
handles.CommunicationSts = 1;
update_panels(handles) 
handles = Get_Position_XYZ_ABC(handles); % pobieranie rzeczywistej pozcyji z robota
guidata(hObject, handles);

function handles = Get_Position_XYZ_ABC(handles)

%funkcja wywo³ywana w update_panels s³u¿y do pobrania rzeczywistych pozycji
%robota X Y Z A C B i zaktualizowana struktury robota, struktura ta mo¿e
%byæ wtedy u¿yta w ka¿dym dowolnym miejsu w Gui a jest obecnie u¿ywana w
%funkcji Get_Real_Values_Callback, ale równie dobrze moze byæ u¿yta w
%funkcji Get_Position_Callback albo Monitor_Callback

if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by³a ju¿ rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju¿ w stanie open
    
else
    fopen(Robot);
end

fwrite(Robot,handles.mess.POS_ACT); % wys³anie zapytania o ramke z aktualn¹ pozycj¹
wait_for_BytesAvailable(Robot, 2) % max timeout
if Robot.BytesAvailable > 0 %warunek pojawienia siê wiadomoœci

    joint_message = fread(Robot,Robot.BytesAvailable); % pobranie ramki do zmiennej

    XYZ_ABC = KukaData2XYZABC(joint_message); % wyciagniêcie z ramki 6 pozcyji
    
    if sum(isnan(XYZ_ABC)) > 0 % obs³uga b³êdu
%         h = msgbox({'Wrong meesage format.', 'Message read:',char(joint_message'), 'Position read:', num2str(XYZ_ABC)},'Fail');
%         waitfor(h)                                          % poczekaj na zamkniêcie okna
    else % jeœli wszystko ok

        handles.KR6R900.Real.X = XYZ_ABC(1); % pobranie informacji do struktury handles
        handles.KR6R900.Real.Y = XYZ_ABC(2);
        handles.KR6R900.Real.Z = XYZ_ABC(3);
        handles.KR6R900.Real.A = XYZ_ABC(4);
        handles.KR6R900.Real.B = XYZ_ABC(5);
        handles.KR6R900.Real.C = XYZ_ABC(6);
        handles.Robot = Robot;
        
        % zaktualizowanie pól tekstowych
        if handles.KR6R900.display == 1
        precision = 5;
        set(handles.X_Value_Robot, 'String', num2str(XYZ_ABC(1), precision));  
        set(handles.Y_Value_Robot, 'String', num2str(XYZ_ABC(2), precision));  
        set(handles.Z_Value_Robot, 'String', num2str(XYZ_ABC(3), precision));  
        set(handles.A_Value_Robot, 'String', num2str(XYZ_ABC(4), precision));  
        set(handles.B_Value_Robot, 'String', num2str(XYZ_ABC(5), precision));  
        set(handles.C_Value_Robot, 'String', num2str(XYZ_ABC(6), precision));  
        end
        
    end
    
else %w przeciwnym wypadku fail
    h = msgbox('Communication of POS_ACT Failed', 'Fail');
    waitfor(h)  

end
handles.CommunicationSts = 1;



% --- Executes on button press in Monitor.
function Monitor_Callback(hObject, ~, handles)
% hObject    handle to Monitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% preconditions

% funkcja pozwalajaca zapisaæ pozcyje robota przez okreslony czas. ko¿ysta
% ze zmnienej globalnej StopCommand która pozwala na zawnêtrzne wymuszenie
% zatrzymania pêtli w której pobierane s¹ kolejne wartoœci po³o¿enia
% robota. Warto zauwa¿yæ ¿e przy wy³¹czonym parametrze 'Display Robot'
% funkcja ta pobierze wiecej punktów poniewa¿ aktualizacja pozycji robota
% jest dosyæ czasoch³onna (do 0.1s)
global RobotData;
global StopCommand;
RobotData = []; % wyczysæ zawartosæ RobotData
set(handles.Number_of_Data, 'String',0); % zaktualizuj wartosæ Numbre of data na panelu - reset danych
set(handles.Actual_time, 'String',0); % zaktualizuj wartosæ czasu na panelu
StopCommand = 0; % reset stop command - flaga zatrzymujaca pomiary
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by³a ju¿ rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju¿ w stanie open
    
else
    fopen(Robot);
end
timeout = str2double(get(handles.Monitor_Value, 'String'));
time = 0;
tic % rozpoczêcie odliczania
i = 1; %kolejna dana
while time < timeout
    fwrite(Robot,handles.mess.AXIS_ACT);   
    wait_for_BytesAvailable(Robot, 2) % max timeout
    if Robot.BytesAvailable > 0 %warunek pojawienia siê wiadomoœci

        joint_message = fread(Robot,Robot.BytesAvailable);

        Joints = KukaData2Joint(joint_message);

        if sum(isnan(Joints)) > 0 % obs³uga b³êdu
            h = msgbox({'Wrong meesage format.', 'Message read:',char(joint_message'), 'Joints read:', num2str(Joints)},'Fail');
            waitfor(h)
            break; % poczekaj na zamkniêcie okna
        else % jeœli wszystko ok
            RobotData(i).time = toc;
            RobotData(i).Joints = Joints;
            handles = Get_Position_XYZ_ABC(handles); % pobieranie rzeczywistej pozcyji z robota
            handles = Update_GUI_by_Joints(Joints, handles);    % kompleksowa funkcja aktualizuj¹ca GUI
            RobotData(i).End = [handles.KR6R900.End.X handles.KR6R900.End.Y handles.KR6R900.End.Z handles.KR6R900.End.A1 handles.KR6R900.End.B1 handles.KR6R900.End.C1];
            RobotData(i).Real.X = handles.KR6R900.Real.X;
            RobotData(i).Real.Y = handles.KR6R900.Real.Y;
            RobotData(i).Real.Z = handles.KR6R900.Real.Z;
            RobotData(i).Real.A = handles.KR6R900.Real.A;
            RobotData(i).Real.B = handles.KR6R900.Real.B;
            RobotData(i).Real.C = handles.KR6R900.Real.C;
            
            i = i+1;
            handles.Robot = Robot;
            set(handles.Number_of_Data, 'String',i); % zaktualizuj wartosæ Numbre of data na panelu

            
        end

    else %w przeciwnym wypadku fail
        h = msgbox('Communication AXIS_ACT Failed', 'Fail');
        waitfor(h)
        break;
    end
    if StopCommand
        break;
    end
    
    time = toc; %weŸ aktualna wartosæ czasu
    set(handles.Actual_time, 'String',time); % zaktualizuj wartosæ czasu na panelu

end
handles.CommunicationSts = 1;
update_panels(handles) 
guidata(hObject, handles);


function Monitor_Value_Callback(hObject, ~, handles)
% hObject    handle to Monitor_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Monitor_Value as text
%        str2double(get(hObject,'String')) returns contents of Monitor_Value as a double

% ten przycisk nie ma ¿adnej obs³ugi wartoœc tego przycisku jest pobierana
% w funckji Monitor_Callback


% --- Executes during object creation, after setting all properties.
function Monitor_Value_CreateFcn(hObject, ~, handles)
% hObject    handle to Monitor_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Stop.
function Stop_Callback(hObject, ~, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funcka s³u¿y do zatrzymanania funkcji Monitor_Callback
global StopCommand;
StopCommand = 1; % u¿ywane w Monitor_Callback


% --- Executes on button press in VIS_Joint.
function VIS_Joint_Callback(hObject, ~, handles)
% hObject    handle to VIS_Joint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% funkcja wizualizujaca przemieszenie Jointów

global RobotData;
if isfield(RobotData,'time') && isfield(RobotData,'Joints') && isfield(RobotData,'End')
    % sprawdzenie czy dane s¹ prawid³owe
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
    % konwersja z tablicy struktur na poszczególne zmienne
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

    Joint1_sum = sum(abs(diff(Joint1)));
    Joint2_sum = sum(abs(diff(Joint2)));
    Joint3_sum = sum(abs(diff(Joint3)));
    Joint4_sum = sum(abs(diff(Joint4)));
    Joint5_sum = sum(abs(diff(Joint5)));
    Joint6_sum = sum(abs(diff(Joint6)));
    disp('Joint 1 suma przemieszczenia');
    disp(Joint1_sum);
    disp('Joint 2 suma przemieszczenia');
    disp(Joint2_sum);
    disp('Joint 3 suma przemieszczenia');
    disp(Joint3_sum);
    disp('Joint 4 suma przemieszczenia');
    disp(Joint4_sum);
    disp('Joint 5 suma przemieszczenia');
    disp(Joint5_sum);
    disp('Joint 6 suma przemieszczenia');
    disp(Joint6_sum);
    
else
    h = msgbox('No data'); % jeœli nie ma nic do wyœwietlenia
    waitfor(h) 
end


% --- Executes on button press in RobotDisplay.
function RobotDisplay_Callback(hObject, ~, handles)
% hObject    handle to RobotDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RobotDisplay
% funkcja do zatrzymania lub wznowienia odœwie¿ania wizualizacji robota.
% KR6R900.display jest u¿ywane zarówno w funkcji kctdisprobot_V4 jak i update_panels
handles.KR6R900.display = get(hObject,'Value');
handles.KR6R900 = kctdisprobot_V4(handles.KR6R900);   
%zaktualizuj po³o¿enie robota
update_panels(handles)                                                     %zaktualizuj wartosci Position end of effector
% Update handles structure
guidata(hObject, handles);


% --- Executes on slider movement.
function S_X_Callback(hObject, ~, handles)
% hObject    handle to S_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% funkcja wykonuje procedure wys³ania ramki do robota z aktualn¹ nastaw¹
% parametru 
X_pos = get(hObject,'Value');
set(handles.X_value, 'String', num2str(X_pos, 3)); 
send_request(handles, 'XP1.X', X_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_X_CreateFcn(hObject, ~, handles)
% hObject    handle to S_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.

%inicjalizacja suwaka
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Workspace(1,1));
set(hObject, 'Max', KR6R900.Workspace(1,2));


guidata(hObject, handles);



function X_value_Callback(hObject, ~, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_value as text
%        str2double(get(hObject,'String')) returns contents of X_value as a double
X_pos = str2double(get(hObject,'String'));
Min = get(handles.S_X, 'Min');
Max = get(handles.S_X, 'Max');

if isnumeric(X_pos) && X_pos >= Min && X_pos <= Max
    % jeœli wszystko jest ok aktualizuj slider i wyœlij polecenie do robota
    set(handles.S_X, 'String', X_pos);                % zaktualizuj wartoœc slidera
    set(handles.S_X, 'Value', X_pos);                 % zaktualizuj wartoœc slidera
    send_request(handles, 'XP1.X', X_pos)
else
    %jeœli nie jest ok zachowaj poprzednia wartosæ
    set(hObject, 'String', get(handles.S_X, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end
guidata(hObject, handles);






% --- Executes during object creation, after setting all properties.
function X_value_CreateFcn(hObject, ~, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on slider movement.
function S_Y_Callback(hObject, ~, handles)
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
function S_Y_CreateFcn(hObject, ~, handles)
% hObject    handle to S_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Workspace(1,3));
set(hObject, 'Max', KR6R900.Workspace(1,4));


guidata(hObject, handles);



function Y_value_Callback(hObject, ~, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_value as text
%        str2double(get(hObject,'String')) returns contents of X_value as a double
Y_pos = str2double(get(hObject,'String'));
Min = get(handles.S_Y, 'Min');
Max = get(handles.S_Y, 'Max');

if isnumeric(Y_pos) && Y_pos >= Min && Y_pos <= Max
    % jeœli wszystko jest ok aktualizuj slider i wyœlij polecenie do robota
    set(handles.S_Y, 'String', Y_pos);                % zaktualizuj wartoœc slidera
    set(handles.S_Y, 'Value', Y_pos);                 % zaktualizuj wartoœc slidera
    send_request(handles, 'XP1.Y', Y_pos)
else
    %jeœli nie jest ok zachowaj poprzednia wartosæ
    set(hObject, 'String', get(handles.S_Y, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Y_value_CreateFcn(hObject, ~, ~)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function S_Z_Callback(hObject, ~, handles)
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
function S_Z_CreateFcn(hObject, ~, handles)
% hObject    handle to S_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.Workspace(1,5));
set(hObject, 'Max', KR6R900.Workspace(1,6));

guidata(hObject, handles);



function Z_value_Callback(hObject, ~, handles)
% hObject    handle to Z_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_value as text
%        str2double(get(hObject,'String')) returns contents of Z_value as a double
Z_pos = str2double(get(hObject,'String'));
Min = get(handles.S_Z, 'Min');
Max = get(handles.S_Z, 'Max');

if isnumeric(Z_pos) && Z_pos >= Min && Z_pos <= Max
    % jeœli wszystko jest ok aktualizuj slider i wyœlij polecenie do robota
    set(handles.S_Z, 'String', Z_pos);                % zaktualizuj wartoœc slidera
    set(handles.S_Z, 'Value', Z_pos);                 % zaktualizuj wartoœc slidera
    send_request(handles, 'XP1.Z', Z_pos)
else
    %jeœli nie jest ok zachowaj poprzednia wartosæ
    set(hObject, 'String', get(handles.S_Z, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Z_value_CreateFcn(hObject, ~, handles)
% hObject    handle to Z_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function S_A_Callback(hObject, ~, handles)
% hObject    handle to S_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
A_pos = get(hObject,'Value');
set(handles.A_value, 'String', num2str(A_pos, 3)); 
send_request(handles, 'XP1.A', A_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_A_CreateFcn(hObject, ~, handles)
% hObject    handle to S_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
                                                                      % wczytaj parametry robota i przypisz wartoœci domyœlne
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.A.min);
set(hObject, 'Max', KR6R900.A.max);

guidata(hObject, handles);



function A_value_Callback(hObject, ~, handles)
% hObject    handle to A_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_value as text
%        str2double(get(hObject,'String')) returns contents of A_value as a double
A_pos = str2double(get(hObject,'String'));
Min = get(handles.S_A, 'Min');
Max = get(handles.S_A, 'Max');

if isnumeric(A_pos) && A_pos >= Min && A_pos <= Max
    % jeœli wszystko jest ok aktualizuj slider i wyœlij polecenie do robota
    set(handles.S_A, 'String', A_pos);                % zaktualizuj wartoœc slidera
    set(handles.S_A, 'Value', A_pos);                 % zaktualizuj wartoœc slidera
    send_request(handles, 'XP1.A', A_pos)
else
    %jeœli nie jest ok zachowaj poprzednia wartosæ
    set(hObject, 'String', get(handles.S_A, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function A_value_CreateFcn(hObject, ~, handles)
% hObject    handle to A_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function S_B_Callback(hObject, ~, handles)
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
function S_B_CreateFcn(hObject, ~, handles)
% hObject    handle to S_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
                                                                      % wczytaj parametry robota i przypisz wartoœci domyœlne
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.B.min);
set(hObject, 'Max', KR6R900.B.max);

guidata(hObject, handles);



function B_value_Callback(hObject, ~, handles)
% hObject    handle to B_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_value as text
%        str2double(get(hObject,'String')) returns contents of B_value as a double
B_pos = str2double(get(hObject,'String'));
Min = get(handles.S_B, 'Min');
Max = get(handles.S_B, 'Max');

if isnumeric(B_pos) && B_pos >= Min && B_pos <= Max
    % jeœli wszystko jest ok aktualizuj slider i wyœlij polecenie do robota
    set(handles.S_B, 'String', B_pos);                % zaktualizuj wartoœc slidera
    set(handles.S_B, 'Value', B_pos);                 % zaktualizuj wartoœc slidera
    send_request(handles, 'XP1.B', B_pos)
else
    %jeœli nie jest ok zachowaj poprzednia wartosæ
    set(hObject, 'String', get(handles.S_B, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function B_value_CreateFcn(hObject, ~, handles)
% hObject    handle to B_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function S_C_Callback(hObject, ~, handles)
% hObject    handle to S_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
C_pos = get(hObject,'Value');
set(handles.C_value, 'String', num2str(C_pos, 3)); 
send_request(handles, 'XP1.C', C_pos)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function S_C_CreateFcn(hObject, ~, handles)
% hObject    handle to S_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
                                                                    % wczytaj parametry robota i przypisz wartoœci domyœlne
load KR6R900_V4                                                                        % wczytaj parametry robota i przypisz wartoœci domyœlne
set(hObject, 'Min', KR6R900.C.min);
set(hObject, 'Max', KR6R900.C.max);

guidata(hObject, handles);



function C_value_Callback(hObject, ~, handles)
% hObject    handle to C_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_value as text
%        str2double(get(hObject,'String')) returns contents of C_value as a double
C_pos = str2double(get(hObject,'String'));
Min = get(handles.S_C, 'Min');
Max = get(handles.S_C, 'Max');

if isnumeric(C_pos) && C_pos >= Min && C_pos <= Max
    % jeœli wszystko jest ok aktualizuj slider i wyœlij polecenie do robota
    set(handles.S_C, 'String', C_pos);                % zaktualizuj wartoœc slidera
    set(handles.S_C, 'Value', C_pos);                 % zaktualizuj wartoœc slidera
    send_request(handles, 'XP1.C', C_pos)
else
    %jeœli nie jest ok zachowaj poprzednia wartosæ
    set(hObject, 'String', get(handles.S_C, 'Value'));                         % obs³uga b³êdnej wartoœci
    
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function C_value_CreateFcn(hObject, ~, handles)
% hObject    handle to C_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function send_request(handles, name, data)
% funkcja s³u¿¹ca do wysy³ania poleceñ do robota z zadan¹ pozycj¹
% preconditions
pre_mess = [0 1 0 15 1 0];
value = double(num2str(data,5));
identifier = [length(name) double(name) 0 length(value)];
mess = [pre_mess identifier value]';
mess(4) = length(mess)-4;
% char(mess')
% mess'
    
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by³a ju¿ rozpoczynana komunikacja
    Robot = handles.Robot;
else
    Robot=tcpip('192.168.1.100',7000); % init comunication
end

if strcmp(Robot.Status,'open') %sprawdzenie czy Robot jest ju¿ w stanie open
    
else
    fopen(Robot);
end
wait_for_idle_state(Robot, 2); % max timeout
fwrite(Robot,mess);            % wys³anie wiadomoœci do robota
handles.CommunicationSts = 1;


% --- Executes on button press in Stop_Communication.
function Stop_Communication_Callback(hObject, ~, handles)
% hObject    handle to Stop_Communication (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funkacja s³u¿¹ca do zatrzymania komunikacji
handles.CommunicationSts = 0;
if isfield(handles, 'Robot') % obiek tcpip sprawdzenie czy by³a ju¿ rozpoczynana komunikacja
    
    if strcmp(handles.Robot.Status,'closed') %sprawdzenie czy Robot jest ju¿ w stanie closed
    
    else
        fclose(handles.Robot);
    end
    
else
    % nie trzeba nic robiæ
end
update_panels(handles)
guidata(hObject, handles);



function Logs_Name_Callback(hObject, ~, handles)
% hObject    handle to Logs_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Logs_Name as text
%        str2double(get(hObject,'String')) returns contents of Logs_Name as a double

% nieobs³ugiwane wartoœæ u¿ywana w Save_As_txt_Callback

% --- Executes during object creation, after setting all properties.
function Logs_Name_CreateFcn(hObject, ~, handles)
% hObject    handle to Logs_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save_As_txt.
function Save_As_txt_Callback(hObject, ~, handles)
% hObject    handle to Save_As_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funkcja s³u¿¹ca do zapisania danych pobranych przez Monitor_Callback do
% pliku tesktowego
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
        X_real(i) = RobotData(i).Real.X;
        Y_real(i) = RobotData(i).Real.Y;
        Z_real(i) = RobotData(i).Real.Z;
        A_real(i) = RobotData(i).Real.A;
        B_real(i) = RobotData(i).Real.B;
        C_real(i) = RobotData(i).Real.C;
        
    end
    header = 'time	Joint1	Joint2	Joint3	Joint4	Joint5	Joint6	X	Y	Z	A	B	C X_real Y_real Z_real A_real B_real C_real';
    % Data = [time' Joint1' Joint2' Joint3' Joint4' Joint5' Joint6' X' Y' Z' A' B' C'];
    % Data = [time Joint1 Joint2 Joint3 Joint4 Joint5 Joint6 X Y Z A B C];
    Data_format = '%12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f \n';
    file = fopen(File_name,'wt');
    fprintf(file, '%50s\n', header);
    for i=1:length(time)
        Data = [time(i) Joint1(i) Joint2(i) Joint3(i) Joint4(i) Joint5(i) Joint6(i) X(i) Y(i) Z(i) A(i) B(i) C(i) X_real(i) Y_real(i) Z_real(i) A_real(i) B_real(i) C_real(i)];
        fprintf(file, Data_format, Data);
    end
    fclose(file);
else
    h = msgbox('No data'); % jeœli nie ma nic do wyœwietlenia
    waitfor(h) 
end



    
    


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, ~, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in Set_Actual_Position.
function Set_Actual_Position_Callback(hObject, ~, handles)
% hObject    handle to Set_Actual_Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

X_pos = get(handles.S_X,'Value');
send_request(handles, 'XP1.X', X_pos);

Y_pos = get(handles.S_Y,'Value');
send_request(handles, 'XP1.Y', Y_pos);

Z_pos = get(handles.S_Z,'Value');
send_request(handles, 'XP1.Z', Z_pos);

A_pos = get(handles.S_X,'Value');
send_request(handles, 'XP1.A', A_pos);

B_pos = get(handles.S_Y,'Value');
send_request(handles, 'XP1.B', B_pos);

C_pos = get(handles.S_Z,'Value');
send_request(handles, 'XP1.C', C_pos);


% --- Executes on button press in VIS_end_of_efector.
function VIS_end_of_efector_Callback(hObject, ~, handles)
% hObject    handle to VIS_end_of_efector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% funkcja wizualizuj¹ca pocycje koñcókie efektora w czasie
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
    h = msgbox('No data'); % jeœli nie ma nic do wyœwietlenia
    waitfor(h) 
end


% --- Executes on button press in VIS_velocity.
function VIS_velocity_Callback(hObject, ~, handles)
% hObject    handle to VIS_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funkcja wizualizuj¹ca prêdkoœci Jointów robota w osi X Y Z oraz prêdkoœci
% absolutnej koncówki efektora
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


    % wyliczanie prêdkoœci Jointów 
    vJoint1 = differenction(Joint1, time);
    vJoint2 = differenction(Joint2, time);
    vJoint3 = differenction(Joint3, time);
    vJoint4 = differenction(Joint4, time);
    vJoint5 = differenction(Joint5, time);
    vJoint6 = differenction(Joint6, time);
    
    %macierz prêdkoœci
    VJoints= [vJoint1; vJoint2; vJoint3; vJoint4; vJoint5; vJoint6];
    
    % wyliczanie prêdkoœci X Y Z
    vX = differenction(X, time);
    vY = differenction(Y, time);
    vZ = differenction(Z, time);
    
    % macierz prêdkoœci
    VXYZ = [vX; vY; vZ];
    
    %prêdkoœæ absolutna
    V = sqrt(vJoint1.^2)+sqrt(vJoint2.^2)+sqrt(vJoint3.^2)+sqrt(vJoint4.^2)+sqrt(vJoint5.^2)+sqrt(vJoint6.^2) ;

    %V = sqrt(vX.^2 + vY.^2 + vZ.^2);
    figure(3); % Pedkoœæ
    
    subplot(3,1,1)
    
    plot(time, VJoints);
    title('Joint Velocity')
    xlabel('time [s]')
    ylabel('Joint speed [deg /s]')
    legend('Joint 1', 'Joint 2', 'Joint 3', 'Joint 4', 'Joint 5', 'Joint 6');

    subplot(3,1,2)
    
    plot(time, VXYZ);
    title('End of Effector Velocity')
    xlabel('time [s]')
    ylabel(' speed [mm /s]')
    legend('v_X', 'v_Y', 'v_Z');
    
    subplot(3,1,3)

    plot(time, V);
    title('Absolute Joint Velocity')
    xlabel('time [s]')
    ylabel('Joints speed [deg /s]')
    
    Joint1_sum = sum(abs(diff(vJoint1)));
    Joint2_sum = sum(abs(diff(vJoint2)));
    Joint3_sum = sum(abs(diff(vJoint3)));
    Joint4_sum = sum(abs(diff(vJoint4)));
    Joint5_sum = sum(abs(diff(vJoint5)));
    Joint6_sum = sum(abs(diff(vJoint6)));
    disp('Suma prêdkoœci');
    disp(sum([Joint1_sum Joint2_sum Joint3_sum Joint4_sum Joint5_sum Joint6_sum]));

else
    h = msgbox('No data'); % jeœli nie ma nic do wyœwietlenia
    waitfor(h) 
end


% --- Executes on button press in VIS_acceleration.
function VIS_acceleration_Callback(hObject, ~, handles)
% hObject    handle to VIS_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funkcja wizualizuj¹ca przyœpieszenia Jointów robota w osi X Y Z oraz prêdkoœci
% absolutnej koncówki efektora
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
    
    
    % wyliczanie przyœpieszeñ jointów
    aJoint1 = differenction(differenction(Joint1, time),time);
    aJoint2 = differenction(differenction(Joint2, time),time);
    aJoint3 = differenction(differenction(Joint3, time),time);
    aJoint4 = differenction(differenction(Joint4, time),time);
    aJoint5 = differenction(differenction(Joint5, time),time);
    aJoint6 = differenction(differenction(Joint6, time),time);
    
    % macierz przyœpieszeñ
    aJoints= [aJoint1; aJoint2; aJoint3; aJoint4; aJoint5; aJoint6];
    
    % wyliczanie przyœpieszeñ pozycji
    aX = differenction(differenction(X, time),time);
    aY = differenction(differenction(Y, time),time);
    aZ = differenction(differenction(Z, time),time);
    
    % macierz przyœpieszeñ
    AXYZ = [aX; aY; aZ];
    
    % przyœpieszenie absolutne
    A = sqrt(aJoint1.^2)+sqrt(aJoint2.^2)+sqrt(aJoint3.^2)+sqrt(aJoint4.^2)+sqrt(aJoint5.^2)+sqrt(aJoint6.^2) ;
    %A = sqrt(aX.^2 + aY.^2 + aZ.^2);
    figure(4); 
    
    subplot(3,1,1)

    plot(time, aJoints);
    title('Joint Acceleration')
    xlabel('time [s]')
    ylabel('Joint speed [deg /s^2]')
    legend('Joint 1', 'Joint 2', 'Joint 3', 'Joint 4', 'Joint 5', 'Joint 6');

    subplot(3,1,2)

    plot(time, AXYZ);
    title('End of Effector Acceleration')
    xlabel('time [s]')
    ylabel(' speed [mm /s^2]')
    legend('v_X', 'v_Y', 'v_Z');
    
    subplot(3,1,3)

    plot(time, A);
    title('Absolute Joint Acceleration')
    xlabel('time [s]')
    ylabel('Joint speed [deg /s^2]')
    
    Joint1_sum = sum(abs(diff(aJoint1)));
    Joint2_sum = sum(abs(diff(aJoint2)));
    Joint3_sum = sum(abs(diff(aJoint3)));
    Joint4_sum = sum(abs(diff(aJoint4)));
    Joint5_sum = sum(abs(diff(aJoint5)));
    Joint6_sum = sum(abs(diff(aJoint6)));
    disp('Suma przyœpieszeñ');
    disp(sum([Joint1_sum Joint2_sum Joint3_sum Joint4_sum Joint5_sum Joint6_sum]));    
    
else
    h = msgbox('No data'); % jeœli nie ma nic do wyœwietlenia
    waitfor(h) 
end


% --- Executes on button press in Get_Real_Values.
function Get_Real_Values_Callback(hObject, eventdata, handles)
% hObject    handle to Get_Real_Values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% funkcja wywo³uje funkcje Get_Position_XYZ_ABC tak aby mo¿na w dowolnym
% odwo³aniu wywo³aæ ta funkcje - jak bêdzie taka potrzeba bêdzie mo¿na
% dodac t¹ funkcje do wywo³ania  Get_Position_Callback
handles = Get_Position_XYZ_ABC(handles); 
guidata(hObject, handles);
