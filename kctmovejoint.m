%    KCTMOVEJOINT - Set the joints velocity to a desired value.  
%
%    The function sets the joints velocity to a desired value. 
%    The reference velocity is sent to the KUKA Robot Controller (KRC): 
%    it uses the low level KUKA control to follow the velocity profile.
%
%    Usage: kctmovejoint(vet)
%
%    Arguments:
%	      vet = vector of joint angles' velocities
%       
%    See also: KCTMOVEXYZ
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

function kctmovejoint(vet)
  
    global kcttom;
    
    global kctipvar;
    t = kctipvar;
    
    global kcttcpiptype;

	max_speed = 9;
    format short;
    if (kcttom == 1) || (kcttom == 0)
        for j=1:6
            if vet(1,j)<-max_speed    % velocity saturation
               vet(1,j)=-max_speed;     
            end
            if vet(1,j)>max_speed
               vet(1,j)=max_speed;     
            end
        end

        if vet(1,1)<0
            A1=['"-0.000"'];
            a1=num2str(roundn(vet(1,1),-2),3);
            A1(1,2:(1+length(a1)))=a1;        
        end
        if vet(1,2)<0
            A2=['"-0.000"'];
            a2=num2str(roundn(vet(1,2),-2),3);
            A2(1,2:(1+length(a2)))=a2;
        end 
        if vet(1,3)<0
            A3=['"-0.000"'];
            a3=num2str(roundn(vet(1,3),-2),3);
            A3(1,2:(1+length(a3)))=a3;
        end
        if vet(1,4)<0
            A4=['"-0.000"'];
            a4=num2str(roundn(vet(1,4),-2),3);
            A4(1,2:(1+length(a4)))=a4;        
        end 
        if vet(1,5)<0
            A5=['"-0.000"'];
            a5=num2str(roundn(vet(1,5),-2),3);
            A5(1,2:(1+length(a5)))=a5;         
          end
          if vet(1,6)<0
            A6=['"-0.000"'];
            a6=num2str(roundn(vet(1,6),-2),3);
            A6(1,2:(1+length(a6)))=a6;        
        end

        if vet(1,1)>=0
            A1=['"0.0000"'];
            a1=num2str(roundn(vet(1,1),-3),3);
            A1(1,2:(1+length(a1)))=a1;
        end
        if vet(1,2)>=0
                A2=['"0.0000"'];
                a2=num2str(roundn(vet(1,2),-3),3);
                A2(1,2:(1+length(a2)))=a2;
        end       
        if vet(1,3)>=0
            A3=['"0.0000"'];
            a3=num2str(roundn(vet(1,3),-3),3);
            A3(1,2:(1+length(a3)))=a3;
        end
        if vet(1,4)>=0  
            A4=['"0.0000"'];
            a4=num2str(roundn(vet(1,4),-3),3);
            A4(1,2:(1+length(a4)))=a4;
        end
        if vet(1,5)>=0  
                A5=['"0.0000"'];
            a5=num2str(roundn(vet(1,5),-3),3);
            A5(1,2:(1+length(a5)))=a5;
        end
        if vet(1,6)>=0 	  
            A6=['"0.0000"'];
            a6=num2str(roundn(vet(1,6),-3),3);
            A6(1,2:(1+length(a6)))=a6;
        end
        robotspeed=['<AKorr A1=',A1,' A2=',A2,' A3=',A3,' A4=',A4,' A5=',A5,' A6=',A6,' />'];
        
        if kcttcpiptype == 'ICT'
            fwrite(t,robotspeed);
        elseif kcttcpiptype == 'MEX'
            kctsenddatamex(robotspeed);
        end
            
        kcttom = 1;
    else
        while true
              disp('Warning: this motion is not allowed: Please type kcthome() and retry');
              disp('Press Ctrl+C to continue.');
              pause()
        end     
    end

 