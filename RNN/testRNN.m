function predictedLabels = testRNN(TrainedNet, filename)
    % testRNN - Loads and preprocesses sensor data, then classifies it using a trained RNN.
    %
    % Args:
    %   TrainedNet (network): The pre-trained recurrent neural network for classification.
    %   filename (string): The name of the .mat file containing the sensor data.
    %
    % Returns:
    %   predictedLabels (categorical): The labels predicted by the RNN for the input data.
    
    % Define the folder path where the .mat file is located
    folderPath = "...\MATLAB\AV-Classifier"; % ADJUST TO YOUR PATH
    
    % Remove the .mat extension from the filename to get the variable name
    filenameWithoutExtension = strrep(filename, '.mat', '');
    
    % Construct the full file path
    filePath = fullfile(folderPath, filename);
    
    % Load the .mat file into a structure
    dataStruct = load(filePath);
    
    % Extract and preprocess the sensor data
    data = preprocessSensorData(dataStruct.(filenameWithoutExtension));
    
    % Classify the preprocessed data using the trained RNN
    predictedLabels = classify(TrainedNet, transpose(data));
    
    % Display the predicted labels
    disp(predictedLabels);
end
