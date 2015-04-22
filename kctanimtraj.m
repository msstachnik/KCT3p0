%    KCTANIMTRAJ - Create a 3-D animation of the robot
%
%    The function displays the 3-D motion of the robot along a given trajectory 
%
%    Usage: kctanimtraj(state, option)
%
%    Arguments:
% 		  state = n x 6 matrix of joint angle vectors (Denavit-Hartenberg)
%                option = parameter/value pairs to specify additional properties
%                 'Plot', Boolean variable (1/0) enabling/disabling the plot
%                 'Precision', string to select the type of motion ('approx' or 'exact')
%                 'FrameDimension', float variable to set the end-effector frame dimension
%                 'FrameStep', float variable to set the end-effector frame step
%                 'FrameColor', color of the end-effector frame
%                 'TrajColor', color of the robot trajectory
%                 'ShowRobot', Boolean variable (1/0) enabling/disabling the plot of the robot
%                 'View', vector of 'view' coordinates
%
%   See also: KCTDISPROBOT, KCTDISPTRAJ
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

function kctanimtraj(state,speed,varargin)

    % Check function options
    
    kctoption = kctcheckarg(varargin);
    % precision = kctoption.Precision;
    plot = kctoption.Plot;
    df = kctoption.FrameDimension;
    frst = kctoption.FrameStep;
    trajcolor = kctoption.TrajColor;
    framecolor = kctoption.FrameColor;
    pov = kctoption.View;
    
    h_traj = figure();
    set(h_traj,'doublebuffer','on');

    for nState = 1:size(state,1)
        clf;
            for i=1:size(state,1)
                M = kctfkine(state(i,:));
                coorvect = M(1:3,4);
                rotmat = M(1:3,1:3);
                X(i,1) = coorvect(1);
                Y(i,1) = coorvect(2);
                Z(i,1) = coorvect(3);
                endeff(i).MAT = rotmat;
            end
        axis equal;
        
        k = [0:pi/4:2*pi];
        d = 40;
        
        Xzvert = [d*0.25*sin(k);d*0.25*sin(k+pi/4);zeros(1,length(k))];
        Yzvert = [d*0.25*cos(k);d*0.25*cos(k+pi/4);zeros(1,length(k))];
        Zzvert = [zeros(1,length(k));zeros(1,length(k));d/2*ones(1,length(k))];
        Xyvert = [d*0.25*sin(k);d*0.25*sin(k+pi/4);zeros(1,length(k))];
        Yyvert = [zeros(1,length(k));zeros(1,length(k));d/2*ones(1,length(k))];
        Zyvert = [d*0.25*cos(k);d*0.25*cos(k+pi/4);zeros(1,length(k))];
        Xxvert = [zeros(1,length(k));zeros(1,length(k));d/2*ones(1,length(k))];
        Yxvert = [d*0.25*cos(k);d*0.25*cos(k+pi/4);zeros(1,length(k))];
        Zxvert = [d*0.25*sin(k);d*0.25*sin(k+pi/4);zeros(1,length(k))];

        plot3(X,Y,Z,'color',trajcolor,'LineWidth',2);

        patch(d+Xxvert,Yxvert,Zxvert,framecolor);
        patch(Xyvert,d+Yyvert,Zyvert,framecolor);
        patch(Xzvert,Yzvert,d+Zzvert,framecolor);
        line([0 d],[0 0],[0 0],'color',framecolor,'LineWidth',2);
        line([0 0],[0 d],[0 0],'color',framecolor,'LineWidth',2);
        line([0 0],[0 0],[0 d],'color',framecolor,'LineWidth',2);
        text(d+5,5,5,'Xw');
        text(5,d+5,5,'Yw');
        text(5,5,d+5,'Zw');

        grid on;
        axis equal;

        k = 1;
        for i=1:frst:size(state,1)
             rot = endeff(i).MAT;
             drotXx(k,1) = df*rot(1,1);
             drotXy(k,1) = df*rot(2,1);
             drotXz(k,1) = df*rot(3,1);
             drotYx(k,1) = df*rot(1,2);
             drotYy(k,1) = df*rot(2,2);
             drotYz(k,1) = df*rot(3,2);
             drotZx(k,1) = df*rot(1,3);
             drotZy(k,1) = df*rot(2,3);
             drotZz(k,1) = df*rot(3,3);
             Xx(k,1) = X(i,1);
             Yy(k,1) = Y(i,1);
             Zz(k,1) = Z(i,1);
             k=k+1;
        end

        hold on

        quiver3(Xx(:,1),Yy(:,1),Zz(:,1),drotXx(:,1),drotXy(:,1),drotXz(:,1),df,'color',framecolor)
        quiver3(Xx(:,1),Yy(:,1),Zz(:,1),drotYx(:,1),drotYy(:,1),drotYz(:,1),df,'color',framecolor)
        quiver3(Xx(:,1),Yy(:,1),Zz(:,1),drotZx(:,1),drotZy(:,1),drotZz(:,1),df,'color',framecolor)

        for i=1:frst:size(state,1)
            rot = endeff(i).MAT;
            text(X(i,1)+df*100*rot(1,1),Y(i,1)+df*100*rot(2,1),Z(i,1)+df*100*rot(3,1),'x','color',framecolor);
            text(X(i,1)+df*100*rot(1,2),Y(i,1)+df*100*rot(2,2),Z(i,1)+df*100*rot(3,2),'y','color',framecolor);
            text(X(i,1)+df*100*rot(1,3),Y(i,1)+df*100*rot(2,3),Z(i,1)+df*100*rot(3,3),'z','color',framecolor); 
        end
        view(pov);
        
        kctdisprobot(state(nState,:),h_traj); 
       
        pause(1/speed)
    end
    display('kctanimtraj finished...');


