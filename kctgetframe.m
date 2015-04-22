%    KCTGETFRAME - Return the current Cartesian frame
%
%    The function returns the current Cartesian frames, all movements
%    must be referred in this frame.
%
%    Usage: Hfr = kctgetframe()
%
%    Return:
%           Hfr = Homogeneous matrix

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

function currentframe= kctgetframe

global kctrotfr;
global kctptfr;

currentframe = [kctrotfr,kctptfr';0 0 0 1];