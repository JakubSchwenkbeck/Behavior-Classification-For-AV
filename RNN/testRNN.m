function predictedLabels = testRNN(TrainedNet,filename)

folderPath ="C:\Users\jakub\OneDrive\Dokumente\MATLAB\AV-Classifier";
 filenameWithoutExtension = strrep(filename, '.mat', '');
filePath = fullfile(folderPath, filename);

dataStruct = load(filePath);

data = preprocessSensorData(dataStruct.(filenameWithoutExtension));


predictedLabels = classify(TrainedNet, transpose(data));

disp(predictedLabels)

end