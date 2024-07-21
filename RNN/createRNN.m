function net = createRNN(features,allLabels)
[XTrain,YTrain] = createTrainingsData(features,allLabels);

layers = createModel(YTrain,XTrain{1});

options = createTrainingOptions;

net = trainModel(XTrain, YTrain, layers, options);


end

function [XTrain, YTrain] = createTrainingsData(allFeatures, allLabels)
    numSequences = numel(allFeatures);
    XTrain = cell(numSequences, 1);
    YTrain = cell(numSequences, 1);

    % Determine the maximum number of time steps across all sequences
    maxTimeSteps = max(cellfun(@(x) size(x, 1), allFeatures));
    
    % Collect unique categories across all labels
    allCategories = [];
    for i = 1:numSequences
        allCategories = [allCategories; double(allLabels{i})]; % Convert categorical to numeric
    end
    uniqueCategories = unique(allCategories);
    
    for i = 1:numSequences
        features = allFeatures{i};
        labels = allLabels{i};

        numTimeSteps = size(features, 1);
        numFeatures = size(features, 2);

        % Pad features and labels to ensure all sequences have the same length
        if numTimeSteps < maxTimeSteps
            padSize = maxTimeSteps - numTimeSteps;

            % Pad features with NaNs
            features = [features; nan(padSize, numFeatures)];

            % Pad labels
            labelsNumeric = double(labels); % Convert categorical to numeric
            labelsNumeric = [labelsNumeric; nan(padSize, 1)];
            labels = categorical(labelsNumeric, uniqueCategories); % Convert back to categorical
        end

        % Convert to cell array format for training
        XTrain{i} = num2cell(features, 2)'; % Transpose to have time steps as rows
        YTrain{i} = labels'; % Transpose labels to match the time steps
    end
end


function layers = createModel(YTrain,features)
% Modelparameter
numHiddenUnits = 100; % num of hidden units in LSTM
numClasses = numel(categories(YTrain{1,1})); % num of classes
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

 
    layers = createModel(XTrain{1});
% training model
net = trainNetwork(XTrain, YTrain, layers, options);

end

