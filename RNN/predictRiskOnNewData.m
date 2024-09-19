function predictedLabels = predictRiskOnNewData(net, XNew)
    % predictRiskOnNewData - Predicts the risk classifications for new sequences using the trained RNN.
    %
    % Syntax: predictedLabels = predictRiskOnNewData(net, XNew)
    %
    % Inputs:
    %   net  - The trained RNN model.
    %   XNew - Cell array of new input feature sequences to predict.
    %
    % Outputs:
    %   predictedLabels - Cell array of predicted labels for each input sequence.
    
    % Initialize array to hold predictions
    predictedLabels = cell(size(XNew));
    
    % Loop through each sequence in XNew
    for i = 1:length(XNew)
        % Predict the labels for each sequence using the trained model
        predictedLabels{i} = classify(net, XNew{i}');
    end
    
    % Display predictions
    disp('Predictions for the new data:');
    disp(predictedLabels);
end
