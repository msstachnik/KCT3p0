%    KCTGETBOUND - Display the workspace bounds
%
%    The function displays the robot's bounds.  
%
%    Usage: B = kctgetbound()
%
%    Return:
%           B = Matrix 2x6 containing min & max values of the bounds
%               2nd row contains min & max values of joint 4,5,6.
%           B = [Xmin  Xmax  Zmin  Zmax  Zmin  Zmax;
%                j4min j4max j5min j5max j6min j6max]
%    
%    See also: KCTSETBOUND
%

%    Copyright (c) 2009 Francesco Chinello & Stefano Scheggi
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

function kctworkspace = kctgetbound

    kw = load('kctrobotbound');
    kctworkspace = kw.kctworkspace;

    h_bound = figure();

    kctrobothome = load('kctrobothome.mat');
    df = 40;

    % Box color
        color2 = [0.0,0.0,0.8];
        axis equal; 
        k=[0:pi/4:2*pi];
        d=40;
        Xzvert = [d*0.25*sin(k);d*0.25*sin(k+pi/4);zeros(1,length(k))];
        Yzvert = [d*0.25*cos(k);d*0.25*cos(k+pi/4);zeros(1,length(k))];
        Zzvert = [zeros(1,length(k));zeros(1,length(k));d/2*ones(1,length(k))];

        Xyvert = [d*0.25*sin(k);d*0.25*sin(k+pi/4);zeros(1,length(k))];
        Yyvert = [zeros(1,length(k));zeros(1,length(k));d/2*ones(1,length(k))];
        Zyvert = [d*0.25*cos(k);d*0.25*cos(k+pi/4);zeros(1,length(k))];

        Xxvert = [zeros(1,length(k));zeros(1,length(k));d/2*ones(1,length(k))];
        Yxvert = [d*0.25*cos(k);d*0.25*cos(k+pi/4);zeros(1,length(k))];
        Zxvert = [d*0.25*sin(k);d*0.25*sin(k+pi/4);zeros(1,length(k))];

        framecolor = 'red';

        patch(df+Xxvert,Yxvert,Zxvert,framecolor);
        patch(Xyvert,df+Yyvert,Zyvert,framecolor);
        patch(Xzvert,Yzvert,df+Zzvert,framecolor);

        line([0 df],[0 0],[0 0],'color',framecolor,'LineWidth',2);
        line([0 0],[0 df],[0 0],'color',framecolor,'LineWidth',2);
        line([0 0],[0 0],[0 df],'color',framecolor,'LineWidth',2);

        text(df+5,5,5,'X0');
        text(5,df+5,5,'Y0');
        text(5,5,df+5,'Z0');

        grid on;
        axis equal;
        hold on;
    
    % Plot robot's bounds
        kctdrawbound(kctworkspace, color2);

    % Plot the robot
        kctdisprobot(-kctrobothome.kcthomeposition(2,:),h_bound);


