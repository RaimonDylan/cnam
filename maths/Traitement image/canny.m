function [sFinal,thresh] = canny(img, mLow, mHigh, sig)
% Canny edge detector 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function  [sFinal, thresh] =canny(img, mLow, mHigh, sig)
% Applies the canny edge detection algo to the given image
%  img  : the given image (matrix) in color or B/W   
%  mLow : the threshold is set adaptively: low_threshold = mLow* mean_intensity(im_gradient)
%  mHigh: the threshol is set adaptively: high_threshold= mHigh*low_threshold
%  sig  : the value of sigma for the derivative of gaussian operator
%
% The default values for (sig, mLow, mHigh) are (1, 1, 3)
% The function displays the image and also returns:
%  sFinal       : the final (B/W) image with edges
%  thresh       :  =[lowT, highT] the actual low and high thresholds used
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CS223b HW# 1a: Canny Edge Detector
% Rohit Singh & Mitul Saha:  {rohitsi, mitul}@stanford.edu
%
% Good parameters: 
%     elephant.jpg :  canny(eim,  1.5, 2.6, 1)
%     macbeth.jpg  :  canny(mim, .1, 9, 2); recognises 21 of 24 squares
%     hecface.jpg  :  canny(him, .6, 3, 1); or canny(him, .4,3.5,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin < 1)
  error(' Need a NxNx3 or NxN image matrix');
elseif (nargin ==1)
  mLow = 1; mHigh = 3; sig = 1;
elseif (nargin == 2)
  mHigh = 3; sig = 1;
elseif (nargin == 3)
  sig = 1;
end

img = double(img) ;

origImage = img;

if (ndims(img)==3)
  %img =double(rgb2gray(img));
  img =double(mean(img,3));
end

%smoothen ??
%G = gauss(sig);
%img = conv2(img, G'*G,'same');

%CONVOLUTION WITH DERIVATIVE OF GAUSSIAN
%dG=dgauss(sig,1.4);
dG=d2dgauss(5,1.4,5,1.4,2);
[dummy, filterLen] = size(dG);
offset = (filterLen-1)/2;
sy = conv2(img, dG ,'same');
sx = conv2(img, dG','same');


%fy=[[1.0,2.0,1.0],
%    [0,0,0],
%    [-1,-2,-1]]
%fx=fy';
%sy=conv2(img,fy,'same');
%sx=conv2(img,fx,'same');


[m, n]=size(img);

% crop off the boundary parts...the places where the convolution was partial
sx = sx(offset+1:m-offset, offset+1:n-offset); 
sy = sy(offset+1:m-offset, offset+1:n-offset); 

% norm of gradient
sNorm = sqrt( sx.^2 + sy.^2 );

% direction of gradient
sAngle = atan2( sy, sx) * (180.0/pi);

% handle divide by zero....
sx(sx==0) = 1e-10;
sSlope = abs(sy ./ sx);

sAorig = sAngle;

%for us, x and x-pi are the same....
y = sAngle < 0;
sAngle = sAngle + 180*y;

% bin the angles into 4 principal directions
% 0-45 45-90 90-135 135-180

binDist =    [-inf 45 90 135 inf];

[dummy, b] = histc(sAngle,binDist);

sDiscreteAngles = b;
[m,n] = size(sDiscreteAngles);

% each pixel is set to either 1,2,3 or 4
% set the boundary pixels to 0, so we don't count them in analysis...
sDiscreteAngles(1,:) = 0;
sDiscreteAngles(end,:)=0;
sDiscreteAngles(:,1) = 0;
sDiscreteAngles(:,end) = 0;

sEdgepoints = zeros(m,n);

sFinal = sEdgepoints;

lowT  = mLow * mean(sNorm(:));
highT = mHigh * lowT;

thresh = [ lowT highT];

% NON-MAXIMAL SUPPRESSION

% for each kind of direction, interpolate.... and see if the current point is
% is the local maximum in that direction

%in the following comments, assume that we are currently at (0,0) and
%we have to interpolate from the 8 surrounding pixels, also, we are
%using MATLAB's single index feature...

%gradient direction: 0-45 i.e. gradDir =1
gradDir = 1;
indxs = find(sDiscreteAngles == gradDir);
slp = sSlope(indxs);

%subplot(221)
%imagesc(sDiscreteAngles==1)
%xlabel('1')
%subplot(222)
%imagesc(sDiscreteAngles==2)
%xlabel('2')
%subplot(223)
%imagesc(sDiscreteAngles==3)
%xlabel('3')
%subplot(224)
%imagesc(sDiscreteAngles==4)
%xlabel('4')
%pause

% interpolate between (1,1) and (1,0)
% gDiff1 = Gy/Gx*(magtd(0,0) - magtd(1,1)) + (1- Gy/Gx)*(magtd(0,0)-magtd(1,0))
gDiff1 = slp.*(sNorm(indxs)-sNorm(indxs+m+1)) + (1-slp).*(sNorm(indxs)-sNorm(indxs+1));

% interpolate between (-1,-1) and (-1,0)
% gDiff2 = Gy/Gx*(magtd(0,0) - magtd(-1,-1)) +  (1- Gy/Gx)*(magtd(0,0)-magtd(-1,0))
gDiff2 = slp.*(sNorm(indxs)-sNorm(indxs-m-1)) + (1-slp).*(sNorm(indxs)-sNorm(indxs-1));

okIndxs = indxs( gDiff1 >=0 & gDiff2 >= 0);
sEdgepoints(okIndxs) = 1;


%gradient direction: 45-90 i.e. gradDir =2
gradDir = 2;
indxs = find(sDiscreteAngles == gradDir);
invSlp = 1 ./ sSlope(indxs);

% interpolate between (1,1) and (0,1)
% gDiff1 = (Gx/Gy)*(magtd(0,0) - magtd(1,1)) + (1- Gx/Gy)*(magtd(0,0)-magtd(0,1))
gDiff1 =   invSlp.*(sNorm(indxs)-sNorm(indxs+m+1)) + (1-invSlp).*(sNorm(indxs)-sNorm(indxs+m));

% interpolate between (-1,-1) and (0,-1)
% gDiff2 = (Gx/Gy)*(magtd(0,0) - magtd(-1,-1)) + (1- Gx/Gy)*(magtd(0,0)-magtd(0,-1))
gDiff2 =   invSlp.*(sNorm(indxs)-sNorm(indxs-m-1)) + (1-invSlp).*(sNorm(indxs)-sNorm(indxs-m));

okIndxs = indxs( gDiff1 >=0 & gDiff2 >= 0);
sEdgepoints(okIndxs) = 1;


%gradient direction: 90-135 i.e. gradDir =3
gradDir = 3;
indxs = find(sDiscreteAngles == gradDir);
invSlp = 1 ./ sSlope(indxs);

% interpolate between (-1,1) and (0,1)
% gDiff1 = (Gx/Gy)*(magtd(0,0) - magtd(-1,1)) + (1- Gx/Gy)*(magtd(0,0)-magtd(0,1))
gDiff1 =   invSlp.*(sNorm(indxs)-sNorm(indxs+m-1)) + (1-invSlp).*(sNorm(indxs)-sNorm(indxs+m));

% interpolate between (1,-1) and (0,-1)
% gDiff2 = (Gx/Gy)*(magtd(0,0) - magtd(1,-1)) + (1- Gx/Gy)*(magtd(0,0)-magtd(0,-1))
gDiff2 =   invSlp.*(sNorm(indxs)-sNorm(indxs-m+1)) + (1-invSlp).*(sNorm(indxs)-sNorm(indxs-m));

okIndxs = indxs( gDiff1 >=0 & gDiff2 >= 0);
sEdgepoints(okIndxs) = 1;



%gradient direction: 135-180 i.e. gradDir =4
gradDir = 4;
indxs = find(sDiscreteAngles == gradDir);
slp = sSlope(indxs);

% interpolate between (-1,1) and (-1,0)
% gDiff1 = Gy/Gx*(magtd(0,0) - magtd(-1,1)) + (1- Gy/Gx)*(magtd(0,0)-magtd(-1,0))
gDiff1 = slp.*(sNorm(indxs)-sNorm(indxs+m-1)) + (1-slp).*(sNorm(indxs)-sNorm(indxs-1));

% interpolate between (1,-1) and (1,0)
% gDiff2 = Gy/Gx*(magtd(0,0)-magtd(1,-1)) +  (1- Gy/Gx)*(magtd(0,0)-magtd(1,0))
gDiff2 = slp.*(sNorm(indxs)-sNorm(indxs-m+1)) + (1-slp).*(sNorm(indxs)-sNorm(indxs+1));

okIndxs = indxs( gDiff1 >=0 & gDiff2 >= 0);
sEdgepoints(okIndxs) = 1;


%imagesc(sEdgepoints)
%pause


%imagesc(sEdgepoints)

%pause

%HYSTERESIS PART...
sEdgepoints = sEdgepoints*0.6;
x = find(sEdgepoints > 0 & sNorm < lowT);
sEdgepoints(x)=0;
x = find(sEdgepoints > 0 & sNorm  >= highT);
sEdgepoints(x)=1;

%imagesc(sEdgepoints)

%pause

%sFinal(sEdgepoints>0)=1;

%at this point, if 
%    sNorm(pixel) > lowT then sEdgepoints(pixel)=0
%    highT > sNorm(pixel) > lowT then sEdgepoints(pixel)=0.6
%    sNorm(pixel) > highT then sEdgepoints(pixel)=1

% the idea is this: along the neighbouring pixels in that direction
% add 0.4...so all points that were 0.6 will become 1.0
% see if the number of 1's has changed...
% keep doing while number of 1's doesn't change

oldx = [];
x = find(sEdgepoints==1);
i=1 ;
while (size(oldx,1) ~= size(x,1))
  oldx = x;
  v = [x+m+1, x+m, x+m-1, x-1, x-m-1, x-m, x-m+1, x+1];
  sEdgepoints(v) = 0.4 + sEdgepoints(v);
  y = find(sEdgepoints==0.4);
  sEdgepoints(y) = 0;
  y = find(sEdgepoints>=1);
  sEdgepoints(y)=1;
  x = find(sEdgepoints==1);

  sFinal=sFinal*0;
  sFinal(x)=1;
  %imagesc(sFinal);
  i=i+1;
 % pause
end
		   
x = find(sEdgepoints==1);

sFinal=sFinal*0;
sFinal(x)=1;

%figure(1);
%imagesc(sFinal); colormap(gray); axis image;








%%%%%%% The functions used in the main.m file %%%%%%%
% Function "d2dgauss.m":
% This function returns a 2D edge detector (first order derivative
% of 2D Gaussian function) with size n1*n2; theta is the angle that
% the detector rotated counter clockwise; and sigma1 and sigma2 are the
% standard deviation of the gaussian functions.
function h = d2dgauss(n1,sigma1,n2,sigma2,theta)
r=[cos(theta) -sin(theta);
   sin(theta)  cos(theta)];
for i = 1 : n2 
    for j = 1 : n1
        u = r * [j-(n1+1)/2 i-(n2+1)/2]';
        h(i,j) = gauss(u(1),sigma1)*dgauss(u(2),sigma2);
    end
end
h = h / sqrt(sum(sum(abs(h).*abs(h))));

% Function "gauss.m":
function y = gauss(x,std)
y = exp(-x^2/(2*std^2)) / (std*sqrt(2*pi));

% Function "dgauss.m"(first order derivative of gauss function):
function y = dgauss(x,std)
y = -x * gauss(x,std) / std^2;
%%%%%%%%%%%%%% end of the functions %%%%%%%%%%%%%
