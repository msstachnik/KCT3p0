%    KCTTRAN - Return the homogeneous matrix for translation
%
%    The function computes the homogeneous matrix for translation;
%    Lengths are in millimeters.
%
%    Usage: H = kcttran(tran_vet)
%
%    Arguments:
% 		 	  tran_vet = translation vector [dx,dy,dz] 
%             
%    Return:
%             H = homogeneous matrix for translation
%
%    See also: KCTROTOX, KCTROTOY, KCTROTZ
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

function H = kcttran(tran_vet)

    H = [  1, 0,  0, tran_vet(1,1);
           0, 1,  0, tran_vet(1,2);
           0, 0,  1, tran_vet(1,3);
           0, 0,  0, 1  ];