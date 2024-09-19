function net = createRNN(features, allLabels)
    % createRNN - Creates, configures, and trains an RNN using LSTM for sequence classification.
    %
    % Syntax: net = createRNN(features, allLabels)
    %
    % Inputs:
    %   features  - Cell array containing the input feature sequences for training.
    %   allLabels - Cell array containing the corresponding labels for each feature sequence.
    %
    % Outputs:
    %   net - The trained recurrent neural network model.
    %
    % Example:
    %   net = createRNN(features, allLabels);

    % Prepare the training data
    [XTrain, YTrain] = createTrainingsData(features, allLabels);

    % Create the RNN layers/model
    layers = createModel(YTrain, XTrain);

    % Set the training options
    options = createTrainingOptions;

    % Train the RNN model
    net = trainModel(XTrain, YTrain, layers, options);
end

function [XTrain, YTrain] = createTrainingsData(allFeatures, allLabels)
    % createTrainingsData - Prepares the input data and labels for RNN training.
    %
    % Syntax: [XTrain, YTrain] = createTrainingsData(allFeatures, allLabels)
    %
    % Inputs:
    %   allFeatures - Cell array of input feature sequences.
    %   allLabels   - Cell array of corresponding labels.
    %
    % Outputs:
    %   XTrain - Cell array of transposed feature sequences.
    %   YTrain - Cell array of categorical label sequences.

    % Initialize cell arrays for training data
    XTrain = cell(size(allFeatures));
    YTrain = cell(size(allLabels));

    % Loop through each sequence
    for i = 1:numel(allFeatures)
        XTrain{i} = allFeatures{i}';  % Transpose features to match input format
        YTrain{i} = categorical(allLabels{i});  % Convert labels to categorical format
    end
end

function layers = createModel(YTrain, features)
    % createModel - Defines the architecture of the RNN model.
    %
    % Syntax: layers = createModel(YTrain, features)
    %
    % Inputs:
    %   YTrain   - Cell array of categorical label sequences.
    %   features - Cell array of input feature sequences (not used directly).
    %
    % Outputs:
    %   layers - Array defining the layers of the RNN.

    % Model parameters
    numHiddenUnits = 100;  % Number of hidden units in the LSTM layer
    numFeatures = 6 * 12;  % Number of input features (assumed to be 6 features over 12 time steps)

    % Determine the number of unique output classes from the training labels
    allValues = [YTrain{:}];
    uniqueValues = unique(allValues);
    numUniqueValues = numel(uniqueValues);

    % Define the RNN model layers
    layers = [
        sequenceInputLayer(numFeatures)  % Input layer, with dimensions of features
        lstmLayer(numHiddenUnits, 'OutputMode', 'sequence')  % First LSTM layer
        dropoutLayer(0.2)  % Dropout layer with 20% rate
        fullyConnectedLayer(numUniqueValues)  % Fully connected layer
        softmaxLayer  % Softmax layer for classification
        classificationLayer  % Classification output layer
    ];
end

function options = createTrainingOptions
    % createTrainingOptions - Configures the training options for the RNN.
    %
    % Syntax: options = createTrainingOptions
    %
    % Outputs:
    %   options - Struct containing the training options.

    options = trainingOptions('adam', ...
        'MaxEpochs', 2500, ...
        'InitialLearnRate', 1e-3, ...  % Learning rate
        'MiniBatchSize', 32, ...
        'Shuffle', 'every-epoch', ...
        'ValidationFrequency', 50, ...
        'Verbose', false, ...
        'Plots', 'training-progress');
end

function net = trainModel(XTrain, YTrain, layers, options)
    % trainModel - Trains the RNN model using the specified data, layers, and options.
    %
    % Syntax: net = trainModel(XTrain, YTrain, layers, options)
    %
    % Inputs:
    %   XTrain  - Cell array of input feature sequences.
    %   YTrain  - Cell array of categorical label sequences.
    %   layers  - Array defining the layers of the RNN.
    %   options - Struct containing the training options.
    %
    % Outputs:
    %   net - The trained recurrent neural network model.

    % Display the number of datasets for training
    [~, x] = size(XTrain);
    disp(x + " DataSets for Training");

    % Check for matching sizes between input features and labels
    for i = 1:x
        [~, z] = size(XTrain{i});
        [~, y] = size(YTrain{i});

        if z ~= y
            disp("Mismatch at sequence " + i);
            disp("XTrain sequence " + i + " has size " + z);
            disp("YTrain sequence " + i + " has size " + y);
        end
    end

    % Train the model using the specified layers and options
    net = trainNetwork(XTrain, YTrain, layers, options);

    % After training the RNN model
    %exportTrainedModel(net, 'models/trainedRNNModel.mat');

end
