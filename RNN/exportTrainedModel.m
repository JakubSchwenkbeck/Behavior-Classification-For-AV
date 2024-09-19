function exportTrainedModel(net, filePath)
    % exportTrainedModel - Exports the trained RNN model to a .mat file for deployment.
    %
    % Syntax: exportTrainedModel(net, filePath)
    %
    % Inputs:
    %   net      - The trained recurrent neural network model.
    %   filePath - The full file path where the model should be saved (e.g., 'trainedRNNModel.mat').
    %
    % Example:
    %   exportTrainedModel(net, 'models/trainedRNNModel.mat');
    
    if nargin < 2
        filePath = 'trainedRNNModel.mat';  % Default file name if not specified
    end
    
    try
        % Save the trained network model to a .mat file
        save(filePath, 'net');
        disp(['Model saved successfully to ', filePath]);
    catch ME
        disp('Error saving the model:');
        disp(ME.message);
    end
end
