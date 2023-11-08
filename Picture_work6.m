close all;
clear;
img = imread("img\tvary.png");

Gimg = rgb2gray(img);
tresh = graythresh(Gimg);
Bimg = imbinarize(Gimg,"adaptive","ForegroundPolarity","dark","Sensitivity",0.55);
Bimg = ~Bimg;
Bimg = imclearborder(Bimg);
fillimg = imfill(Bimg,"holes");
imshow(fillimg)


stats = regionprops(fillimg, 'Area');

fillimg = bwareafilt(fillimg,15);
a= bwlabel(fillimg);
b = label2rgb(a);

kolec = regionprops(fillimg,"Circularity");
[kolec.Circularity] > 0.9;
kdeKolecko = find([kolec.Circularity]>0.9);

c = ismember(a, kdeKolecko);
d = regionprops(c,"Centroid", "Area");

c = uint8(c);
c = mat2gray(c);

for i = 1:5
    x = d(i);
    x1 = x.Centroid(1);
    y1 = x.Centroid(2);

    % Vložte červenou hvězdičku
    c = insertMarker(c, [x1, y1], 'x', 'Color', 'red');

    text1 = num2str(vertcat(x.Area));
    
    text = strcat(num2str(x1), ',', num2str(y1));
    c = insertText(c, [x1, y1], text1);
end

imshow(c);




    