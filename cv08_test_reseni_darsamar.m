close all;

% Načtení všech snímků
img = dicomread("cvt08_test_zadani_metadata.ImageComments.dcm");
info = dicominfo("cvt08_test_zadani_metadata.ImageComments.dcm");

% Získání souřadnic hledaného pixelu jako odstín šedé
x = img(1, 1, 1); % Odstín prvního pixelu prvního snímku
y = img(1, 2, 1); % Odstín druhého pixelu prvního snímku

% Vytvoření pole pro ukládání průměrných odstínů
average_shades = zeros(info.NumberOfFrames, 1);

% Projděte všechny snímky a spočtěte průměrný odstín
for frame = 1:info.NumberOfFrames
    frame_data = dicomread("cvt08_test_zadani_metadata.ImageComments.dcm", 'Frames', frame);
    average_shade = mean(frame_data(:));
    average_shades(frame) = average_shade;
end

% Třídění snímků podle průměrného odstínu
[sorted_shades, sorted_indices] = sort(average_shades);

% Dešifrování zprávy
hidden_message = char(sorted_indices + 65); % Převod indexů na písmena

% Zobrazení písmen vedle sebe
disp(['Dešifrovaná zpráva: ', hidden_message']);
