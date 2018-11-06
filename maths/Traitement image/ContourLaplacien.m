## Copyright (C) 2018 utilisateur
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} ContourLaplacien (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: utilisateur <utilisateur@CLASSMOB-FTLV11>
## Created: 2018-11-06

function [result] = ContourLaplacien (imSrc, seuil)
  masque = [0 1 0;1 -4 1; 0 1 0];
  implap = conv2(imSrc,masque,'same');
  impol = implap <= 0;
  [n,m] = size(impol);
  for i=0:n
    for j=0:m
      if(impol(i,j) == 0 && impol(i,j+1) == 1
        imzero(i,j) = 1;
       end
    end
  end
  result = impol;
endfunction
