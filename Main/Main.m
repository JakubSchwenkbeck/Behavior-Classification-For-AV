function Main
    % Main function for training and testing the RNN-based risk classifier
    % for autonomous driving using LiDAR data.
    %
    % This function loads the preprocessed sensor data, generates labels, 
    % trains an RNN model, and then tests the model on a new dataset to 
    % classify the level of risk. Finally, it visualizes the risk levels.
    %
    % The process is as follows:
    %   1. Load all preprocessed sensor data from the specified directory.
    %   2. Generate labels for the data.
    %   3. Create and train an RNN using the loaded data and labels.
    %   4. Test the trained RNN on a new dataset.
    %   5. Visualize the results.
    %
    % No inputs are required for this function.

    % Load all preprocessed LiDAR sensor data
    %{
    %% UNCOMMENT FOR OWN TRAINING : ADJUST TO YOUR PATH
    [dataSize, data] = loadAllData("...MATLAB\AV-Classifier\SensorData");

    % Generate labels for the dataset (e.g., binary classification: 0 - Not Risky, 1 - Risky)
    labels = createLabels(2, dataSize); % THESE LABELS ARE TAILORED TO THE DATASET PROVIDED

    % Create and train the RNN model
    net = createRNN(data, labels);
    %}
    loadedData = load('TrainedModel.mat');
    net = loadedData.net;

    
    % Define the filename for the testing dataset
    filename = "VisualData.mat";
    
    % Test the trained RNN using the new dataset and get the risk classification
    RiskArray = testRNN(net, filename);

    % Visualize the classified risk levels
    Visualization(RiskArray);

end

function [dataSize, allData] = loadAllData(folderPath)
    % Load all .mat files containing sensor data from the specified folder.
    %
    % Args:
    %   folderPath (string): The directory path where .mat files are stored.
    %
    % Returns:
    %   dataSize (int): The number of .mat files loaded.
    %   allData (cell array): A cell array containing preprocessed sensor data from each .mat file.
    
    % Get a list of all .mat files in the specified directory
    matFiles = dir(fullfile(folderPath, '*.mat'));
    
    % Sort the files by name to ensure consistent loading order
    [~, sortedIdx] = sort({matFiles.name});
    matFiles = matFiles(sortedIdx);
    
    % Get the number of .mat files
    dataSize = length(matFiles);
    
    % Initialize a cell array to hold the preprocessed data from each .mat file
    allData = cell(dataSize, 1);
    
    % Loop through each file and load the data
    for i = 1:dataSize
        % Construct the full file path for the current .mat file
        filePath = fullfile(folderPath, matFiles(i).name);
        
        % Load the data structure from the .mat file
        dataStruct = load(filePath);
        
        % Extract the first field (assuming only one field per .mat file)
        fields = fieldnames(dataStruct);
        filenameField = fields{1};
        
        % Preprocess the sensor data and store it in the cell array
        allData{i} = preprocessSensorData(dataStruct.(filenameField));
    end
end
