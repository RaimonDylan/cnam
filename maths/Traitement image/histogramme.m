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
## @deftypefn {} {@var{retval} =} histogramme (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: utilisateur <utilisateur@CLASSMOB-FTLV11>
## Created: 2018-11-22

function [h] = histogramme(image)
    h = numpy.zeros(256,dtype=numpy.float32)
    s = image.shape
    for j in range(s[0]):
        for i in range(s[1]):
            valeur = image[j,i]
            h[int(valeur*255)] += 1
endfunction
