%% Jak funguje autofocus
% Princip autofokusu spočívá v detekci rozdílů v kontrastu nebo fázi mezi různými oblastmi obrazu a následném pohybu čoček nebo senzoru zaostřovacího mechanismu tak, aby se dosáhlo optimálního zaostření.

%% Vyhlazení grafu
close all;

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


