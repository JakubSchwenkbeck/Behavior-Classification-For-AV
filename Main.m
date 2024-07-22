function Main(AEBSensor)

[size,data] = loadAllData("C:\Users\jakub\OneDrive\Dokumente\MATLAB\AV-Classifier\SensorData\2 Actors");

% data = loadAllData("C:\Users\jakub\OneDrive\Dokumente\MATLAB\AV-Classifier\SensorData\3 Actors");
% 
% data = loadAllData("C:\Users\jakub\OneDrive\Dokumente\MATLAB\AV-Classifier\SensorData\4 Actors");
% 

labels = loadAllLabels(2,size);
    
net = createRNN(data,labels);
disp(net);



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
    
    % Store the data in the cell array
    dataCellArray{i} = dataStruct;

        disp(dataCellArray{i});
    allData{i} = preprocessSensorData( dataCellArray{i}.(filenameWithoutExtension));
    
 end


end
function allLabels = loadAllLabels(numActor,size)

labelsCellArray = cell(size, 1);

if(numActor ==2 )
%AEB 2
label1  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.12,0.13,0.14,0.15,0.2,0.2,0.2,0.22,0.23,0.24,0.25,0.26,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,6,0.6,0.6,0.6,0.6,0.75,0.75,0.75,0.75,0.75,0.86,0.86,0.86,0.86,0.86,0.8,0.8,0.7]
%AEB 3
label2  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.1,0.1,0.11,0.12,0.12,0.13,0.14,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.16,0.17,0.2,0.205,0.21,0.2,0.22,0.23,0.24,0.25,0.26,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.3,0.3,0.25,0.25,0.22,0.2 ]

allLabels{1} = categorical(label1);
allLabels{2} = categorical(label2);

elseif(numActor == 3)


elseif(numActor == 4)


end
% AEB 1
% label2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.4,0.5,0.55,0.6,0.7,0.8,0.9,0.9,1,1];
% % AEB 2
% label1  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.12,0.13,0.14,0.15,0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,6,0.6,0.6,0.6,0.6,0.75,0.75,0.75,0.75,0.75,0.86,0.86,0.86,0.86,0.86,0.8,0.8,0.7]
% %AEB 3
% 
% label3  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.12,0.12,0.12,0.12,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.2,0.2,0.2,0.2,0.22,0.23,0.24,0.25,0.26,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.3,0.3,0.25,0.25,0.22,0.2 ]
% 
% 
% allLabels{1} = categorical(label1);
% allLabels{2} = categorical(label2);

end

