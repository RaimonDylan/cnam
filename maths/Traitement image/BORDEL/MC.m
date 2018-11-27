function r=MC(img1,img2,bord)

[L,C] = size(img1) ;
[L1,C1] = size(img2) ;

if L ~= L1
	printf('Image de tailles differentes !!\n') ;
	return
elseif C ~= C1
	printf('Image de tailles differentes !!\n') ;
	return
else
	ext1 = img1(bord:L-bord , bord:C-bord);
	ext2 = img2(bord:L-bord , bord:C-bord);
	r = mean(mean((ext1 - ext2).^2)) ;
end
	


