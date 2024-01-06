%% Načtení dat
imds = imageDatastore('obliceje', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

[imdsTrain,imdsTest] = splitEachLabel(imds,0.7,'randomized');
numTrainImages = numel(imdsTrain.Labels);
idx = randperm(numTrainImages,16);

%% Zobrazení náhodných trénovacích obrázků
figure
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsTrain,idx(i));
    imshow(I)
end

%% Načtení předškolené sítě AlexNet
net = alexnet;
inputSize = net.Layers(1).InputSize

%%
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain);
augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest);

layer = 'fc7';
featuresTrain = activations(net,augimdsTrain,layer,'OutputAs','rows');
featuresTest = activations(net,augimdsTest,layer,'OutputAs','rows');

%%
YTrain = imdsTrain.Labels;
YTest = imdsTest.Labels;

%%
mdl = fitcecoc(featuresTrain,YTrain);

YPred = predict(mdl,featuresTest);

%%


idx = [1 5 10 15];
figure
for i = 1:numel(idx)
    subplot(2,2,i)
    I = readimage(imdsTest,idx(i));
    label = YPred(idx(i));
    
    imshow(I)
    title(label)
end





















