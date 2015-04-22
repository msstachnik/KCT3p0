%    KCTMOVEXYZ - Set the linear and angular velocities of the end-effector
%
%    The function sets the linear and angular velocities of the end-effector.
%    The reference velocity is sent to the KUKA Robot Controller (KRC): 
%    it uses the low level KUKA control to follow the velocity profile. 
%
%    Usage: kctmovexyz(vet)
%
%    Arguments:
%         vet = vector of linear (vet(1:3)) and angular velocities (vet(4:6)) 
%               of the end-effector 
%
%    See also: KCTMOVEJOINT
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

function kctmovexyz(vet)
 
global kcttom;
global kctipvar;
global kctrotfr
global kctptfr

t = kctipvar;

global kcttcpiptype;
global kctready2send;

vet(1:3)=((kctrotfr)*vet(1:3)')';

	if (kcttom == 2) || (kcttom == 0);
	
        format short;

        max_speed = 9;

        for j=1:6
            if vet(1,j)<-max_speed
                vet(1,j)=-max_speed;     
                end
                if vet(1,j)>max_speed
                    vet(1,j)=max_speed;     
                end
        end

        if vet(1,1)<0
            X=['"-0.000"'];
            x=num2str(roundn(vet(1,1),-2),3);
            X(1,2:(1+length(x)))=x; 
        end
        if vet(1,2)<0
                Y=['"-0.000"'];
                y=num2str(roundn(vet(1,2),-2),3);
                Y(1,2:(1+length(y)))=y;
        end       
        if vet(1,3)<0
            Z=['"-0.000"'];
                z=num2str(roundn(vet(1,3),-2),3);
            Z(1,2:(1+length(z)))=z;
        end
        if vet(1,4)<0
                A=['"-0.000"'];
            a=num2str(roundn(vet(1,4),-2),3);
            A(1,2:(1+length(a)))=a;
        end
        if vet(1,5)<0
            B=['"-0.000"'];
            b=num2str(roundn(vet(1,5),-2),3);
            B(1,2:(1+length(b)))=b;
        end
        if vet(1,6)<0
            C=['"-0.000"'];
            c=num2str(roundn(vet(1,6),-2),3);
            C(1,2:(1+length(c)))=c;
        end

        if vet(1,1)>=0
            X=['"0.0000"'];
            x=num2str(roundn(vet(1,1),-3),3);
            X(1,2:(1+length(x)))=x;
        end
        if vet(1,2)>=0
            Y=['"0.0000"'];
            y=num2str(roundn(vet(1,2),-3),3);
            Y(1,2:(1+length(y)))=y;
        end       
        if vet(1,3)>=0
            Z=['"0.0000"'];
            z=num2str(roundn(vet(1,3),-3),3);
            Z(1,2:(1+length(z)))=z;
        end
        if vet(1,4)>=0
            A=['"0.0000"'];
            a=num2str(roundn(vet(1,4),-3),3);
            A(1,2:(1+length(a)))=a;
        end
        if vet(1,5)>=0
            B=['"0.0000"'];
            b=num2str(roundn(vet(1,5),-3),3);
            B(1,2:(1+length(b)))=b;
        end
        if vet(1,6)>=0
            C=['"0.0000"'];
            c=num2str(roundn(vet(1,6),-3),3);
            C(1,2:(1+length(c)))=c;
        end
        robotspeed=['<RKorr X=',X,' Y=',Y,' Z=',Z,' A=',A,' B=',B,' C=',C,' />'];

        if kcttcpiptype == 'ICT'
            fwrite(t,robotspeed);
            flushoutput(t);
        elseif kcttcpiptype == 'MEX'
            kctsenddatamex(robotspeed);
        end

        kcttom = 2;
    
    else 
        
        while true
            disp('Warning: this motion is not allowed: Please type kcthome(t) and retry');
            disp('Press Ctrl+C to continue.');
            pause()
        end
        
    end
	
      
 	
  	   
   
               
        
       
