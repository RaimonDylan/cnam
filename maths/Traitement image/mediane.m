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
## @deftypefn {} {@var{retval} =} mediane (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: utilisateur <utilisateur@CLASSMOB-FTLV11>
## Created: 2018-11-27
function retval = medfilt2(A, varargin)

padding = "zeros";
domain = logical(ones(3,3));

for i=1:length(varargin)
  a = varargin{i};
  if(isstr(a))
    padding = a;
  elseif(is_vector(a) && size(a) == [1, 2])
    domain = logical(ones(a(2), a(1)));
  elseif(is_matrix(a))
    domain = logical(a);
  endif
endfor

n = sum(sum(domain));
if((n - 2*floor(n/2)) == 0) % n even - more work
  nth = floor(n/2);
  a = ordfilt2(A, nth, domain, padding);
  b = ordfilt2(A, nth + 1, domain, padding);
  retval = (a + b)./2;
else
  nth = floor(n/2) + 1;
  retval = ordfilt2(A, nth, domain, padding);
endif

endfunction