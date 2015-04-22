%    KCTDEMO - Demonstration of KUKA Control Toolbox    
%
%    Usage: kctdemo()
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

fprintf(' KUKA Control Toolbox Demo. \n Press any key to continue... \n')
pause

kctsel = input(' If you want to connect the robot press 1, any key if it is already connect:');

if kctsel == 1


    kctmodel = input(' Insert a string with your KUKA robot model:');
    kctinit(kctmodel)
    addr = input(' Insert a string with your KUKA controller''s IP address:');
    t = kctclient(addr,0.15);
end

disp(' Press any key to move the robot.')
pause
disp(' Robot moving...')
pause(0.1);
[robotstate,warn] = kctsetjoint([0 0 45 0 -45 0],50);

disp(' Press any key to display the dynamics of the robot:')
pause

kctdispdyn(robotstate);

disp(' Press any key to move the robot along a square path:')
pause
disp(' Home positioning...')
kcthome()
disp(' ...')

  P=[450  225 100  0 90   0;
     450  225 550 10 60 -10;
     450 -225 550  0 90   0;
     450 -225 100  0 90  20;
     450  225 100  0 90   0];
  
  kctpathxyz(P,30,1);

disp(' Press any key to use the KCT GUI for robot motion control:')
pause
kctdrivegui
disp(' The demo is finished.')
  






  
