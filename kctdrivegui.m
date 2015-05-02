%    KCTDRIVEGUI - GUI for robot motion
%
%    The Function displays a graphic interface for robot motion for
%    kctdrivegui.fig
%
%    Usage: kctdrivegui()

%    Copyright (c) 2009 Stefano Scheggi
%    Department of Information Engineering
%    University of Siena
%
%    This file is part of KCT (Kuka Control Toolbox).
%
%    KCT is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    KCT is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with KCT. If not, see <http://www.gnu.org/licenses/>.

function varargout = kctdrivegui(varargin)
    % KCTDRIVEGUI M-file for kctdrivegui.fig
    %      KCTDRIVEGUI, by itself, creates a new KCTDRIVEGUI or raises the existing
    %      singleton*.
    %
    %      H = KCTDRIVEGUI returns the handle to a new KCTDRIVEGUI or the handle to
    %      the existing singleton*.
    %
    %      KCTDRIVEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in KCTDRIVEGUI.M with the given input arguments.
    %
    %      KCTDRIVEGUI('Property','Value',...) creates a new KCTDRIVEGUI or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before kctdrivegui_OpeningFunction gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to kctdrivegui_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Copyright 2002-2003 The MathWorks, Inc.
    % Edit the above text to modify the response to help kctdrivegui
    % Last Modified by GUIDE v2.5 10-Sep-2009 15:14:33
    % Begin initialization code - DO NOT EDIT
        gui_Singleton = 1;
        gui_State = struct('gui_Name',       mfilename, ...
                           'gui_Singleton',  gui_Singleton, ...
                           'gui_OpeningFcn', @kctdrivegui_OpeningFcn, ...
                           'gui_OutputFcn',  @kctdrivegui_OutputFcn, ...
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


% --- Executes just before kctdrivegui is made visible.
function kctdrivegui_OpeningFcn(hObject, ~, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to kctdrivegui (see VARARGIN)

    % Load the background image into Matlab
    % if image is not in the same directory as the GUI files, you must use the 
    % set close confirmation
        set(handles.figure1,'CloseRequestFcn',@closeGUI);
    % full path name of the iamge file
        backgroundImage = importdata('kcticon/logo_kct.bmp');
    %select the axes
        axes(handles.kctlogo);
    %place image onto the axes
        image(backgroundImage);
    %remove the axis tick marks
        axis off
    % Home button image
        home_icon = importdata('kcticon/home_icon.bmp');
        set(handles.home_button,'CDATA',home_icon);
    % Play button image
        play_icon = importdata('kcticon/play_icon.bmp');
        set(handles.play_button,'CDATA',play_icon);
    % Path button image
        path_icon = importdata('kcticon/path_icon.bmp');
        set(handles.pushbutton10,'CDATA',path_icon);
    % Zoom button image
        zoom_icon = importdata('kcticon/zoom_icon.bmp');
        set(handles.pushbutton9,'CDATA',zoom_icon);
        warning on
    % Load robot joint data
        kctdrivegui_initialize(handles, 100);
        
        
        global kctguipath;
        kctguipath = [];          
    % Global var for robot bound visualization
        global kctshowbound;
        kctshowbound = 0;
    % Choose default command line output for kctdrivegui
        handles.output = hObject;
    % Update handles structure
        guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = kctdrivegui_OutputFcn(~, ~, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

% % --- Executes on button press in quit_pushbutton.
% function quit_pushbutton_Callback(hObject, eventdata, handles)
%     % hObject    handle to quit_pushbutton (see GCBO)
%     % eventdata  reserved - to be defined in a future version of MATLAB
%     % handles    structure with handles and user data (see GUIDATA)
%     clf;
%     close(100);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
    % hObject    handle to slider1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of
    %        slider
  
    % obtains the slider value from the slider component
        slider1Value = get(handles.slider1,'Value');
    % puts the slider value into the edit text component
        set(handles.editText_slider1,'String', num2str(slider1Value));
    % Update handles structure
        guidata(hObject, handles);
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,1) = slider1Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to slider1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background, change
    %       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
        usewhitebg = 1;
        if usewhitebg
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
    % hObject    handle to slider2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    
    % obtains the slider value from the slider component
        slider2Value = get(handles.slider2,'Value');
    % puts the slider value into the edit text component
        set(handles.editText_slider2,'String', num2str(slider2Value));
    % Update handles structure
        guidata(hObject, handles);
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,2) = slider2Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to slider2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background, change
    %       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
        usewhitebg = 1;
        if usewhitebg
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
    % hObject    handle to slider3 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    
    % obtains the slider value from the slider component
        slider3Value = get(handles.slider3,'Value');
    % puts the slider value into the edit text component
        set(handles.editText_slider3,'String', num2str(slider3Value));
    % Update handles structure
        guidata(hObject, handles);   
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,3) = slider3Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to slider3 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background, change
    %       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
        usewhitebg = 1;
        if usewhitebg
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
    % hObject    handle to slider4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    
    % obtains the slider value from the slider component
        slider4Value = get(handles.slider4,'Value');
    % puts the slider value into the edit text component
        set(handles.editText_slider4,'String', num2str(slider4Value));
    % Update handles structure
        guidata(hObject, handles);  
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,4) = slider4Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to slider4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background, change
    %       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
        usewhitebg = 1;
        if usewhitebg
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
    % hObject    handle to slider5 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    
    % obtains the slider value from the slider component
        slider5Value = get(handles.slider5,'Value');
    % puts the slider value into the edit text component
        set(handles.editText_slider5,'String', num2str(slider5Value));
    % Update handles structure
        guidata(hObject, handles);   
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,5) = slider5Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to slider5 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background, change
    %       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
        usewhitebg = 1;
        if usewhitebg
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
    % hObject    handle to slider6 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    
    % obtains the slider value from the slider component
        slider6Value = get(handles.slider6,'Value');
    % puts the slider value into the edit text component
        set(handles.editText_slider6,'String', num2str(slider6Value));
    % Update handles structure
        guidata(hObject, handles);   
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,6) = slider6Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to slider6 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background, change
    %       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
        usewhitebg = 1;
        if usewhitebg
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

function editText_slider1_Callback(hObject, eventdata, handles)
    % hObject    handle to editText_slider1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editText_slider1 as text
    %        str2double(get(hObject,'String')) returns contents of editText_slider1 as a double

    % get the string for the editText component
        slider1Value = get(handles.editText_slider1,'String');
    % convert from string to number if possible, otherwise returns empty
        slider1Value = str2num(slider1Value);
    % if user inputs something is not a number, or if the input is less than 0
    % or greater than 100, then the slider value defaults to 0
        if (isempty(slider1Value) || slider1Value < -150 || slider1Value > 150)
            set(handles.slider1,'Value',0);
            set(handles.editText_slider1,'String','0');
        else
            set(handles.slider1,'Value',slider1Value);
        end       
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,1) = slider1Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function editText_slider1_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to editText_slider1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc
            set(hObject,'BackgroundColor','white');
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

function editText_slider2_Callback(hObject, eventdata, handles)
    % hObject    handle to editText_slider2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editText_slider2 as text
    %        str2double(get(hObject,'String')) returns contents of editText_slider2 as a double
    
    % get the string for the editText component
        slider2Value = get(handles.editText_slider2,'String');
    % convert from string to number if possible, otherwise returns empty
        slider2Value = str2num(slider2Value);
    % if user inputs something is not a number, or if the input is less than 0
    % or greater than 100, then the slider value defaults to 0
        if (isempty(slider2Value) || slider2Value < -30 || slider2Value > 120)
            set(handles.slider2,'Value',0);
            set(handles.editText_slider2,'String','0');
        else
            set(handles.slider2,'Value',slider2Value);
        end       
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,2) = slider2Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function editText_slider2_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to editText_slider2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc
            set(hObject,'BackgroundColor','white');
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

function editText_slider3_Callback(hObject, eventdata, handles)
    % hObject    handle to editText_slider3 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editText_slider3 as text
    %        str2double(get(hObject,'String')) returns contents of editText_slider3 as a double
    
    % get the string for the editText component
        slider3Value = get(handles.editText_slider3,'String');
    % convert from string to number if possible, otherwise returns empty
        slider3Value = str2num(slider3Value);
    % if user inputs something is not a number, or if the input is less than 0
    % or greater than 100, then the slider value defaults to 0
        if (isempty(slider3Value) || slider3Value < -130 || slider3Value > 130)
            set(handles.slider3,'Value',0);
            set(handles.editText_slider3,'String','0');
        else
            set(handles.slider3,'Value',slider3Value);
        end       
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,3) = slider3Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function editText_slider3_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to editText_slider3 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc
            set(hObject,'BackgroundColor','white');
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

function editText_slider4_Callback(hObject, eventdata, handles)
    % hObject    handle to editText_slider4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editText_slider4 as text
    %        str2double(get(hObject,'String')) returns contents of editText_slider4 as a double
    
    % get the string for the editText component
        slider4Value = get(handles.editText_slider4,'String');
    % convert from string to number if possible, otherwise returns empty
        slider4Value = str2num(slider4Value);
    % if user inputs something is not a number, or if the input is less than 0
    % or greater than 100, then the slider value defaults to 0
        if (isempty(slider4Value) || slider4Value < -110 || slider4Value > 110)
            set(handles.slider4,'Value',0);
            set(handles.editText_slider4,'String','0');
        else
            set(handles.slider4,'Value',slider4Value);
        end        
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,4) = slider4Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function editText_slider4_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to editText_slider4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc
            set(hObject,'BackgroundColor','white');
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

function editText_slider5_Callback(hObject, eventdata, handles)
    % hObject    handle to editText_slider5 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editText_slider5 as text
    %        str2double(get(hObject,'String')) returns contents of editText_slider5 as a double
    
    % get the string for the editText component
        slider5Value = get(handles.editText_slider5,'String');
    % convert from string to number if possible, otherwise returns empty
        slider5Value = str2num(slider5Value);
    % if user inputs something is not a number, or if the input is less than 0
    % or greater than 100, then the slider value defaults to 0
        if (isempty(slider5Value) || slider5Value < -130 || slider5Value > 130)
            set(handles.slider5,'Value',0);
            set(handles.editText_slider5,'String','0');
        else
            set(handles.slider5,'Value',slider5Value);
        end       
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,5) = slider5Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function editText_slider5_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to editText_slider5 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc
            set(hObject,'BackgroundColor','white');
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

function editText_slider6_Callback(hObject, eventdata, handles)
    % hObject    handle to editText_slider6 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editText_slider6 as text
    %        str2double(get(hObject,'String')) returns contents of editText_slider6 as a double
    
    % get the string for the editText component
        slider6Value = get(handles.editText_slider6,'String');
    % convert from string to number if possible, otherwise returns empty
        slider6Value = str2num(slider6Value);
    % if user inputs something is not a number, or if the input is less than 0
    % or greater than 100, then the slider value defaults to 0
        if (isempty(slider6Value) || slider6Value < -100 || slider6Value > 100)
            set(handles.slider6,'Value',0);
            set(handles.editText_slider6,'String','0');
        else
            set(handles.slider6,'Value',slider6Value);
        end        
        global kcttempposition;
        global kctrobotlinks;
        global kctshowbound;
        global kctdrivespace;
        kcttempposition(2,6) = slider6Value;
        kctdrivegui_robotDisplay(100);

% --- Executes during object creation, after setting all properties.
function editText_slider6_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to editText_slider6 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc
            set(hObject,'BackgroundColor','white');
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

% --- Executes on button press in stop_button.
function play_button_Callback(hObject, eventdata, handles)
    % hObject    handle to stop_button (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % puts the slider value into the edit text component
        set(handles.text9,'String', 'Running...');
        pause(0.1);
        global kctipvar;
        global kcttempposition;
        kctsetjoint(kcttempposition(2,:),50);
    %puts the slider value into the edit text component
        set(handles.text9,'String', 'Position reached...');

% --- Executes on button press in home_button.
function home_button_Callback(hObject, eventdata, handles)
    % hObject    handle to home_button (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        figure(100)
        clf
        kctdrivegui_initialize(handles, 100);
        global kctshowbound;
        global kctdrivespace;
        if kctshowbound == 1
            kctdrivegui_bound(kctdrivespace, 100);
            return
        else
            kctdrivegui_robotDisplay(100);
            return
        end 

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
    % hObject    handle to checkbox1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkbox1
        global kctshowbound;
        global kctdrivespace;
        kctshowbound = ~kctshowbound;
        if kctshowbound == 1
            kctdrivegui_bound(kctdrivespace, 100);
            return
        else
            kctdrivegui_robotDisplay(100);
            return
        end 
                 
% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
    % hObject    handle to listbox1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from listbox1

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to listbox1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc
            set(hObject,'BackgroundColor','white');
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton7 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % ADD joint frame to joint path vector
        global kctguipath;
        global kcttempposition;
        kctguipath(end+1,:) = kcttempposition(2,:);
        prevstr = get(handles.listbox1, 'String');
        prevstr{end + 1} = 'Point added...';%strcat('Point ',num2str(size(kctguipath,1)));
        set(handles.listbox1, 'String', prevstr, 'Value', length(prevstr));
        if size(kctguipath,1) > 1
            set(handles.pushbutton10, 'Visible', 'on');
        end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton8 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % REMOVE joint frame to jopint path vector
        global kctguipath;
        global kcttempposition;
        selected = get(handles.listbox1,'Value');
        % Remove selected point from path
        kctguipath = kctguipath([1:selected-1,selected+1:end],:);
        prevstr = get(handles.listbox1, 'String');
        len = length(prevstr);
        if len > 0
          index = 1:len;
          prevstr = prevstr(find(index ~= selected),1);
          set(handles.listbox1, 'String', prevstr, 'Value', min(selected, length(prevstr)));
        end
        if size(kctguipath,1) < 2
            set(handles.pushbutton10, 'Visible', 'off');
        end

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton9 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Show selected path point
    global kctguipath;
    global kcttempposition;
    global kctshowbound;
    global kctdrivespace;
    if size(kctguipath,1) > 0
        selected = get(handles.listbox1,'Value');
        kcttempposition(2,:) = kctguipath(selected,:);
        kctdrivegui_robotDisplay(100);
    end

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton10 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
        % Joint Path Trajectory motion
        global kctipvar;
        global kctguipath;
        % Customizable time
        time = str2num(get(handles.edit9,'String'));
        if time < 1, 
            time = 1; 
            set(handles.edit9,'String', num2str(time));
        end
        
       %% if time > 10, 
       %%     time = 10; 
       %%     set(handles.edit9,'String', num2str(time));
       %% end
       
        % Move robot along the path
        set(handles.text9,'String', 'Running Trajectory...');
        pause(0.2);
        kctpathjoint(kctguipath, time);
        %puts the slider value into the edit text component
        set(handles.text9,'String', 'Trajectory completed...');

function edit9_Callback(hObject, eventdata, handles)
    % hObject    handle to edit9 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of edit9 as text
    %        str2double(get(hObject,'String')) returns contents of edit9 as a double

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to edit9 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc
            set(hObject,'BackgroundColor','white');
        else
            set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
        end

% --- Load robot data for initialization.
function kctdrivegui_initialize(handles, hf_robot)
        % Load robot joint data
        
        
        load('kctrobothome.mat');
        load('kctrobotbound.mat');
        load('kctrobotlinks.mat');
        
        % load KR6R900.Joint
        load ('ActualRobot.mat')
        handles.Joint = [actual_robot.Joint];
        % format short
   
        global kctdrivespace;
        global kcttempposition;
        
        kcthomeposition(2,:) = -kcthomeposition(2,:);
        kcttempposition(2,:) = kcthomeposition(2,:);      
        kctdrivespace = kctworkspace;     
        
        
        % Display Robot
        kctdisprobot(kcttempposition(2,:), hf_robot); 
        set(gcf,'CloseRequestFcn',@kct_closeFigure);
        
        % in Kuka_KR_6_R_900_documentation.pdf page 5
        %  Last Update 2015-05-02 14:35 Mateusz Stachnik
        set(handles.slider1,'Min', handles.Joint(1).Min); 
        set(handles.slider1,'Max', handles.Joint(1).Max); 
        set(handles.slider2,'Min', handles.Joint(2).Min); 
        set(handles.slider2,'Max', handles.Joint(2).Max);
        set(handles.slider3,'Min', handles.Joint(3).Min);
        set(handles.slider3,'Max', handles.Joint(3).Max); 
        set(handles.slider4,'Min', handles.Joint(4).Min);
        set(handles.slider4,'Max', handles.Joint(4).Max);
        set(handles.slider5,'Min', handles.Joint(5).Min); 
        set(handles.slider5,'Max', handles.Joint(5).Max);
        set(handles.slider6,'Min', handles.Joint(6).Min); 
        set(handles.slider6,'Max', handles.Joint(6).Max);
        set(handles.slider1,'Value',kcttempposition(2,1));
        set(handles.slider2,'Value',kcttempposition(2,2));
        set(handles.slider3,'Value',kcttempposition(2,3));
        set(handles.slider4,'Value',kcttempposition(2,4));
        set(handles.slider5,'Value',kcttempposition(2,5));
        set(handles.slider6,'Value',kcttempposition(2,6));
        set(handles.editText_slider1,'String', num2str(kcttempposition(2,1)));
        set(handles.editText_slider2,'String', num2str(kcttempposition(2,2)));
        set(handles.editText_slider3,'String', num2str(kcttempposition(2,3)));
        set(handles.editText_slider4,'String', num2str(kcttempposition(2,4)));
        set(handles.editText_slider5,'String', num2str(kcttempposition(2,5)));
        set(handles.editText_slider6,'String', num2str(kcttempposition(2,6)));
        
        

% --- Function for robot bound display.
function kctdrivegui_bound(kctdrivespace, hf_robot)
        figure(hf_robot);
        plot3([kctdrivespace(1,1) kctdrivespace(1,2)],[kctdrivespace(1,3)...
               kctdrivespace(1,3)],[kctdrivespace(1,5) kctdrivespace(1,5)],...
               'b', 'LineWidth', 1);
        plot3([kctdrivespace(1,1) kctdrivespace(1,1)],[kctdrivespace(1,3)...
               kctdrivespace(1,4)],[kctdrivespace(1,5) kctdrivespace(1,5)],...
               'b', 'LineWidth', 1);   
        plot3([kctdrivespace(1,2) kctdrivespace(1,1)],[kctdrivespace(1,4)...
               kctdrivespace(1,4)],[kctdrivespace(1,5) kctdrivespace(1,5)],...
               'b', 'LineWidth', 1);        
        plot3([kctdrivespace(1,2) kctdrivespace(1,2)],[kctdrivespace(1,4)...
               kctdrivespace(1,3)],[kctdrivespace(1,5) kctdrivespace(1,5)],...
               'b', 'LineWidth', 1);       
        plot3([kctdrivespace(1,1) kctdrivespace(1,2)],[kctdrivespace(1,3)...
               kctdrivespace(1,3)],[kctdrivespace(1,6) kctdrivespace(1,6)],...
               'b', 'LineWidth', 1);
        plot3([kctdrivespace(1,1) kctdrivespace(1,1)],[kctdrivespace(1,3)...
               kctdrivespace(1,4)],[kctdrivespace(1,6) kctdrivespace(1,6)],...
               'b', 'LineWidth', 1);   
        plot3([kctdrivespace(1,2) kctdrivespace(1,1)],[kctdrivespace(1,4)...
               kctdrivespace(1,4)],[kctdrivespace(1,6) kctdrivespace(1,6)],...
               'b', 'LineWidth', 1);        
        plot3([kctdrivespace(1,2) kctdrivespace(1,2)],[kctdrivespace(1,4)...
               kctdrivespace(1,3)],[kctdrivespace(1,6) kctdrivespace(1,6)],...
               'b', 'LineWidth', 1);          
        plot3([kctdrivespace(1,1) kctdrivespace(1,1)],[kctdrivespace(1,3)...
               kctdrivespace(1,3)],[kctdrivespace(1,5) kctdrivespace(1,6)],...
               'b', 'LineWidth', 1);        
        plot3([kctdrivespace(1,2) kctdrivespace(1,2)],[kctdrivespace(1,3)...
               kctdrivespace(1,3)],[kctdrivespace(1,5) kctdrivespace(1,6)],...
               'b', 'LineWidth', 1);        
        plot3([kctdrivespace(1,1) kctdrivespace(1,1)],[kctdrivespace(1,4)...
               kctdrivespace(1,4)],[kctdrivespace(1,5) kctdrivespace(1,6)],...
               'b', 'LineWidth', 1);       
        plot3([kctdrivespace(1,2) kctdrivespace(1,2)],[kctdrivespace(1,4)...
               kctdrivespace(1,4)],[kctdrivespace(1,5) kctdrivespace(1,6)],...
               'b', 'LineWidth', 1);            

% --- Function for robot display.
function kctdrivegui_robotDisplay(hf_robot)
        global kctshowbound
        global kcttempposition
        global kctdrivespace

        figure(hf_robot);
    % Camera Position
        kctcampos = campos();
        kctcamtarget = camtarget();
        kctcamup = camup();
        kctcamva = camva();
        kctcamproj = camproj();
        kctcamdata = struct('CamPosition',kctcampos,'CamTarget',...
                     kctcamtarget,'CamUp',kctcamup,'CamVa',kctcamva,...
                     'CamProj',kctcamproj);
        clf
    % Robot display
        kctdisprobot(kcttempposition(2,:), 100, kctcamdata);
    % Bound display    
        if kctshowbound
            kctdrivegui_bound(kctdrivespace, 100);
            return
        end
        drawnow()
 
% --- Close Dialog
function closeGUI(src,evnt)
%src is the handle of the object generating the callback (the source of the event)
%evnt is the The event data structure (can be empty for some callbacks)
selection = questdlg('Do you want to close kctdrivegui?',...
                     'Close Request Function',...
                     'Yes','No','Yes');
switch selection,
   case 'Yes',
    delete(gcf)
    delete(100)
   case 'No'
     return
end

function kct_closeFigure(src,evnt)
% User-defined close request function 
% to display a question dialog box 
msgboxText{1} =  'Close the kctdrivegui main window!!';
msgbox(msgboxText,'kctdrivegui warning', 'warn');


