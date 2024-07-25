function Main

[size,data] = loadAllData("C:\Users\jakub\OneDrive\Dokumente\MATLAB\AV-Classifier\SensorData\2 Actors");

% data = loadAllData("C:\Users\jakub\OneDrive\Dokumente\MATLAB\AV-Classifier\SensorData\3 Actors");
% 
% data = loadAllData("C:\Users\jakub\OneDrive\Dokumente\MATLAB\AV-Classifier\SensorData\4 Actors");
% 

labels = createLabels(2,size);
    netWrapper(data,labels);


end

function netWrapper(data,labels)
    try
            net = createRNN(data,labels);
             disp(net);
    catch
        netWrapper(data,labels);
        
    end
       




end




function [size,allData] = loadAllData(folderPath)
 matFiles = dir(fullfile(folderPath, '*.mat'));
[~, sortedIdx] = sort({matFiles.name});
matFiles = matFiles(sortedIdx);
size = length(matFiles);
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
    
    % Store the data in the cell arrayclc
    dataCellArray{i} = dataStruct;

        %disp(dataCellArray{i});
         fields = fieldnames(dataCellArray{i});
    
    % Assuming there is only one field per struct, get the first field name
    filenameField = fields{1};
    allData{i} = preprocessSensorData( dataCellArray{i}.(filenameField));
    
 end


end




