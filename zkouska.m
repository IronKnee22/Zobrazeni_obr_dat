close all;


digitDatasetPath = fullfile(matlabroot,'toolbox','nnet', 'nndemos','nndatasets', 'DigitDataset');

 imds = imageDatastore(digitDatasetPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
[imdsTrain, imdsValidation] = splitEachLabel (imds, 0.7, 'randomize');

layers = [
    imageInputLayer([28 28 1]) 
    
    convolution2dLayer(5, 16, 'Padding', 'same') 
    batchNormalizationLayer 
    reluLayer 
       
    convolution2dLayer(8, 20, 'Padding', 'same') 
    batchNormalizationLayer
    leakyReluLayer 
       
    fullyConnectedLayer(10) 
    softmaxLayer 
    classificationLayer
];


path_test_data = 'imgs/7v0';
imds_test = imageDatastore(path_test_data, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

imds_test_formated= transform(imds_test, @upravitObr);


options = trainingOptions('sgdm', ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.2, ...
    'LearnRateDropPeriod', 5, ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 64, ...
    'ValidationData', imdsValidation,...
    'Plots', 'training-progress');



if ~exist('net', 'var')
    net = trainNetwork(imdsTrain, layers, options);
else
    disp('Používám již natrénovanou sít z workspase');
end



predicted_numbers = classify(net, imds_test_formated);

figure('Name','Klasifikace čísel')

for i = 1:length(predicted_numbers)
    
    
    subplot(1,length(predicted_numbers), i);
    testImage = readimage(imds_test, i);
    imshow(testImage);
    title(['Na obrázku je čáslo: ', num2str(char(predicted_numbers(i)))]);
    
end


function outputImage = upravitObr(inputImage)
    

    img = inputImage;
    gray = rgb2gray(img);
    bin = imbinarize(gray);
    bin = ~bin;

    region_props = regionprops(bin, 'Image');
    region_image = region_props.Image;
    padded_number = padarray(region_image, [15, 15], 0);
    final_image = imresize(padded_number, [28, 28]);
    
    final_image = im2uint8(final_image);
    outputImage = final_image;

end






