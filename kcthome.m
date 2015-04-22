%    KCTHOME - Drive the robot back to the home position
%
%    The function drives the robot back to the HOME (starting) position. The HOME
%    position is defined in the function kctrsiclient.src.
%
%    Usage: kcthome()
%

%    Copyright (c) 2009 Francesco Chinello
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

function kcthome()

    global kcttom;
    global kctrotfr
    global kctptfr
    global kctipvar;
    t = kctipvar;
    
    homepoint = load('kctrobothome.mat');
        
    if (kcttom == 1) 
        kctsetjoint(-homepoint.kcthomeposition(2,:),50);
        kcttom = 0;
    elseif  (kcttom == 2)
                %%%%%%%%%        
        Hfr = [kctrotfr, kctptfr'; [0 0 0 1]];     
        robotpose = homepoint.kcthomeposition(1,1:3);
        robotstate = kctreadstate();

        xyz = robotstate(1,1:3);
        robotspeed = 5;
        if robotspeed<0 || robotspeed > 100 || (floor(robotspeed) - robotspeed < 0)
            disp('joint percent speed must be an int value between 0 and 100')
            return
        end
        pose_error = robotpose(1:3) - xyz;
        t_stim_pose = (max(abs(pose_error)))/(9*83*robotspeed/100)+0.1;
        if (robotpose(1)~=0)||(robotpose(2)~=0)||(robotpose(3))~=0;
                % translation
            vel = (pose_error/t_stim_pose)*1/83;
            kctmovexyz([vel,0,0,0]);
            tic;
            while toc<t_stim_pose
            end
            kctstop();
        end
                %%%%%%%%%%      
        kcttom = 0;
    else kcttom == 0
        return;
    end
    
    


 