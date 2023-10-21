%% Průhlednost - alfa kanál
clear
clc
close all;

A = imread("img\kytka256.jpg");
B = imread("img\RGB.jfif");

[A_rows, A_cols, ~] = size(A);
[B_rows, B_cols, ~] = size(B);
B = imresize(B, [A_rows, A_cols]);

subplot 221; imshow(A);
subplot 222; imshow(B);

alfa = 0.1;

A_alfa = alfa * A;
B_alfa =  B;

C = A_alfa + B_alfa;
subplot 223; imshow(C)

%% 2D spektrum sinusovky
close all;

x = linspace(0, 10 * pi, 100); 


Y = sin(x);  

subplot 221; plot(x, Y);

N = length(Y);  
Y_fft = fft(Y);  


amplitude = abs(Y_fft) / N;  

frekvence = (0:N-1) * (1 / (x(2) - x(1))) / N;

subplot 222; plot(frekvence, amplitude);

%% spektrum obrázku

obrazek = imread("img\kytka256.jpg");
obrazek = rgb2gray(obrazek);

spektrum = fft2(obrazek);

log_amplituda = log(abs(fftshift(spektrum)));

imshow(log_amplituda, []);


title('Amplitudové spektrum obrázku');

%% vlnity plech
close all;

%Vytvoreni vlniteho plechu
sirka = 256;
vyska = 256;

[x, y] = meshgrid(1:sirka, 1:vyska);
frekvence = 0.03;  
svisly_plech = sin(2 * pi * frekvence * x);
svisly_plech(svisly_plech > 0) = 255;  
svisly_plech(svisly_plech < 0) = 0; 
svisly_plech = uint8(svisly_plech);
subplot 121; imshow(svisly_plech);

maska = fspecial('average', [10 10]);
blur_svily_plech = imfilter(svisly_plech, maska);
imshow(blur_svily_plech)

%udělání spektre vlnitoho plechu
spektrum = fft2(blur_svily_plech);
log_amplituda = log(abs(fftshift(spektrum)));
subplot 122;imshow(log_amplituda, []);

%% Filtrace ve spektru
close all;
clear
% subplot 331,2 - původní obrázek + spektrum puvodniho
obrazek = imread("img\kytka256.jpg");
obrazek = rgb2gray(obrazek);
subplot 331; imshow(obrazek);

furier_obrazku = fft2(obrazek);

%spektrum obrázku
spektrum_obrazku = log(abs(fftshift(furier_obrazku)));
subplot 332 ; imshow(spektrum_obrazku, []);


% subplot 334,5,6 - obrázek DP, Spektrum po DP, maska DP
% Vytvoření masky
sirka = 256;
vyska = 256;
stred_x = sirka / 2;
stred_y = vyska / 2;
velikost_ctverce = 40;
maska = zeros(vyska, sirka);
maska(stred_y - velikost_ctverce/2:stred_y + velikost_ctverce/2, stred_x - velikost_ctverce/2:stred_x + velikost_ctverce/2) = 1;
mask = ifftshift(maska);
subplot 336; imshow(maska);


%Obrázek po DP
img_dp = abs(ifft2(furier_obrazku .* mask));
subplot 334; imshow(img_dp, [])

%Spektrum po DP
spektrum_dp = spektrum_obrazku .* maska;
subplot 335 ; imshow(spektrum_dp, []);

%HP
H_maska = ~maska;
subplot 339; imshow(H_maska, [])
H_mask = ifftshift(H_maska);

%Obrázek po HP
img_dp = abs(ifft2(furier_obrazku .* H_mask));
subplot 337; imshow(img_dp, [])

%Spektrum po HP
spektrum_hp = spektrum_obrazku .* H_maska;
subplot 338 ; imshow(spektrum_hp, []);









