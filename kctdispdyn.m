%    KCTDISPDYN - Return the time history of the joint angles.
%
%    The function displays the time history of the reference and actual 
%    joint angles.
%
%    Usage: kctdispdyn(state,linecolor)
%
%    Arguments:
% 	      state = n x 6 matrix of joint angle vectors (Denavit-Hartenberg)
%     linecolor = color of the lines
% 
%    See also: KCTSETXYZ, KCTSETJOINT
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

function kctdispdyn(state,linecolor)

if nargin<2
    linecolor='b';
end

jt1limit = state(size(state,1),1)*ones(1,size(state,1));
jt2limit = state(size(state,1),2)*ones(1,size(state,1));
jt3limit = state(size(state,1),3)*ones(1,size(state,1));
jt4limit = state(size(state,1),4)*ones(1,size(state,1));
jt5limit = state(size(state,1),5)*ones(1,size(state,1));
jt6limit = state(size(state,1),6)*ones(1,size(state,1));

t=[1:size(state,1)];

figure('name','Joints dynamic');

subplot(321), plot(t,state(:,1),linecolor,t,jt1limit,'k:');ylabel('J1 [deg]');
    xlabel('samples');axis([0,length(t),(min(state(:,1))-10), (max(state(:,1))+10)]);

subplot(322), plot(t,state(:,2),linecolor,t,jt2limit,'k:');ylabel('J2 [deg]');
    xlabel('samples');axis([0,length(t),(min(state(:,2))-10), (max(state(:,2))+10)]);

subplot(323), plot(t,state(:,3),linecolor,t,jt3limit,'k:');ylabel('J3 [deg]');
    xlabel('samples');axis([0,length(t),(min(state(:,3))-10), (max(state(:,3))+10)]);

subplot(324), plot(t,state(:,4),linecolor,t,jt4limit,'k:');ylabel('J4 [deg]');
    xlabel('samples');axis([0,length(t),(min(state(:,4))-10), (max(state(:,4))+10)]);

subplot(325), plot(t,state(:,5),linecolor,t,jt5limit,'k:');ylabel('J5 [deg]');
    xlabel('samples');axis([0,length(t),(min(state(:,5))-10), (max(state(:,5))+10)]);

subplot(326), plot(t,state(:,6),linecolor,t,jt6limit,'k:');ylabel('J6 [deg]');
    xlabel('samples');axis([0,length(t),(min(state(:,6))-10), (max(state(:,6))+10)]);


