imgs = dicomread('cvt08_test_zadani_metadata.ImageComments.dcm');
%(1b)Ctete tento text 
% (2b)Zobrazte histogram prvniho snimku 
% (2b za dokonceni)Najdete zpravu, ktera se skryva v jednom pixelu kazdeho snimku. Souradnice hledaneho pixelu jsou pro vsechny snimky stejne. 
% (2b)Souradnice hledaneho pixelu najdete jako odstin sedi v prvnim a druhem prvku img([1,2]) prvniho snimku.  
% (3b)Pro spravne poradi pismen ve zprave musite seradit snimky dle prumerneho odstinu  Napoveda: Prevod z cisel do znaku: char([ 66   75   90   79   68]). Skryta zprava je srozumitelny text v cestine
montage(imgs);
img1 = imgs(:,:,:,1); 
message_pixel = img1([1,2]);
 
for ii=1:size(imgs,4)
    img = imgs(:,:,:,ii);
    avg_color(ii) = mean(img,'all');
    messageVal(ii) = img(message_pixel(1),message_pixel(2));
end
img = imgs(:,:,:,5);
[~,indexes] = sort(avg_color);
stem(avg_color(indexes))
message = char( messageVal(indexes) )
%% konvoluce
kernel =double( imgs(end-4:end, end-4:end,:,end));
kernel = kernel/ sum(kernel,'all');
img1_conv = imfilter(img(:,:,:,1),kernel);
% imshow(img1_conv)
%% zobrazeni
close all
subplot 221; imhist(imgs(:,:,:,1))
subplot 222; imshow(img1_conv)
subplot 212;
text(0,0.5, sprintf('souradnice pixelu jsou: [%d %d]. Vysledek: %s',message_pixel(1),message_pixel(2),message));