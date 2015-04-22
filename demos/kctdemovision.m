%    KCTDEMOVISION - Demonstration of KUKA Control Toolbox in a visual servo 
%                    application
%
%    Usage: kctdemovision()
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

    fprintf(' KUKA Control Toolbox Demo for Visual Servo application. \n');
    fprintf(' Required: \n');
    fprintf(' - Image Acquisition Toolbox. \n');
    fprintf(' - Epipolar Geometry Toolbox\n');
    fprintf('   Download (<a href="http://egt.dii.unisi.it/">http://egt.dii.unisi.it/</a>). \n');
    fprintf(' - cvlib_mex (MATLAB wrapper for OpenCV) \n');
    fprintf('   Download (<a href="http://code.google.com/p/j-ml-contrib/source/browse/">http://code.google.com/p/j-ml-contrib/source/browse/</a>). \n');
    
% Initialize the connection if not already initialized    
    kctsel = input(' If you want to connect the robot press 1, any key if it is already connect:');
    if kctsel == 1
        kctmodel = input(' Insert a string with your KUKA robot model:');
        kctinit(kctmodel)
        addr = input(' Insert a string with your KUKA controller''s IP address:');
        t = kctclient(addr,0.15);
    end

% Visual Servoing Options
    % Number of desired features
        nDesiredFeature = 13;
    % Number of actual features
        nActualFeature = 13;
    % Upperbound of distances
        zObject = 4;
    % Number of iterations
        nITERATION = 200;
    % Camera Calibration Parameters (Logitech quickcam)
        f1 = 739.65793;
        f2 = 737.55343;
        u0 = 356.23868;
        v0 = 272.53760;
        K = [f1,  0, u0;
              0, f2, v0;
              0,  0,  1];
    
% Initialize camera (Image Acquisition Toolbox)              
    % Open Camera to capture frame
        imaqhwinfo
    % Access and configure a device.
        vid = videoinput('winvideo', 1, 'I420_640x480');    
        
% Before running, we set the robot reference frame with respect to the
% camera actual position
    % Camera actual position
        pos_actual = [514.4503  -50.9012  575.8281  -89.9763  -10.0682  -89.9982];
    % Change of frame
        kctchframe(kcttran(pos_actual([1:3]))*kctrotoz(pos_actual(4))*kctrotoy(pos_actual(5))*kctrotox(pos_actual(6)));%*kctrotoz(-90)*kctrotox(-90));
    
% Select desired image
    disp(' Moving to desired configuration.');
    kctsetjoint(-[-64.4713  -45.6328   47.4311  -89.1519  -64.4854  178.0554],20);
    % The frame was changed, desired position in function of actual
    % position
        Hda = kctfkine(-[-64.4713  -45.6328   47.4311  -89.1519  -64.4854  178.0554]);
        tda = Hda([1:3],4);
    % Select desired features
        hf_desired = figure('Name', 'Desired Image');
        img_desired = getsnapshot(vid);
        hold on,
        feature_desired = kctgetpoint(img_desired, nDesiredFeature, hf_desired);
    
% Select actual image
    disp(' Moving to actual configuration.');
    kctsetjoint(-[6.6111  -73.8035   79.8961   47.6147   -9.0000   52.8069],20);
    % Select actual features
        hf_actual = figure('Name', 'Actual Image');
        img_actual = getsnapshot(vid); 
        hold on,
        feature_actual = kctgetpoint(img_actual, nActualFeature, hf_actual);
    
% Epipolar grometry estimation (Epipolar Geometry Toolbox)
    % Fundamental matrix
    F = f_Festim(feature_actual, feature_desired, 4);
    [la,ld] = f_epipline(feature_actual, feature_desired, F, 0, hf_actual, hf_desired,'b');

% Initial camera translation and orientation
    ta(1) = 0;
    ta(2) = 0;
    ta(3) = 0;
    omega_x = 0;
    omega_y = 0;
    omega_z = 0;

% Start the computation
    input(' Press a key to start...');
% Properties for image capture
    triggerconfig(vid, 'Manual');
    set(vid,'TriggerRepeat', Inf);
    set(vid,'FramesPerTrigger',1);
    set(vid,'TriggerFrameDelay',0);
% Initialize image acquisition
    start(vid)
% Create a figure window.
    hf_motion = figure('Name', 'Feature tracking'); 
% Start acquiring frames.
    cor_in = feature_actual';    
    beta = 0;
    framePrevious = getsnapshot(vid);
    
    for iITERATION = 1:nITERATION,
        iITERATION
        
        % Acquire Frame
            trigger(vid);
            frameCurrent = getdata(vid); 
        
        % Track actual features (cvlib_mex)
            cor_out = cvlib_mex('opticalFlowPyrLK', framePrevious, frameCurrent, cor_in, 10);
            framePrevious = frameCurrent;
            cor_in = cor_out;
            
        % Visual Servoing Algorithm    
            for i=1:nActualFeature,  
                x(i) = cor_in(i, 1);
                y(i) = cor_in(i, 2);
                Z(i) = zObject(i);
                f = f1;
                Lof(:,:,i)=[ -f/Z(i)     0       x(i)/(f*Z(i))     x(i)*y(i)/f^2       -(1+x(i)^2/f^2)      y(i);
                   0      -f/Z(i)    y(i)/(f*Z(i))      1+y(i)^2/f^2      -(x(i)*y(i))/f^2      -x(i)];   
                LofrotT(:,:,i) = [ x(i)*y(i)/f^2       -(1+x(i)^2/f^2)      y(i);
                                  1+y(i)^2/f^2      -(x(i)*y(i))/f^2      -x(i)];                               
                % Points-Epip.lines distance  
                lin_epip = F*[cor_in(i,:)' ; 1];
                a(i) = lin_epip(1);
                b(i) = lin_epip(2);    
                LrotT(i,:) = [a(i) b(i)]*LofrotT(:,:,i);
                Lep(:,:,i) = [a(i) b(i)]*Lof(:,:,i);
                e(i) = [cor_in(i,:), 1]*lin_epip;
            end;

            for i = 1:nActualFeature,
                Lep_tot(i,:) = Lep(:,:,i);
            end;
            
        % --> Hybrid Control Law <--   
            Wp = [zeros(3,3); eye(3)];
            e1 = pinv(LrotT)*e'
            if norm(e1)<0.5,
               beta = 0.1;
            end;
                        
            grad_h = [2*(ta(1)-tda(1)) 2*(ta(2)-tda(2)) 2*(ta(3)-tda(3)) 0 0 0]'
            P_K = (eye(6)-Wp*pinv(Wp));
            
            e_h = Wp*e1 + beta*P_K*grad_h; %Control law
            lambda = 0.1; %gain factor

            U = -lambda*e_h %control Input to the robot  
            
            ta(1) = ta(1) + U(1);
            ta(2) = ta(2) + U(2);
            ta(3) = ta(3) + U(3);
            
            omega_x = omega_x + U(4);
            omega_y = omega_y + U(5);
            omega_z = omega_z + U(6);
            
            kctsetxyz([ta, omega_z, omega_y, omega_x],10);
            
        % Update Fundamental matrix
            F = f_Festim(cor_in', feature_desired, 4);
    end
    
% Clear all and close
    stop(vid)
    delete(vid)
    clear vid
    
% Demo finished
    disp(' Demo finished.');
    