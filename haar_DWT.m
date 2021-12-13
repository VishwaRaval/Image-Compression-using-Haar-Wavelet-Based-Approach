
% function that is used to implement the Haar Wavlet Transform
function [v,w]=haar_DWT(a)  %matrix "a" is obtained as an input in this functions
                                                                                                                                                                                                                                                                                                                     a=rgb2gray(a);  % the conversion of the image into Grey image if it is a colour image
a=imresize(a,[512 512]); %resizing of the image into a square block (for better handling)

prompt={'Enter the Level of Compression'}; %taking the user input for the level or number of wavlets transformations to be performed
dlg='Enter 1 to 8'; 
l=cell2mat(inputdlg(prompt,dlg)); %
l= sscanf(l,'%f'); % l is the extent of image compression that the user wants
f=1;


for p=1:l   % first for loop L1
[r,c]=size(a);
z=a;        
    for i=1:1:r     %second for loop for rowise haar implementation  L2
        k=1;
        t=(r/2+1);
        for j=1:2:c   %third for loop L3
            avg=(a(i,j)+a(i,j+1))/2; %averaging 
            dif=(a(i,j)-a(i,j+1))/2;  
            z(i,k)=avg;               
            z(i,t)=dif;
            k=k+1;
            t=t+1;
        end
    end
    a=z;
    for j=1:1:c    %second for loop for columnwise haar implementation  L'2
        t=(r/2+1);
        k=1;
        for i=1:2:r  %third for loop L'3
            avg=(a(i,j)+a(i+1,j))/2; 
            dif=(a(i,j)-a(i+1,j))/2;
            z(k,j)=avg;    
            z(t,j)=dif; 
            k=k+1;
            t=t+1;
        end
    end
    if p==1     % Condition for filterting out the Matrix(nxn) containing 
        v=z;    %the average values of size half of the original matrix i
    else        % into a new matrix of half the size ({n/2}x{n/2})
    v(1:512/(2^f),1:512/(2^f))=z;  
    f=f+1;
    end             
    a=z(1:512/(2^p),1:512/(2^p));
end
a=imresize(a,[512 512]); 

w=a; %returing 'w' from the function with reduced Matrix
     

            
            

