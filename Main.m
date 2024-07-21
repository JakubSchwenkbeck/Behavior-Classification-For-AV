function Main(AEBSensor)
 load('AEBSensor.mat', 'AEBSensor');
sensorData = AEBSensor;

data = loadAllData("C:\Users\jakub\OneDrive\Dokumente\MATLAB\AV-Classifier\SensorData");
labels = loadAllLabels;
    
net = createRNN(data,labels);
disp(net);



end

function allData = loadAllData(folderPath)
 matFiles = dir(fullfile(folderPath, '*.mat'));
[~, sortedIdx] = sort({matFiles.name});
matFiles = matFiles(sortedIdx);
% Initialize a cell array to hold the data from each .mat file
dataCellArray = cell(length(matFiles), 1);
allData =  cell(length(matFiles), 1);
% Loop through each file and load the data
for i = 1:length(matFiles)
    % Construct the full file path
    filePath = fullfile(folderPath, matFiles(i).name);
    filenameWithoutExtension = strrep(matFiles(i).name, '.mat', '');
    % Load the .mat file
    dataStruct = load(filePath);
    
    % Store the data in the cell array
    dataCellArray{i} = dataStruct;

        disp(dataCellArray{i});
    allData{i} = preprocessSensorData( dataCellArray{i}.(filenameWithoutExtension));
    
  end


end
function allLabels = loadAllLabels()
labelsCellArray = cell(2, 1);
label2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.4,0.5,0.55,0.6,0.7,0.8,0.9,0.9,1,1];
label1  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.12,0.13,0.14,0.15,0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,6,0.6,0.6,0.6,0.6,0.75,0.75,0.75,0.75,0.75,0.86,0.86,0.86,0.86,0.86,0.8,0.8,0.7]
allLabels{1} = categorical(label1);
allLabels{2} = categorical(label2);

end

