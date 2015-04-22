%    KCTSTOP - Stop the robot in the current position
%
%    The function sends a null velocity setpoint to stop the robot. 
%
%    Usage: kctstop()
%
%    See also: KCTMOVEXYZ, KCTMOVEJOINT
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

function kctstop()
    
    global kctipvar;
    t = kctipvar;
    
    global kcttcpiptype;

    global kcttom;
    kcttom;
    if (kcttom == 0) || (kcttom == 1)
        A1 = ['"0.000"'];
        A2 = ['"0.000"'];
        A3 = ['"0.000"'];
        A4 = ['"0.000"'];
        A5 = ['"0.000"'];
        A6 = ['"0.000"'];
        robotspeed=['<AKorr A1=',A1,' A2=',A2,' A3=',A3,' A4=',A4,' A5=',A5,' A6=',A6,' />'];
    else
        X = ['"0.000"'];
        Y = ['"0.000"'];
        Z = ['"0.000"'];
        A = ['"0.000"'];
        B = ['"0.000"'];
        C = ['"0.000"'];
        robotspeed=['<RKorr X=',X,' Y=',Y,' Z=',Z,' A=',A,' B=',B,' C=',C,' />'];
    end

    if kcttcpiptype == 'ICT'
        fwrite(t,robotspeed);
    elseif kcttcpiptype == 'MEX'
        kctsenddatamex(robotspeed);
    end
     


