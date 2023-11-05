close all;
clear;
img = imread("img\tvary.png");
imshow(img);
Gimg = rgb2gray(img);
tresh = graythresh(Gimg);
Bimg = imbinarize(Gimg,"adaptive","ForegroundPolarity","dark","Sensitivity",0.5);
Bimg = ~Bimg;
Bimg = imclearborder(Bimg);
fillimg = imfill(Bimg,"holes");


stats = regionprops(fillimg, 'Area');

fillimg = bwareafilt(fillimg,15);
a= bwlabel(fillimg);
b = label2rgb(a);

kolec = regionprops(fillimg,"Circularity");
[kolec.Circularity] > 0.9;
kdeKolecko = find([kolec.Circularity]>0.9);

c = ismember(a, kdeKolecko);
d = regionprops(c,"Centroid");

imshow(c)



    