%    KCTDRAWBOUND - Display robot bounds
%
%    The function displays the robot bounds.  
%
%    Usage: KCTDRAWBOUND(kctworkspace, kctcolor, h_fig)
%
%    Arguments:
%           kctworkspace = matrix containing the robot bounds.
%           kctcolor = color of the bound box (optional)
%           h_fig = handle to the figure (optional)

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

function kctdrawbound(kctworkspace, kctcolor, h_fig)

    if nargin < 2, kctcolor = [0.0,0.0,0.8]; end
    if nargin == 3, figure(h_fig); end

    % Transparent Box
        P = [kctworkspace(1,1), kctworkspace(1,3), kctworkspace(1,5);
             kctworkspace(1,2), kctworkspace(1,3), kctworkspace(1,5);
             kctworkspace(1,1), kctworkspace(1,4), kctworkspace(1,5);
             kctworkspace(1,2), kctworkspace(1,4), kctworkspace(1,5);
             kctworkspace(1,1), kctworkspace(1,3), kctworkspace(1,6);
             kctworkspace(1,2), kctworkspace(1,3), kctworkspace(1,6);
             kctworkspace(1,1), kctworkspace(1,4), kctworkspace(1,6);
             kctworkspace(1,2), kctworkspace(1,4), kctworkspace(1,6);
             ];
    %Components of the 1st patch
        X1=[P(1,1) ; P(2,1) ; P(4,1) ; P(3,1)];
        Y1=[P(1,2) ; P(2,2) ; P(4,2) ; P(3,2)];
        Z1=[P(1,3) ; P(2,3) ; P(4,3) ; P(3,3)];
    %Components of the 2nd patch
        X2=[P(2,1) ; P(6,1) ; P(8,1) ; P(4,1)];
        Y2=[P(2,2) ; P(6,2) ; P(8,2) ; P(4,2)];
        Z2=[P(2,3) ; P(6,3) ; P(8,3) ; P(4,3)];
    %Components of the 3nd patch
        X3=[P(6,1) ; P(5,1) ; P(7,1) ; P(8,1)];
        Y3=[P(6,2) ; P(5,2) ; P(7,2) ; P(8,2)];
        Z3=[P(6,3) ; P(5,3) ; P(7,3) ; P(8,3)];
    %Components of the 4nd patch
        X4=[P(5,1) ; P(1,1) ; P(3,1) ; P(7,1)];
        Y4=[P(5,2) ; P(1,2) ; P(3,2) ; P(7,2)];
        Z4=[P(5,3) ; P(1,3) ; P(3,3) ; P(7,3)];
    %Components of the 5nd patch
        X5=[P(2,1) ; P(1,1) ; P(5,1) ; P(6,1)];
        Y5=[P(2,2) ; P(1,2) ; P(5,2) ; P(6,2)];
        Z5=[P(2,3) ; P(1,3) ; P(5,3) ; P(6,3)];
    %Components of the 6nd patch
        X6=[P(3,1) ; P(4,1) ; P(8,1) ; P(7,1)];
        Y6=[P(3,2) ; P(4,2) ; P(8,2) ; P(7,2)];
        Z6=[P(3,3) ; P(4,3) ; P(8,3) ; P(7,3)];
    % Plotting Box
        opaqueness=.2;
        fill3(X1,Y1,Z1,kctcolor,'FaceAlpha',opaqueness);
        fill3(X2,Y2,Z2,kctcolor,'FaceAlpha',opaqueness);
        fill3(X3,Y3,Z3,kctcolor,'FaceAlpha',opaqueness);
        fill3(X4,Y4,Z4,kctcolor,'FaceAlpha',opaqueness);
        fill3(X5,Y5,Z5,kctcolor,'FaceAlpha',opaqueness);
        fill3(X6,Y6,Z6,kctcolor,'FaceAlpha',opaqueness);
        