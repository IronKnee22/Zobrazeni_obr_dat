close all;
A{1} = imread('img/tvary.png');

A{2} = rgb2gray(A{1});

A{3} = imbinarize(A{2},"adaptive","Sensitivity",0.66);
A{4} = imfill(imcomplement(A{3}),"holes");

A{5} = imclearborder(A{4});

   
%%

stats = regionprops("table",A{6}, "Circularity", "Centroid", "Area");
circleTable = stats(stats.Circularity > 0.9,:);
cc = bwconncomp(A{6});
idx = find([stats.Circularity] > 0.9);
A{7} = ismember(labelmatrix(cc),idx);


montage(A,BorderSize=[3 1], BackgroundColor='g');

figure
A{7} = insertText(im2double(A{7}),circleTable.Centroid,circleTable.Area,FontSize=18,TextBoxColor="cyan", ...
    BoxOpacity=0.4,TextColor="black");
imshow(A{7});
hold on;
axis off
plot(circleTable.Centroid(:,1),circleTable.Centroid(:,2), 'g*');