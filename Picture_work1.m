image = imread("img\kytka256.jpg");
%% Zobrazení
close all;
imshow(image);

%% Změna rozlišení
close all;
image_resize = imresize(image,[1,1]);
imshow(image_resize);

%% Rozložení obrázku na tři barevné části a zobrazení šedotonově
close all;
red = image(:,:,1);
green = image(:,:,2);
blue = image(:,:,3);

subplot 221; imshow(image);
subplot 222; imshow(red);
subplot 223; imshow(green);
subplot 224; imshow(blue);

%% Rozložení obrázku na tři barevné části a zobrazení šedotonově
close all;

red = image(:,:,1);
green = image(:,:,2);
blue = image(:,:,3);

red_chanel = zeros(size(image));
green_chanel = zeros(size(image));
blue_chanel = zeros(size(image));

red_chanel(:,:,1) = red;
green_chanel(:,:,2) = green;
blue_chanel(:,:,3) = blue;

red_chanel = uint8(red_chanel);
green_chanel = uint8(green_chanel);
blue_chanel = uint8(blue_chanel);

subplot 221; imshow(image);
subplot 222; imshow(red_chanel);
subplot 223; imshow(green_chanel);
subplot 224; imshow(blue_chanel);

%% Převedení rgb na gray
close all;
gray_image = rgb2gray(image);
mean_image = mean(image,3);

mean_image = uint8(mean_image);

subplot 211; imshow(gray_image);
subplot 212; imshow(mean_image);
%`rgb2gray` používá váhové koeficienty pro přesný převod na šedou, zatímco `mean(:, 3)` jednoduše bere průměr modrého kanálu bez váhových koeficientů, což může způsobit menší přesnost v převodu na stupně šedi.

%% Převedení na binární
close all;

while(true)
    for i = 1:-0.1:0
        imshow(im2bw(image,i))
        pause(0.1);
    end
end

function binarized_image = im2bw(rgb_image, threshold)

    gray_image = rgb2gray(rgb_image);
    binarized_image = imbinarize(gray_image, threshold);
end

