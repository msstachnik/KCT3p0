%    KCTDEMOHAPTIK - Demonstration of KUKA Control Toolbox with HaptiK LIibrary   
%
%    The demontration allows to control the robot manipulator via haptic
%    interface (Haptik Library 1.0 is required)
%
%    Usage: kctdemohaptik()
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

    fprintf(' KUKA Control Toolbox Demo integrated with Haptik Library. \n');
    fprintf(' Required: \n');
    fprintf(' - Haptik Library\n');
    fprintf('   Download (<a href="http://sirslab.dii.unisi.it/haptiklibrary/">http://sirslab.dii.unisi.it/haptiklibrary/</a>). \n');
    
% Initialize the connection if not already initialized    
    kctsel = input(' If you want to connect the robot press 1, any key if it is already connect:');
    if kctsel == 1
        kctmodel = input(' Insert a string with your KUKA robot model:');
        kctinit(kctmodel)
        addr = input(' Insert a string with your KUKA controller''s IP address:');
        t = kctclient(addr,0.015);
    end

% Change the robot reference frame
    global kctrotfr;
    disp(' Changing the robot reference frame...wait.');
    kctchframe(kctrotoz(-90)*kctrotox(90));

% Initialize haptic device
    h = haptikdevice;
    disp(' Haptic device initialized.');
   
% Run the demo
    haptik_all_pose = [];
    kuka_all_pose = [];

    disp(' Now you can control the robot via the haptic device.');
    i=1;
    while i<500
        tic;

        % Read probe position
            pos = read_position(h);
            haptik_all_pose(i,:) = pos;

        % Send back force feedback
            write(h, -1 * pos*2.5/30);
            
            while toc<0.01
            end
            
       % Send velocities to the robot
            vel=(read_position(h)-pos)/0.01;
            kctmovexyz([vel(1,1),vel(1,2),vel(1,3), 0 0 0]*0.015);
            
       i=i+1;
    end
    disp(' Demo finished.');
    disp(' Moving the robot to the HOME position.');

% When the demo finishes place the robot in the HOME position and restabilish 
% the original robot reference frame
    kcthome;
    disp(' Restoring the initial robot reference frame.');
    kctchframe(eye(4));

% Release and clear the haptic device
    close(h); 
    clear h
    disp(' Haptic device closed.');
    