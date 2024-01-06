net = alexnet;

%%
I = imread('peppers.png');
figure
imshow(I)

%%
sz = net.Layers(1).InputSize;

%%
I = imresize(I, sz(1:2));
figure
imshow(I)

%%
% Classify the image
[label, scores] = classify(net, I);

%%
figure
imshow(I)
title(label)

%%
% Display the top 5 predictions
[~, idx] = sort(scores, 'descend');
idx = idx(5:-1:1);
classNamesTop = net.Layers(end).ClassNames(idx);
scoresTop = scores(idx);

figure
barh(scoresTop)
xlim([0 1])
title('Top 5 Predictions')
xlabel('Probability')
yticklabels(classNamesTop)
