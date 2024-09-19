function generateConfusionMatrix(net, XTest, YTest)
    % generateConfusionMatrix - Generates a confusion matrix for the RNN model on test data.
    %
    % Syntax: generateConfusionMatrix(net, XTest, YTest)
    %
    % Inputs:
    %   net   - The trained RNN model.
    %   XTest - Cell array of test feature sequences.
    %   YTest - Cell array of true categorical label sequences for the test set.
    %
    % Example:
    %   generateConfusionMatrix(net, XTest, YTest);
    
    % Check that the test data size matches the labels
    if length(XTest) ~= length(YTest)
        error('The number of test samples and labels must be equal.');
    end
    
    % Initialize arrays for storing true and predicted labels
    trueLabels = [];
    predictedLabels = [];
    
    % Loop through each test sample
    for i = 1:length(XTest)
        % Get the predicted labels from the RNN model
        YPred = classify(net, XTest{i}');
        
        % Store true and predicted labels
        trueLabels = [trueLabels; YTest{i}(:)];
        predictedLabels = [predictedLabels; YPred(:)];
    end
    
    % Generate the confusion matrix
    figure;
    confusionchart(trueLabels, predictedLabels);
    title('Confusion Matrix');
end
