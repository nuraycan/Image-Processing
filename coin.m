%% Coin Counting Image Processing Project %%
%% Written by: Nuray Can      %%

x=imread('para.jpg'); % Read the image
x1=rgb2gray(x); % Convert RGB image to Grayscale
figure,imhist(x1) %plot the histogram of the image 

%%--------------------------%%
%% Convert image to black and white image by thresholding %%

y=x1<128; %Threshold=128. Decide it by using the histogram or trial and error method.
figure, imshow(y) 

%%-------------------------%%
%% Remove noise and Fill the Holes %%
%% Filling image regions and holes.
t=imfill(y,'holes'); % fill the holes with white
figure, imshow(t) %Figure5
%% FILTERING (2-D median filtering.)
imFiltered = medfilt2(t); % medfilt2 is using to remove salt and pepper noise in image t. 
figure,imshow(imFiltered) %Figure6

%%-------------------------%%
%% Labeling                %%
[L,num]=bwlabel(imFiltered,8); % returns in NUM the number of connected objects found in imFiltered.
%8 is the number of connected objects, 
%L is the number of labels
%num is the number of objects 
disp(['There are ', num2str(num), ' coins.'])

%%---------------------------%%
%% Finding Objects           %%
for i=1:1:num
[r,c]=find(L==i); %this line finds the objects and their rows and columns
rmin=min(r);rmax= max(r); %minimum and maximum row values of objects
cmin=min(c);cmax=max(c) ; %minimum and maximum columns values of objects
m=x(rmin:rmax,cmin:cmax); % crops the objects from original image
figure, imshow(m)
title(['Coin number:',num2str(i)]);
area(i)= bwarea(m);% Calculates the areas of each objects
end
total=0;
sort1=sort(area);%sorts the value of areas from smaller to bigger

%%------------------------------%%
%% Finding Values of each Coins %%
for j=1:1:num
if sort1(j)<=3000
        c1=c1+1; % 5 Kuruş

elseif sort1(j)<=3600 & sort1(j)>3300
        c2=c2+1;%10 Kuruş
elseif sort1(j)<=4300 & sort1(j)>3850
            c3=c3+1; %25 Kuruş
elseif sort1(j)<=6100 & sort1(j)>5400
        c4=c4+1;%50 Kuruş
else
       c5=c5+1; %1 TL
end
end

disp(['There are ',num2str(c1),'*5 Kuruş,',num2str(c2),'*10 Kuruş,',num2str(c3),'*25 Kuruş,',num2str(c4),'*50 Kuruş,',num2str(c5), '*1 TL' ])
total=c1*50+c2*100+c3*250+c4*500+c5*1000;%total amount of the coins
total=total/1000;
disp(['Total of money: ',num2str(total),' TL'])


