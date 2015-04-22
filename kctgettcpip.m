%    KCTGETTCPIP - Get the network communication protocol
%
%    The function gets the network communication protocol (Instrument 
%    Control Toolbox or Mex files)
%
%    Usage: kctgettcpip()
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

    % Load TCP/IP comunication type
    global kcttcpiptype;
    
    if kcttcpiptype == 'ICT'
        display(' KUKA communication protocol: Instrument Control Toolbox. ');
    elseif kcttcpiptype == 'MEX'
        display(' KUKA communication protocol: MEX files. ');
    end
