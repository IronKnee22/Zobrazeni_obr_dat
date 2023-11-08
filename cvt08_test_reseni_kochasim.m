filename = "cvt08_test_zadani_metadata.ImageComments.dcm";
A = dicomread(filename);

info = dicominfo(filename);
disp(info.ImageComments); % ukaze zadani a ctu text
firstImage = dicomread(filename, 'Frames', 1);
imhist(firstImage); % ukaze histogram

imshow(firstImage);
coords = firstImage([1, 2]); % souradnice pixelu

pixelVal = zeros(1,14);
averGray =zeros(1,14);


for k = 1:info.NumberOfFrames
    frame = dicomread(filename, 'frames', k);
    
    pixelVal(k) = frame(coords(1), coords(2)); % hodnoty pixelu

    averGray(k) = mean(frame(:)); % prumer odstinu
end
 
[~, sortedIndices] = sort(averGray); % serazeni prumeru odstinu
sortedPixelValues = pixelVal(sortedIndices); % serazeni podle serazenych prumernych odstinu

mes = char(sortedPixelValues); % tajna zprava
disp(mes);
