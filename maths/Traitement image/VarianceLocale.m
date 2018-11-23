function res = VarianceLocale(im,msk)

img = double(im) ;
[l,c]=size(img);
res=ones(size(img));

m=floor(msk/2);
for i=m+1:l-m,
    for j=m+1:c-m,
        a=img(i-m:i+m,j-m:j+m);
        B=reshape(a,1,msk^2);
        C=var(B,1);
        res(i,j)=C;

    end
end

