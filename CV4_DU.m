close all;
clear
clc
image = imread("img/kytka256.jpg");
img_gray = rgb2gray(image);
mkdir('cvt04_du_vysledky/darsamar/');


furier_img = fft2(img_gray);
spektrum_obrazku = log(abs(fftshift(furier_img)));

sirka = 256;
vyska = 256;
stred_x = sirka / 2;
stred_y = vyska / 2;


for i= 0:99
    velikost_a = randi([1, min(sirka, vyska)]);
velikost_b = randi([1, min(sirka, vyska)]);

% Náhodně generujte střed obdélníku
Min_a = velikost_a / 2;
Min_b = velikost_b / 2;
stred_x = randi([round(Min_a), sirka - round(Min_a)]);
stred_y = randi([round(Min_b), vyska - round(Min_b)]);

% Zaokrouhlení hodnot pro vytvoření indexů masky
velikost_b = round(velikost_b);
velikost_a = round(velikost_a);
stred_x = round(stred_x);
stred_y = round(stred_y);

% Vytvoření masky pro obdélník
maska = zeros(vyska, sirka);
maska(round(max(1, stred_y - velikost_b/2)):round(min(vyska, stred_y + velikost_b/2)),...
    round(max(1, stred_x - velikost_a/2)):round(min(sirka, stred_x + velikost_a/2))) = 1;


    maska = ~maska;
    mask = ifftshift(maska);

    spektrum = abs(spektrum_obrazku .* maska);
    spektrum = uint8(spektrum);
    spektrum = mat2gray(spektrum);
    subplot 121 ; imshow(spektrum, []);
    ulozeni_maska = sprintf('cvt04_du_vysledky/darsamar/img_%d_maska.png', i);  
    imwrite(spektrum, ulozeni_maska);

    img = abs(ifft2(furier_img .* mask));
    img = uint8(img);
    %subplot 122; imshow(img, []);
    ulozeni_img = sprintf('cvt04_du_vysledky/darsamar/img_%d_img.jpg', i);  
    imwrite(img, ulozeni_img);

    pause(0.5);
end



