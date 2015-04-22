%    KCTCHECKARG - Check the argument of KCT functions.  
%
%    The function checks the arguments of the KCT functions and returns the
%    value used by the KCT routines.
%
%    Usage: kctoption = kctcheckarg(varargin)
%
%    Argument:
%             'Plot', Boolean variable (1/0) enabling/disabling the plot
%             'Mode', string to select the type of motion ('poly' or 'prop')
%             'FrameDimension', float variable to set the end-effector frame dimension
%             'FrameStep', float variable to set the end-effector frame step
%             'FrameColor', color of the end-effector frame
%             'TrajColor', color of the robot trajectory
%             'ShowRobot', Boolean variable (1/0) enabling/disabling the plot of the robot
%             'View', viewpoint specification (Az. and El. angles)
%
%    Return:
%             A structure containing the values of the relative options
%

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

function  kctoption = kctcheckarg(varargin)

    % Default variables' value
        plot = 0;
        kctmode = 'prop';
        framedim = 0.5;
        framestep = 10;
        framecolor = 'blu';
        trajcolor = 'red';
        showrobot = 1;
        pov = 3;

        varargin = varargin{1};

    index = find(strcmp(varargin,'Plot')); 
    if(~isempty(index))
       plot = varargin{index+1}; 
    end

    index = find(strcmp(varargin,'Mode'));
    if(~isempty(index))
       kctmode = varargin{index+1}; 
    end

    index = find(strcmp(varargin,'FrameDimension'));
    if(~isempty(index))
       framedim = varargin{index+1}; 
    end

    index = find(strcmp(varargin,'FrameStep')); 
    if(~isempty(index))
       framestep = varargin{index+1}; 
    end

    index =find(strcmp(varargin,'FrameColor')); 
    if(~isempty(index))
       framecolor = varargin{index+1}; 
    end

    index =find(strcmp(varargin,'TrajColor'));
    if(~isempty(index))
       trajcolor = varargin{index+1}; 
    end
    
    index =find(strcmp(varargin,'ShowRobot')); 
    if(~isempty(index))
       showrobot = varargin{index+1}; 
    end

    index =find(strcmp(varargin,'View')); 
    if(~isempty(index))
       pov = varargin{index+1}; 
    end

    kctoption = struct('Plot', plot, 'Mode', kctmode, 'FrameDimension', framedim,...
                       'FrameStep', framestep, 'FrameColor', framecolor, 'TrajColor', trajcolor,...
                       'ShowRobot', showrobot, 'View', pov);