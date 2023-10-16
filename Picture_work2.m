clear
img = imread("img\kytka256.jpg");
imshow(img);


%% Změna jasu obrazu

jas_obraz = (img*1.5);
imshow(jas_obraz);

%% Zobrazení histogramu

imhist(img);

%% Výmaz části

vym_cast_img = img;
vym_cast_img(50:100, 50:100,:) = 0;
imshow(vym_cast_img);

%% Barevný pruh


gray_img = rgb2gray(img);
gray_img(50:100, 1:end, :) = 0;

bar_pruh = cat(3, gray_img, gray_img,gray_img);
bar_pruh(50:100, 1:end, :) = img(50:100, 1:end, :);
imshow(bar_pruh);

%% Opakující se vzor

binary_pattern = imbinarize(rgb2gray(img));

% Specifikace počtu opakování v obou směrech
num_rows = 10;
num_cols = 10;

repeated_binary_pattern = repmat(binary_pattern, num_rows, num_cols);

% Zobrazení výsledného opakujícího se vzoru
imshow(repeated_binary_pattern, 'InitialMagnification', 'fit');

%% Histogram šedotónu

gray_img = rgb2gray(img);
imhist(gray_img);

%% Histogram jednotlivých kanálů

red = img(:,:,1);
red_hist = imhist(red);
plot(red_hist,'r');
hold on
green = img(:,:,2);
green_hist = imhist(green);
plot(green_hist,'g');
hold on
blue = img(:,:,3);
blue_hist = imhist(blue);
plot(blue_hist,'b');
hold on
rgb_hist = imhist(img);
plot(rgb_hist,'k');


%% Funkce imhist(A) v MATLABu slouží k zobrazení histogramu obrazu A. Histogram obrazu ukazuje distribuci intenzit pixelů v obraze. Histogram lze použít k analýze kontrastu, jasu a dalších vlastností obrázku.

%% Ekvalizace historgramu

tire = imread("tire.tif");
subplot 221; imshow(tire);
subplot 222; imhist(tire);
subplot 223; 
histeq_tire = histeq(tire);
imshow(histeq_tire);
subplot 224; imhist(histeq_tire);

%% Ekvalizace histogramu - princip

pout = imread("pout.tif");
hist_pout = imhist(pout);
histeq_pout = histeq(pout);
histeq_pout_hist = imhist(pout);
comulative_hist_pout = cumsum(hist_pout);
comulative_histeq_pout = cumsum(histeq_pout_hist);
subplot 121; plot(comulative_hist_pout);
subplot 122; plot(comulative_histeq_pout);

%% Adaptivní ekvalizace
rtg = imread("img\OIP.jfif");
rtg = rgb2gray(rtg);



while(true)
    imshow(rtg);
    img1 = rtg;
    [x,y] = ginput(1);

    obr = histeq(rtg(y-20:y+20 , x-20:x+20));

    img1(y-20:y+20,x-20:x+20) = obr;
    imshow(img1);
    pause(1);
end
































