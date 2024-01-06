%% Načtení dat
imds = imageDatastore('obliceje', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');
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

%% Vytvoření nového klasifikačního modelu
layersTransfer = net.Layers(1:end-3);

numClasses = numel(categories(imdsTrain.Labels))

layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

%% Rozšíření trénovacích dat - data jsou augmentována (rozšířena) pomocí náhodného zrcadlení a translace
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);


augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

%% Nastavané trénovacích parametrů
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

%% trénování modelu
netTransfer = trainNetwork(augimdsTrain,layers,options);

%% Klasifikace validačních obráků
[YPred, scores] = classify(netTransfer, augimdsValidation);

idx = randperm(numel(imdsValidation.Files), 16);
figure
for i = 1:16
    subplot(4, 4, i)
    I = readimage(imdsValidation, idx(i));
    imshow(I)
    
    label = YPred(idx(i));
    classLabels = categories(imdsValidation.Labels); % Get class names
    
    % Vyber pravděpodobnost pro správnou třídu
    prob = scores(idx(i), classLabels == label);
    
    title(string(label) + ", " + num2str(100 * prob, 3) + "%");
end




%% Výpočet přesnosti

YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation)















