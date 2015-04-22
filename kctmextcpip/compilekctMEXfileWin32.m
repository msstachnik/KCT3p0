%    COMPILEKCTMEXFILEWIN32 - compiles the MEX-files Win32 (32bit)
%
%    The script compiles the MEX-files
%
%    Usage: compilekctMEXfileWin32()
%  

%    Copyright (c) 2009 Francesco Chinello & Stefano Scheggi
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

% Compile MEX-files
mex kctclientmex.c wsock32.lib
mex kctcloseclientmex.c wsock32.lib
mex kctrecdatamex.c wsock32.lib
mex kctsenddatamex.c wsock32.lib

% Copy files in the main folder
copyfile('kctclientmex.dll','../kctclientmex.dll');
copyfile('kctcloseclientmex.dll','../kctcloseclientmex.dll');
copyfile('kctrecdatamex.dll','../kctrecdatamex.dll');
copyfile('kctsenddatamex.dll','../kctsenddatamex.dll');

% Delete files
delete('kctclientmex.dll');
delete('kctcloseclientmex.dll');
delete('kctrecdatamex.dll');
delete('kctsenddatamex.dll');