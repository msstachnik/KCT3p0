%    KCTDISPROBOT - Display the robot manipulator in a desired position.
%
%    The function displays a 3-D model of the robot in the user's defined
%    position. The base reference frame <x0,y0,z0> and the
%    end-effector reference frame <x6,y6,z6> are shown.
%
%    Usage: kctdisprobot(angleDH,h_fig)
%
%    Arguments:
%              angleDH = vector of the desired joint angles (Denavit-Hartemberg)             
%              h_fig   =  number of figure's handler. 
%                        If not specified, a default value is set. 
%             
%    Return:
%              h_fig   = number of figure handler.
%
%    See also: KCTDISPTRAJ, KCTANIMTRAJ
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

function ROBOT = kctdisprobot_V4(ROBOT)
% 
%     if nargin>1
%         figure(h_fig);
%     else
%         h_fig = figure();
%     end

    angleDH = [ROBOT.Joint.Value];
    angleDH = - angleDH; %odwrotna polaryzacja
    kctrobotlinks = ROBOT.Links;
    display = ROBOT.display; % pobieranie informacji czy pozycja mam byæ wyœwietlana czy tylko zaktualizowane po³ozenia jointów
    
    if display
        cla
    end
    
    kctptfr = zeros(1,3);
    kctrotfr = diag(ones(1,3));
    JointScale = 1.2;       % use to define scale of joint objects
    JointPrecision = 5;     % use to define numbers of joint objects elements
    
    kctworkspace = ROBOT.Workspace;

    if display
        xlabel('X')
        ylabel('Y')
        zlabel('Z')

            set(gca, 'drawmode', 'fast');
            grid on
            % Robot Workspace
                axis equal
                axis([(kctworkspace(1,1)-50) (kctworkspace(1,2)+50)...
                      (kctworkspace(1,3)-50) (kctworkspace(1,4)+50)...
                       kctworkspace(1,5) (kctworkspace(1,6)+50)])
                hold on
    %         zlim = get(gca, 'ZLim');


            % Link1
            line('xdata', [0;0], ...
                 'ydata', [0;0], ...
                 'zdata', [0;kctrobotlinks(1)], ...
                 'LineWidth', 4, ...
                 'color', 'black');
            % Joint1    
            [xc,yc,zc] = sphere(JointPrecision); %  Last Update 2015-04-27 22:49 
            xc = xc * JointScale;
            yc = yc * JointScale;
            zc = zc * JointScale;
    %         zc(zc==0) = -1/2;
    %         zc(zc==1) = 1/2;
            cc = ones(size(xc));
            sLink = [10, 0, 0; 0, 10, 0; 0, 0, 30];
                for k = 1:size(xc,1)
                    for l = 1:size(xc,2)
                        v =  sLink * [xc(k,l); yc(k,l); zc(k,l)];
                        xc(k,l) = v(1);
                        yc(k,l) = v(2);
                        zc(k,l) = v(3)+kctrobotlinks(1);
                    end
                 end;
                 surf(xc,yc,zc, cc, 'EdgeColor', 'black', 'FaceColor', 'blue', ...
                         'FaceLighting', 'phong');
    end
            % Link2
            rMtx = kctrotoz(angleDH(1));
            vLink2 = rMtx*[kctrobotlinks(2);0;0;1];
            
    if display
            line('xdata', [0;vLink2(1)], ...
                 'ydata', [0;vLink2(2)], ...
                 'zdata', [kctrobotlinks(1);kctrobotlinks(1)], ...
                 'LineWidth', 4, ...
                 'color', [0.9 0.5 0.2]);
            % Joint2    
            [xc,yc,zc] = sphere(JointPrecision); %  Last Update 2015-04-27 22:49 
            xc = xc * JointScale;
            yc = yc * JointScale;
            zc = zc * JointScale;
    %         zc(zc==0) = -1/2;
    %         zc(zc==1) = 1/2;
            cc = ones(size(xc));
            sLink = [10, 0, 0; 0, 10, 0; 0, 0, 30];
            rMtx = kctrotoz(angleDH(1))*kctrotox(90);
                for k = 1:size(xc,1)
                    for l = 1:size(xc,2)
                        v =  rMtx([1:3],[1:3])*sLink * [xc(k,l); yc(k,l); zc(k,l)];
                        xc(k,l) = v(1)+vLink2(1);
                        yc(k,l) = v(2)+vLink2(2);
                        zc(k,l) = v(3)+kctrobotlinks(1);
                    end
                 end;
                 surf(xc,yc,zc, cc, 'EdgeColor', 'black', 'FaceColor', 'blue', ...
                         'FaceLighting', 'phong');
    end
            % Link3
            rMtx = kctrotoz(angleDH(1))*kctrotoy(-angleDH(2));
            vLink3 = rMtx*[kctrobotlinks(3);0;0;1];
            
    if display
            line('xdata', [vLink2(1);vLink2(1)+vLink3(1)], ...
                 'ydata', [vLink2(2);vLink2(2)+vLink3(2)], ...
                 'zdata', [kctrobotlinks(1);kctrobotlinks(1)+vLink3(3)], ...
                 'LineWidth', 4, ...
                 'color',  [0.9 0.5 0.2]);
            % Joint3    
            [xc,yc,zc] = sphere(JointPrecision); %  Last Update 2015-04-27 22:49 
            xc = xc * JointScale;
            yc = yc * JointScale;
            zc = zc * JointScale;
    %         zc(zc==0) = -1/2;
    %         zc(zc==1) = 1/2;
            cc = ones(size(xc));
            sLink = [10, 0, 0; 0, 10, 0; 0, 0, 30];
            rMtx = kctrotoz(angleDH(1))*kctrotox(90);
                for k = 1:size(xc,1)
                    for l = 1:size(xc,2)
                        v =  rMtx([1:3],[1:3])*sLink * [xc(k,l); yc(k,l); zc(k,l)];
                        xc(k,l) = v(1)+vLink2(1)+vLink3(1);
                        yc(k,l) = v(2)+vLink2(2)+vLink3(2);
                        zc(k,l) = v(3)+kctrobotlinks(1)+vLink3(3);
                    end
                 end;
                 surf(xc,yc,zc, cc, 'EdgeColor', 'black', 'FaceColor', 'blue', ...
                         'FaceLighting', 'phong');
    end
            % Link4
            rMtx = kctrotoz(angleDH(1))*kctrotoy((-angleDH(3)-angleDH(2)))*kctrotoy(-90);
            vLink4 = rMtx*[kctrobotlinks(4);0;0;1];
    if display        
            line('xdata', [vLink2(1)+vLink3(1);vLink2(1)+vLink3(1)+vLink4(1)], ...
                 'ydata', [vLink2(2)+vLink3(2);vLink2(2)+vLink3(2)+vLink4(2)], ...
                 'zdata', [kctrobotlinks(1)+vLink3(3);kctrobotlinks(1)+vLink3(3)+vLink4(3)], ...
                 'LineWidth', 4, ...
                 'color',  [0.9 0.5 0.2]);              
    end
            % Link5
            rMtx = kctrotoz(angleDH(1))*kctrotoy((-angleDH(3)-angleDH(2)));
            vLink5 = rMtx*[kctrobotlinks(5);0;0;1];
    if display        
            line('xdata', [vLink2(1)+vLink3(1)+vLink4(1);vLink2(1)+vLink3(1)+vLink4(1)+vLink5(1)], ...
                 'ydata', [vLink2(2)+vLink3(2)+vLink4(2);vLink2(2)+vLink3(2)+vLink4(2)+vLink5(2)], ...
                 'zdata', [kctrobotlinks(1)+vLink3(3)+vLink4(3);kctrobotlinks(1)+vLink3(3)+vLink4(3)+vLink5(3)], ...
                 'LineWidth', 4, ...
                 'color', [0.9 0.5 0.2]);  

            % Joint4    
            [xc,yc,zc] = sphere(JointPrecision); %  Last Update 2015-04-27 22:49 
            xc = xc * JointScale;
            yc = yc * JointScale;
            zc = zc * JointScale;
    %         zc(zc==0) = -1/2;
    %         zc(zc==1) = 1/2;
            cc = ones(size(xc));
            sLink = [10, 0, 0; 0, 10, 0; 0, 0, 30];
            rMtx = kctrotoz(angleDH(1))*kctrotoy((-angleDH(3)-angleDH(2)))*kctrotoy(90);
                for k = 1:size(xc,1)
                    for l = 1:size(xc,2)
                        v =  rMtx([1:3],[1:3])*sLink * [xc(k,l); yc(k,l); zc(k,l)];
                        xc(k,l) = v(1)+vLink2(1)+vLink3(1)+vLink4(1)+vLink5(1);
                        yc(k,l) = v(2)+vLink2(2)+vLink3(2)+vLink4(2)+vLink5(2);
                        zc(k,l) = v(3)+kctrobotlinks(1)+vLink3(3)+vLink4(3)+vLink5(3);
                    end
                 end;
                 surf(xc,yc,zc, cc, 'EdgeColor', 'black', 'FaceColor', 'blue', ...
                         'FaceLighting', 'phong');     
            % Joint5    
            [xc,yc,zc] = sphere(JointPrecision); %  Last Update 2015-04-27 22:49 
            xc = xc * JointScale;
            yc = yc * JointScale;
            zc = zc * JointScale;
    %         zc(zc==0) = -1/2;
    %         zc(zc==1) = 1/2;
            cc = ones(size(xc));
            sLink = [10, 0, 0; 0, 10, 0; 0, 0, 30];
            %rMtx = kctrotox(angleDH(4)*pi/180)*kctrotoz(angleDH(1)*pi/180)*kctrotoy((-angleDH(3)-angleDH(2))*pi/180)*kctrotoy(pi/2)*kctrotox(pi/2);
            rMtx = kctrotoz(angleDH(1))*kctrotoy((-angleDH(3)-angleDH(2)))*kctrotoy(90)*kctrotox(90)*kctrotoy(angleDH(4));
            for k = 1:size(xc,1)
                    for l = 1:size(xc,2)
                        v =  rMtx([1:3],[1:3])*sLink * [xc(k,l); yc(k,l); zc(k,l)];
                        xc(k,l) = v(1)+vLink2(1)+vLink3(1)+vLink4(1)+vLink5(1);
                        yc(k,l) = v(2)+vLink2(2)+vLink3(2)+vLink4(2)+vLink5(2);
                        zc(k,l) = v(3)+kctrobotlinks(1)+vLink3(3)+vLink4(3)+vLink5(3);
                    end
                 end;
                 surf(xc,yc,zc, cc, 'EdgeColor', 'black', 'FaceColor', 'blue', ...
                         'FaceLighting', 'phong');
    end
            % Link6
            rMtx = kctrotoz(angleDH(1))*kctrotoy((-angleDH(3)-angleDH(2)))*kctrotox(angleDH(4))*kctrotoy(-angleDH(5));%kctrotox(pi/2);
            vLink6 = rMtx*[kctrobotlinks(6);0;0;1];
    if display
            line('xdata', [vLink2(1)+vLink3(1)+vLink4(1)+vLink5(1);vLink2(1)+vLink3(1)+vLink4(1)+vLink5(1)+vLink6(1)], ...
                 'ydata', [vLink2(2)+vLink3(2)+vLink4(2)+vLink5(2);vLink2(2)+vLink3(2)+vLink4(2)+vLink5(2)+vLink6(2)], ...
                 'zdata', [kctrobotlinks(1)+vLink3(3)+vLink4(3)+vLink5(3);kctrobotlinks(1)+vLink3(3)+vLink4(3)+vLink5(3)+vLink6(3)], ...
                 'LineWidth', 4, ...
                 'color',  [0.9 0.5 0.2]);   
            % Joint6    
            [xc,yc,zc] = sphere(JointPrecision); %  Last Update 2015-04-27 22:49 
            xc = xc * JointScale;
            yc = yc * JointScale;
            zc = zc * JointScale;
    %         zc(zc==0) = -1/2;
    %         zc(zc==1) = 1/2;
            cc = ones(size(xc));
            sLink = [10, 0, 0; 0, 10, 0; 0, 0, 30];
            rMtx = kctrotoy(90)*kctrotox(-angleDH(1))*kctrotoy((-angleDH(3)-angleDH(2)))*kctrotoz(angleDH(4))*kctrotoy(-angleDH(5));
            
            for k = 1:size(xc,1)
                    for l = 1:size(xc,2)
                        v =  rMtx([1:3],[1:3])*sLink * [xc(k,l); yc(k,l); zc(k,l)];
                        xc(k,l) = v(1)+vLink2(1)+vLink3(1)+vLink4(1)+vLink5(1)+vLink6(1);
                        yc(k,l) = v(2)+vLink2(2)+vLink3(2)+vLink4(2)+vLink5(2)+vLink6(2);
                        zc(k,l) = v(3)+kctrobotlinks(1)+vLink3(3)+vLink4(3)+vLink5(3)+vLink6(3);
                    end
                 end;
                 surf(xc,yc,zc, cc, 'EdgeColor', 'black', 'FaceColor', 'blue', ...
                         'FaceLighting', 'phong');    
    end
            % Reference frame of the end-effector
            quivX = vLink2(1)+vLink3(1)+vLink4(1)+vLink5(1)+vLink6(1);
            quivY = vLink2(2)+vLink3(2)+vLink4(2)+vLink5(2)+vLink6(2);
            quivZ = kctrobotlinks(1)+vLink3(3)+vLink4(3)+vLink5(3)+vLink6(3);
            rMtxA = kctrotoz(angleDH(1)+90)*kctrotoy((-angleDH(3)-angleDH(2)))*kctrotox(angleDH(4))*kctrotoy(-angleDH(5))*kctrotox(angleDH(6)-90);
            rMtxB = kctrotoz(angleDH(1)+90)*kctrotoy((-angleDH(3)-angleDH(2)))*kctrotox(angleDH(4))*kctrotoy(-angleDH(5))*kctrotox(angleDH(6)+90);
%             rMtx = -kctrotoz(angleDH(1))*kctrotoy((angleDH(3)+angleDH(2)))*kctrotox(angleDH(4))*kctrotoy(angleDH(5))*kctrotox(angleDH(6));
            rMtx = kctrotoz(angleDH(1))*kctrotoy((-angleDH(3)-angleDH(2)))*kctrotox(angleDH(4))*kctrotoy(-angleDH(5))*kctrotox(-90+angleDH(6));

    if display
            quiver3(quivX,quivY,quivZ,rMtx(1,1),rMtx(2,1),rMtx(3,1),150,'color','b');
            quiver3(quivX,quivY,quivZ,rMtx(1,2),rMtx(2,2),rMtx(3,2),150,'color','r');
            quiver3(quivX,quivY,quivZ,rMtx(1,3),rMtx(2,3),rMtx(3,3),150,'color','g');
            text(quivX+150*rMtx(1,1),quivY+150*rMtx(2,1),quivZ+150*rMtx(3,1),'z');
            text(quivX+150*rMtx(1,2),quivY+150*rMtx(2,2),quivZ+150*rMtx(3,2),'x');
            text(quivX+150*rMtx(1,3),quivY+150*rMtx(2,3),quivZ+150*rMtx(3,3),'y');
            plot3(quivX,quivY,quivZ,'m.')

    %         New frame
            quiver3(kctptfr(1,1),kctptfr(1,2),kctptfr(1,3),kctrotfr(1,1),kctrotfr(2,1),kctrotfr(3,1),150,'color','r');
            quiver3(kctptfr(1,1),kctptfr(1,2),kctptfr(1,3),kctrotfr(1,2),kctrotfr(2,2),kctrotfr(3,2),150,'color','g');
            quiver3(kctptfr(1,1),kctptfr(1,2),kctptfr(1,3),kctrotfr(1,3),kctrotfr(2,3),kctrotfr(3,3),150,'color','b');
            text(kctptfr(1,1)+150*kctrotfr(1,1),kctptfr(1,2)+150*kctrotfr(2,1),kctptfr(1,3)+150*kctrotfr(3,1),'X0');
            text(kctptfr(1,1)+150*kctrotfr(1,2),kctptfr(1,2)+150*kctrotfr(2,2),kctptfr(1,3)+150*kctrotfr(3,2),'Y0');
            text(kctptfr(1,1)+150*kctrotfr(1,3),kctptfr(1,2)+150*kctrotfr(2,3),kctptfr(1,3)+150*kctrotfr(3,3),'Z0');
            plot3(kctptfr(1,1),kctptfr(1,2),kctptfr(1,3),'m.')

            % Camera position
            if nargin > 2
                campos(kctcamdata.CamPosition);
                camtarget(kctcamdata.CamTarget);
                camup(kctcamdata.CamUp);
                camva(kctcamdata.CamVa);
                camproj(kctcamdata.CamProj);
            end
    end
            drawnow
        
        
        ROBOT.End.X=quivX;
        ROBOT.End.Y=quivY;
        ROBOT.End.Z=quivZ;
        ROBOT.End.A1 = radtodeg(atan2(rMtxA(1,3),-rMtxA(2,3)));
        ROBOT.End.B1 = radtodeg(atan2(rMtxB(3,1), rMtxB(3,2)));
        B =atan2(rMtx(2,1),rMtx(1,1));
        ROBOT.End.C1 = radtodeg(atan2(-rMtx(3,1),cos(B)*rMtx(1,1) + sin(B)*rMtx(2,1)));
%         ROBOT = rotox_to_angles(rMtx, ROBOT); wersja do testow
        
        

function H=kctrotox(alpha)
%    KCTROTOX - Return the homogeneous matrix for rotation about X-axis
%
%    The function computes the homogeneous rotation matrix for rotation about X-axis;
%    The rotation angle is in radians. 
alpha = alpha*pi/180;

    H = [1,       0,               0,       0; 
         0,  cos(alpha), -sin(alpha),       0;
         0,  sin(alpha),  cos(alpha),       0;
         0,       0,               0,       1];    
     

function H = kctrotoy(alpha)
%    KCTROTOY - Return the homogeneous matrix for rotation about Y-axis
%
%    The function computes the homogeneous rotation matrix for rotation about Y-axis;
%    The rotation angle is in radians. 
alpha = alpha*pi/180;

    H = [cos(alpha), 0,  sin(alpha),  0;
                 0, 1,           0,  0;
       -sin(alpha), 0,   cos(alpha),  0;
                 0, 0,           0,  1];
             

function H = kctrotoz(alpha)
%    KCTROTOZ - Return the homogeneous matrix for rotation about Z-axis
%
%    The function computes the homogeneous rotation matrix for rotation about Z-axis;
%    The rotation angle is in radians. 
alpha = alpha*pi/180;

    H = [cos(alpha), -sin(alpha),  0, 0;
         sin(alpha),  cos(alpha),  0, 0;
                  0,           0,  1, 0;
                  0,           0,  0, 1];

function yROBOT = rotox_to_angles(mRotox, xROBOT)
% funkcja licz¹ca k¹ty orientacji w zale¿noœci od wartoœci w macierzy
% rotacji funkcja zwraca strukture z ROBOT zaci¹gajac ta sam¹ strukture.
% Zaciagane s¹ dwie wersje w zale¿noœci od potrzeby, k¹tów eulera i k¹tów
% normalnych
% http://en.wikibooks.org/wiki/Robotics_Kinematics_and_Dynamics/Description_of_Position_and_Orientation
yROBOT = xROBOT;
A = radtodeg(atan2(mRotox(3,2),mRotox(3,3)));
B = radtodeg(atan2(mRotox(2,1),mRotox(1,1)));
C = radtodeg(atan2(-mRotox(3,1),cos(B)*mRotox(1,1) + sin(B)*mRotox(2,1)));
% yROBOT.End.A1 = A;
% yROBOT.End.B1 = B;
yROBOT.End.C1 = C;
%% Euler Angles
A = radtodeg(atan2(mRotox(1,3),-mRotox(2,3)));
B = radtodeg(atan2(-mRotox(2,3) * cos(A) + mRotox(1,3) * sin(A),mRotox(3,3)));
C = radtodeg(atan2(mRotox(3,1), mRotox(3,2)));   
yROBOT.End.A2 = A;
yROBOT.End.B2 = B;
yROBOT.End.C2 = C;

                  
                  
                  
        
