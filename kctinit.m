%    KCTINIT - Initialize robot's data
%
%    The function extracts robot's data and save them in a .mat file
%    The robot data are necessary for the operation of the kinematics functions
%    The function also loads tcpip comunication options
%
%    Usage: kctinit(robotname)
%
%    Arguments:
% 	       robotname = string of the robot's model name (Ex: 'KR3')
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


function kctinit(robotname)

    if(nargin ~= 1)
       display(' ERROR : kctinit requires one input.'); 
       return;
    end
        
    krd=load('kctrobotdata');

    i=1;
    while ~strcmp(robotname,krd.kctrobotdata(i).name)
        i=i+1;
    end

    kctrobotlinks=[krd.kctrobotdata(i).link1,krd.kctrobotdata(i).link2,krd.kctrobotdata(i).link3,krd.kctrobotdata(i).link4,krd.kctrobotdata(i).link5,krd.kctrobotdata(i).link6];
    save('kctrobotlinks.mat','kctrobotlinks');
    
    kctchframe(eye(4));
    
    % Load TCP/IP comunication type
    global kcttcpiptype;
    load('kcttcpiptype.mat');
    
