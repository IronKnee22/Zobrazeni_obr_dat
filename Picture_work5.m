img = imread("img\kytka256.jpg");
img_gray = rgb2gray(img);

thresh = graythresh(img_gray);
img_bin = imbinarize(img_gray,thresh);
imshow(img_bin)

%%
close all;
double_img = double(img_gray);
indx = kmeans(double_img(:),8);
a = reshape(indx,size(img_gray));
imshow(a,[]);
%%
close all;
thresh = graythresh(img);
hsv_img = rgb2hsv(img);
hsv1 = hsv_img(:,:,1);
maska1 = imbinarize(hsv1,thresh);
maska2 = ~maska1;
maska1= uint8(maska1);
maska2 = uint8(maska2);
kytka = img .* maska2;
pozadi = img_gray .* maska1;


d = kytka + pozadi;

imshow(d);

%%
v = [10 20 30 40 50];
v(4)
v(logical([0 0 1 1 0]))

%%
colorThresholder
%%
close all;

cell = imread("cell.tif");
thresh = 0.03;
cell_edge = edge(cell,"sobel",thresh);

se = strel("disk",2);
cell_imdilate = imdilate(cell_edge,se);
cell_fill = imfill(cell_imdilate,"holes");

cell_cler = imclearborder(cell_fill);

cell_imerode = imerode(cell_cler,se);

cell_bwperim = bwperim(cell_imerode);

nejvzdalenejsi_x = max(cell_bwperim(:, 1)) - min(cell_bwperim(:, 1));
nejvzdalenejsi_y = max(cell_bwperim(:, 2)) - min(cell_bwperim(:, 2));


disp(['Šířka: ' num2str(nejvzdalenejsi_x)]);
disp(['Délka: ' num2str(nejvzdalenejsi_y)]);



imshow(cell_bwperim)



