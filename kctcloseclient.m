%    KCTCLOSECLIENT - Terminate the MATLAB client for KUKA robot communication
%
%    The function terminates the TCP/IP connection with the KUKA robot server.
%   
%    Usage: kctcloseclient(t)
%
%    Arguments:
%           t = handler for communication with the KUKA robot
%
%    See also: KCTCLIENT
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

function kctcloseclient()
    
    global kctipvar;
    % Load TCP/IP comunication type
    global kcttcpiptype;
    
    if( kcttcpiptype == 'ICT' & ~isempty(kctipvar) )
        fclose(kctipvar);
        clear global kctipvar;
        clear global kctrobotlinks;
        fprintf(' KUKA ICT client succesfully closed. \n')
    elseif( kcttcpiptype == 'MEX' & ~isempty(kctipvar) )
        kctcloseclientmex();
        clear global kctipvar;
        clear global kctrobotlinks;
        fprintf(' KUKA MEX client succesfully closed. \n')
    else
        fprintf(' TCPIP communication not initialized. \n')
    end
   
            
            
