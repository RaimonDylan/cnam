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
  lpmsk = [0 1 0 ; 1 -4 1; 0 1 0];
  imglap = conv2(imSrc,lpmsk,'same');
  imgp = imglap > 0;
  imgp1 = imgp(1:255,1:255); # image de base sans le dernier
  imgph = imgp(1:255,2:256); # image translaté horizontalement
  imgpv = imgp(2:256,1:255); # image translaté verticalement
  imgz = (imgp1 ~= imgph) | (imgp1 ~= imgpv);
  gx = [1 1 1; 0 0 0; -1 -1 -1];
  gy = gx';
  imgn = conv2(imSrc,gx,'same').^2 + conv2(imSrc,gy,'same').^2;
  imgn = imgn(1:255,1:255);
  cont = imgz & (imgn > seuil);
  result = cont;
endfunction
