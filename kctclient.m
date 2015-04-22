%    KCTCLIENT - Initialize the MATLAB client for KUKA robot comunication
%
%    The function initializes a TCP/IP connection on the specified URL and port
%    in order to start the comunication with the KUKA robot's server.
%   
%    Usage: t = kctclient(str_address)
%
%    Arguments:
%           str_address = server PC's IP address (string format).
%           SampleTime  = Desired communication time for control.
%                         (minimum value 0.015s)
%    Return:
%           t = handler for communication with the KUKA robot
%
%    See also: KCTCLOSECLIENT
%

%    Copyright (c) 2009 Francesco Chinello, Stefano Scheggi
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

function t = kctclient(str_address,SampleTime)

    if nargin < 1
        display('ERROR : kctclient requires at least one input');  
        return; 
    end
    
    if nargin < 2
        SampleTime = 0.15;
    end

    global Ts;
        Ts = SampleTime;   
    
    global kctipvar;
    global kcttcpiptype;
 
    if exist('kctrobotlinks.mat') && exist('kctrobotframe.mat')
        global kctrobotlinks;
        load('kctrobotlinks.mat'); 
        global kcttom; % type of movement via joint variable or Cartesian; 
        global kctptfr;
        global kctrotfr;
        load('kctrobotframe.mat');       
        kcttom = 0; 
    else
        disp('ERROR: robot not initialized (use kctinit(robotname))');
        return;
    end
if (strcmp(str_address,'offline')==0)     
    disp('KCTCLIENT: connect the robot with MATLAB');
    disp('Start the kctserver.exe on the KUKA robot controller and press any key to continue...');
    pause();
    
    % check if client is connected or not
    isConnected = 0;
    
    if kcttcpiptype == 'ICT'
        try
            %%  Instrument Control Toolbox
            kctipvar = tcpip(str_address,2999);
            t = kctipvar;
            % Set size of receiving buffer, if needed.
            set(t, 'InputBufferSize', 400);
            set(t, 'OutputBufferSize', 100);
            fopen(t);
            disp('Connected on port 2999!');
            disp('Go to ST_SKIPSENS and press Enter...')
            isConnected = 1;
            pause();
        catch
            disp('Connection on port failed');
            if t==-1           
                % Disconnect and clean up the server connection.
                fclose(t);
                delete(t);
                clear t;
            end   
        end
    elseif kcttcpiptype == 'MEX'        
        %%  MEX files
        t = kctclientmex(str_address);
        if t ~= -1    
            disp('Go to ST_SKIPSENS and press Enter...')
            isConnected = 1;
            kctipvar = t;
            pause();
        else    
            kctcloseclientmex();
            isConnected = 0;
        end
    end
    
    if isConnected == 1
        kcthomeposition = kctreadstate();
        save('kctrobothome.mat','kcthomeposition');
        disp('Connection completed, robot will use the following parameters:')
        disp('Home position');
        kcthomeposition
        disp('Frame position and orientation');
        kctptfr
        kctrotfr
    else
        disp('Frame position and orientation');
        kctptfr
        kctipvar
        kctrotfr
        disp('Sample time for communication');
        Ts
    end
 else
     disp('Offline Mode')
      disp('Frame position and orientation');
        kctptfr
        kctrotfr
 end
     
  


