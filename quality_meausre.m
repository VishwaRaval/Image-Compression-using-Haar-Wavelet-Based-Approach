

function [b]=quality_meausre(A,B)

clear b;
clear PSNR;
A=double(A);
B=double(B);
sqi=(A-B).^2;
mse=sum(sum(sqi))/((size(A,1)*size(A,2)));
PSNR=10*log10(255^2/mse);
b=PSNR;