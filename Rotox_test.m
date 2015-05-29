clc;
clear all;
close all;

% syms alpha beta gamma
% A= [cos(alpha) -sin(alpha) 0
%     sin(alpha) cos(alpha) 0
%     0 0 1];
% B= [cos(beta) 0 sin(beta) 
%     0 1 0
%     sin(beta) 0 cos(beta)];
% C= [1 0 0
%     0 cos(gamma) -sin(gamma)
%     0 sin(gamma) cos(gamma)];
% Rot_Matrix = A*B*C;
load ROTOR
R = rMtx(1:3,1:3)
%% Roll-Pitch-Yaw Angles
A = radtodeg(atan2(R(2,3),R(3,3)))
B = radtodeg(atan2(R(2,1),R(1,1)))
C = radtodeg(atan2(-R(3,1),cos(B)*R(1,1) + sin(B)*R(2,1)))

%% Euler Angles
A = radtodeg(atan2(R(1,3),R(2,3)))
B = radtodeg(atan2(-R(2,3) * cos(A) + R(1,3) * sin(A),R(3,3)))
C = radtodeg(atan2(R(3,1), R(3,2)))