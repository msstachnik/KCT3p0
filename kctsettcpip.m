%    KCTSETTCPIP - Set the network communication protocol
%
%    The function sets the network communication protocol (Instrument 
%    Control Toolbox or Mex files)
%
%    Usage: kctsettcpip('ICT')  % for Instrument Control Toolbox
%           kctsettcpip('MEX')  % for Mex files
%
%    Arguments:
% 	       value = string of the tcpip type
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


function kctsettcpip(value)

    global kctipvar
    if(nargin ~= 1)
       display(' ERROR : kctsettcpip requires one input.'); 
       return;
    end
    
    % Load TCP/IP comunication type
    global kcttcpiptype;
    
    if value == 'ICT'
        [issystemok, foundmatlab, foundtoolbox] = kctchecksystem();
        if foundtoolbox == 0
            display(' Instrument Control Toolbox cannot be used for TCPIP communication.');
            return;
        end
    end
    
    % Closing previous communication if exist
   if isempty(kctipvar)==0
    display(' Closing previous TCPIP communication.');
    kctcloseclient();
   end
    
    % Changing TCPIP communication type
    kcttcpiptype = value;
    save('kcttcpiptype.mat', 'kcttcpiptype');
    
