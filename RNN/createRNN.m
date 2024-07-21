function net = createRNN(features)
[XTrain,YTrain] = createTrainingsData(features);

layers = createModel(YTrain,features);

options = createTrainingOptions;

net = trainModel(XTrain, YTrain, layers, options);


end

function [XTrain,YTrain] = createTrainingsData(features)
% label classification for risk by hand (0 not risky, 1 full on risk)
labels = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.15,0.2,0.4,0.5,0.55,0.6,0.7,0.8,0.9,0.9,0.1,0.1];


numTimeSteps = size(features, 1); % get number of time steps


% creating a cell array, where each cell contains a timestep
XTrain = cell(numTimeSteps, 1);
for i = 1:numTimeSteps
    XTrain{i} = features(i, :)'; % transpose,to have each timestep as a column vec
end


% Labels (assumption: Classificatipon for each timestep)
YTrain = categorical(labels); % Make sure the labels are categorial

end

function layers = createModel(YTrain,features)
% Modelparameter
numHiddenUnits = 100; % num of hidden units in LSTM
numClasses = numel(categories(YTrain)); % num of classes
numFeatures = size(features, 2); % num of feats

% RNN-Model
layers = [ ...
    sequenceInputLayer(numFeatures) % input layer, dimensions of features
    lstmLayer(numHiddenUnits, 'OutputMode', 'last') % LSTM-layer
    fullyConnectedLayer(numClasses) % fully connected layer
    softmaxLayer % Softmax-layer for classification
    classificationLayer]; % classification layer

end

function options = createTrainingOptions
% determining trainingsoptions 
options = trainingOptions('adam', ...
    'MaxEpochs', 20, ...
    'MiniBatchSize', 20, ...
    'Verbose', 1, ...
    'Plots', 'training-progress');


end


function net = trainModel(XTrain, YTrain, layers, options)
% training model
net = trainNetwork(XTrain, YTrain, layers, options);

end

