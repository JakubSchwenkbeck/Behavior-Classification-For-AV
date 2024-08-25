function net = createRNN(features,allLabels)
[XTrain,YTrain] = createTrainingsData(features,allLabels);

layers = createModel(YTrain,XTrain);

options = createTrainingOptions;

net = trainModel(XTrain, YTrain, layers, options);


end

function [XTrain, YTrain] = createTrainingsData(allFeatures, allLabels)

for i = 1:size (allFeatures)
XTrain{i} =  allFeatures{i}';

YTrain{i} = categorical(allLabels{i});
end

  
  %   numSequences = numel(allFeatures);
  %   XTrain = cell(numSequences, 1);
  %   YTrain = cell(numSequences, 1);
  % 
  %   % Determine the maximum number of time steps across all sequences
  %   maxTimeSteps = max(cellfun(@(x) size(x, 1), allFeatures));
  % 
  %   % Collect unique categories across all labels
  %   % allCategories = [];
  %   % for i = 1:numSequences
  %   %     allCategories = [allCategories; double(allLabels{i})]; % Convert categorical to numeric
  %   % end
  % %  uniqueCategories = unique(allCategories);
  % 
  %   for i = 1:numSequences
  %       features = allFeatures{i};
  %       labels = allLabels{i};
  % 
  %       numTimeSteps = size(features, 1);
  %       numFeatures = size(features, 2);
  % 
  %       % Pad features and labels to ensure all sequences have the same length
  %       if numTimeSteps < maxTimeSteps
  %           padSize = maxTimeSteps - numTimeSteps;
  % 
  %           % Pad features with NaNs
  %           features = [features; nan(padSize, numFeatures)];
  % 
  %           % Pad labels
  %           labelsNumeric = double(labels); % Convert categorical to numeric
  %           labelsNumeric = [labelsNumeric; nan(padSize, 1)];
  %           labels = all % Convert back to categorical
  %       end
  % 
  %       % Convert to cell array format for training
  %       XTrain{i} = num2cell(features, 2)'; % Transpose to have time steps as rows
  %       YTrain{i} = labels'; % Transpose labels to match the time steps
  %   end
end


function layers = createModel(YTrain,features)
% Modelparameter
numHiddenUnits = 100; % num of hidden units in LSTM
% Concatenate all arrays in YTrain into one array


allValues = [YTrain{:}];

% Find the unique values in the concatenated array
uniqueValues = unique(allValues);

% Determine the number of unique values
numUniqueValues = numel(uniqueValues);

numFeatures = 6*12; % num of feats

% RNN-Model
layers = [ ...
    sequenceInputLayer(numFeatures) % input layer, dimensions of features
    lstmLayer(numHiddenUnits, 'OutputMode', 'sequence') % First LSTM-layer
    dropoutLayer(0.2) % Dropout with 20% rate
    fullyConnectedLayer(numUniqueValues) % fully connected layer
    softmaxLayer % Softmax-layer for classification
    classificationLayer]; % classification layer
end

function options = createTrainingOptions

options = trainingOptions('adam', ...
    'MaxEpochs', 2500, ...
    'InitialLearnRate', 1e-3, ... % Try reducing this value
    'MiniBatchSize', 32, ...
    'Shuffle', 'every-epoch', ...
    'ValidationFrequency', 50, ...
    'Verbose', false, ...
    'Plots', 'training-progress');
end


function net = trainModel(XTrain, YTrain, layers, options)
[~,x] =size(XTrain);
disp(x + " DataSets for Training");

for i = 1:x
[~,z ] =size(XTrain{i});
[~,y ] =size(YTrain{i});

    % disp("XTrain nr "+i + "  " + z)
    % disp("YTrain nr "+i + "  " + y)

    if(z ~= y)
        disp("not matching at " + i);
 disp("XTrain nr "+i + "  " + z)
    disp("YTrain nr "+i + "  " + y)

    end
end
 
    %layers = createModel(XTrain{1});
% training model
net = trainNetwork(XTrain, YTrain, layers, options);




end

