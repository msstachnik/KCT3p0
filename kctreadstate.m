%    KCTREADSTATE - Return the current state of the robot
%
%    The function returns a 2x6 matrix containing the actual pose (first row) and
%    joint angles (second row) of the manipulator. The user can change the computing time: 
%    the minimum time on 100 samples is 93.75 ms.
%
%    Usage: kctreadstate()
%
%    Return:
%           A 2x6 matrix cointaining the state of the robot. The first row 
%           contains the pose of the end-effector and the second row the joint 
%           angles of the manipulator.
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

function robotstate = kctreadstate()
	
  global Ts;
  
  global kctipvar;
  global kcttcpiptype;
  
  t = kctipvar;

    tic;
	
	% Reading Data

	v_coor = [];
	v_axis = [];
    
    if kcttcpiptype == 'ICT'
        fwrite(t,'<ask/>');
        B = t.BytesAvailable;
        while t.BytesAvailable < 400 
        end
        DataReceived = char(fread(t,400)); 
        DataReceived = DataReceived';
    elseif kcttcpiptype == 'MEX'
        totalBytesRec = 0;
        DataReceived = '';
        kctsenddatamex('<ask/>');
        [bytesRec, dataRec] = kctrecdatamex();
        dataRec = dataRec([1:bytesRec]);
        DataReceived([1:bytesRec]) = char(dataRec);
        totalBytesRec = totalBytesRec + bytesRec;
        while totalBytesRec < 400
            [bytesRec, dataRec] = kctrecdatamex();
            DataReceived([(size(DataReceived,2)+1):(size(DataReceived,2)+bytesRec)]) = dataRec([1:bytesRec]);
            totalBytesRec = totalBytesRec + bytesRec;
        end
    end    
                
	v_temp=findstr(DataReceived,'"');
    j=1;
    i=5;
                
    while i<17
            try
                temp = DataReceived((v_temp(1,i)+1):(v_temp(1,i+1)-1));
            catch
                disp('system wake up')
                flushinput(t);
                kctstop();
                DataReceived = char(fread(t,400)); 
                DataReceived = DataReceived';
                
                v_temp=findstr(DataReceived,'"');
                temp = DataReceived((v_temp(1,i)+1):(v_temp(1,i+1)-1));
                
            end
            v_coor(1,j) = str2num(temp);                   
            i = i+2;
            j = j+1;
            
    end
                
         i = 29;
         j = 1;
                
    while i<41
          
            temp = DataReceived((v_temp(1,i)+1):(v_temp(1,i+1)-1));
            v_axis(1,j) = str2num(temp);                   
            i = i+2;
            j = j+1;
            
    end
      
     robotstate(1,1:6)=v_coor;
     robotstate(2,1:6)=v_axis;
      
    % Pause for synchronization
    
    tempo=toc;
    while (tempo)<Ts
          
          tempo=toc;       
    end
      
    
 
  
       
