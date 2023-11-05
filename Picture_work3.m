%% Jak funguje autofocus
% Princip autofokusu spočívá v detekci rozdílů v kontrastu nebo fázi mezi různými oblastmi obrazu a následném pohybu čoček nebo senzoru zaostřovacího mechanismu tak, aby se dosáhlo optimálního zaostření.

%% Vyhlazení grafu
close all;
vektor = randi([1, 10], 1, 10);
kernel = ones(1, 3) / 3;
% Pomocí klouzavého průměru
vysledek2 = zeros(1, length(vektor) - length(kernel) + 1);

for i = 1:length(vysledek2)
    vysledek2(i) = mean(vektor(i:i+2)); % Klouzavý průměr o velikosti 3
end

disp('Výsledek po klouzavém průměru:');
plot(vysledek2,'k');
disp(vysledek2);


% Pomocí konvoluce
vektor = randi([1, 10], 1, 10);
disp('Původní vektor:');
disp(vektor);
plot(vektor,'b');
hold on
% Definice jádra pro konvoluci (klouzavý průměr o velikosti 3)
kernel = ones(1, 3) / 3;
vysledek = conv(vektor, kernel);
plot(vysledek,'r');
disp('Výsledek po konvoluci:');
hold on
disp(vysledek);

%% Další příklad na konvoluci
M = [10 20 30;40 50 60;70 80 90];
kernel = ones(2, 2) / 4;
vysledek3 = conv2(M, kernel,"valid");
disp(vysledek3);
% výsledkem je zmenšená matice

%% Další konvoluce
close all;
img = imread("img/kytka256.jpg");
gray_img = rgb2gray(img);

kernel = [-1 0 1;-1 0 1;-1 0 1];

conv_kytka = conv2(gray_img,kernel);
imshow(conv_kytka);

%% Filtrace průměrovací maskou
close all;
image = rgb2gray(img);
x = 100:105; 
y = 200:205; 
max_hodnota = 255; 
image(y, x,:) = max_hodnota; 
%imshow(image)

maska = fspecial('average', [15 15]);
vysledny_obrazek = imfilter(image, maska);
imshow(vysledny_obrazek);

%% Filtrace gausem

close all;
image = rgb2gray(img);
x = 100:105; 
y = 200:205; 
max_hodnota = 255; 
image(y, x,:) = max_hodnota; 
subplot 121; imshow(image);


mask_size = 15;
sigma = 2.0;
gaussian_mask = fspecial('gaussian', [mask_size mask_size], sigma);
vysledny_obrazek = imfilter(image, gaussian_mask);
subplot 122;imshow(vysledny_obrazek);

%% Gausový šum a wienerův filtr
close all;
img = imread("img/kytka256.jpg");

gaus_noise = imnoise(img,"gaussian");
subplot 221; imshow(gaus_noise)

gray_noise = rgb2gray(gaus_noise);
subplot 223; imshow(gray_noise)

%gausův šum
mask_size = 5;
sigma = 2.0;
gaussian_mask = fspecial('gaussian', [mask_size mask_size], sigma);
vysledny_obrazek = imfilter(gaus_noise, gaussian_mask);
subplot 222;imshow(vysledny_obrazek);

%wienerův filtr

wiener = wiener2(gray_noise,[4 4]);
subplot 224; imshow(wiener)

%% Selektivní rozmazání
close all;
threshold = 128;

img = imread("img/kytka256.jpg");
image1 = rgb2gray(img);
image2 = image1;
subplot 221; imshow(image1);

maska = fspecial('average', [15 15]);
mask2 = image2 <= threshold;
image2 = imfilter(image2, maska);

subplot 222; imshow(image2)


 % Práh pro dělení pixelů
mask1 = (image1 > threshold);


mask1 = uint8(mask1);
mask2 = uint8(mask2);
kytka = image1 .* mask1;
rozmazany = image2 .* mask2;

% Vytvořte výsledný obrázek na základě masek
result_image = rozmazany + kytka;

% Zobrazte výsledný obrázek
subplot 223; imshow(result_image);

%% Který obrázek je ostřejší
close all;
img = imread("img/kytka256.jpg");
image1 = rgb2gray(img);
subplot 221; imshow(image1);

maska = fspecial('average', [15 15]);
image2 = imfilter(image1, maska);
subplot 222; imshow(image2);

% Detekce hran (horní propust)
edge_image1 = edge(image1, 'canny');
edge_image2 = edge(image2, 'canny');

% Počet hran
edge_count1 = sum(edge_image1(:));
edge_count2 = sum(edge_image2(:));

% Směrodatná odchylka
std1 = std(double(image1(:)));
std2 = std(double(image2(:)));

% Fourierova transformace
fft1 = fft2(image1);
fft2 = fft2(image2);

% Výpočet energie vysokých frekvencí (v tomto případě sumou)
high_freq_energy1 = sum(abs(fftshift(fft1)).^2);
high_freq_energy2 = sum(abs(fftshift(fft2)).^2);

% Zobrazte výsledky
disp('Obrázek 1:');
disp(['Počet hran: ', num2str(edge_count1)]);
disp(['Směrodatná odchylka: ', num2str(std1)]);
disp(['Energie vysokých frekvencí: ', num2str(high_freq_energy1)]);

disp('Obrázek 2:');
disp(['Počet hran: ', num2str(edge_count2)]);
disp(['Směrodatná odchylka: ', num2str(std2)]);
disp(['Energie vysokých frekvencí: ', num2str(high_freq_energy2)]);


%% Detekce nejostřejšího snímku ve videu (celkově)
close all;
videoObj = VideoReader("img/podzimni_kvetena_focus_test.mp4");
nejostrejsi = 0;
i = 0;

while hasFrame(videoObj)
    frame = readFrame(videoObj);
    subplot 121; imshow(frame);

    gray_frame = rgb2gray(frame);

    a = edge(gray_frame, 'sobel');
    b = edge(nejostrejsi, 'sobel');
    
    a = sum(a(:));
    b = sum(b(:));

    if(a>b)
        nejostrejsi = gray_frame;
        frame_nej = frame;
        subplot 122; imshow(frame);
        text(10, 10, ['Nejostřejší snímek je:  ' num2str(i)], 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'r');

    end

    pause(0.000000001);
    i = i + 1;
    
end

%% Detekce nejostřejšího snímku ve videu (část)
close all;
videoObj = VideoReader("img/podzimni_kvetena_focus_test.mp4");
nejostrejsi_crop = 0;
i = 0;

while hasFrame(videoObj)
    frame = readFrame(videoObj);
    subplot 121; imshow(frame);

    gray_frame = rgb2gray(frame);

    % Definujte rozměry čtverce uprostřed
    centerX = size(frame, 2) / 2;
    centerY = size(frame, 1) / 2;
    sideLength = 100; % Velikost strany čtverce (nastavte podle potřeby)

    % Vyberte čtvercovou oblast středu
    cropped_gray_frame = gray_frame(centerY - sideLength/2 : centerY + sideLength/2, centerX - sideLength/2 : centerX + sideLength/2);

    a = edge(cropped_gray_frame, 'sobel');
    b = edge(nejostrejsi_crop, 'sobel');

    a = sum(a(:));
    b = sum(b(:));

    if (a > b)
        nejostrejsi_crop = cropped_gray_frame;
        nejostrejsi_celej = frame;
        subplot 122;
        imshow(frame);
        text(10, 10, ['Nejostřejší snímek je:  ' num2str(i)], 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'r');
    end

    pause(0.000000001);
    i = i + 1;
end





