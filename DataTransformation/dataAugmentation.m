function augmentedData = DataAugmentation(data, numAugmentations)
    % DataAugmentation - Perform data augmentation on sensor data
    %
    % This function takes the original sensor data and applies a series of
    % augmentation techniques such as random noise addition, scaling, and rotation
    % to generate additional training data. This helps in improving the robustness
    % of machine learning models.
    %
    % Inputs:
    %   data            - The original sensor data (cell array or matrix).
    %   numAugmentations - The number of augmented samples to generate per original sample.
    %
    % Outputs:
    %   augmentedData   - A cell array containing the augmented data.
    %
    % Example:
    %   augmentedData = DataAugmentation(originalData, 5);
    %   This generates 5 augmented versions for each original sample.
    
    % Initialize the cell array to hold the augmented data
    dataSize = numel(data);
    augmentedData = cell(dataSize * numAugmentations, 1);
    
    % Loop through each data sample and apply augmentations
    for i = 1:dataSize
        originalSample = data{i};
        
        for j = 1:numAugmentations
            % Apply random noise
            noisySample = addNoise(originalSample);
            
            % Apply random scaling
            scaledSample = scaleData(noisySample);
            
            % Apply random rotation
            rotatedSample = rotateData(scaledSample);
            
            % Store the augmented data
            augmentedData{(i-1) * numAugmentations + j} = rotatedSample;
        end
    end
end

function noisySample = addNoise(sample)
    % addNoise - Add random Gaussian noise to the sample
    %
    % This function adds random Gaussian noise to each element of the sample.
    %
    % Inputs:
    %   sample - The original data sample.
    %
    % Outputs:
    %   noisySample - The data sample with added noise.
    
    noiseLevel = 0.01; % Adjust the noise level as needed
    noisySample = sample + noiseLevel * randn(size(sample));
end

function scaledSample = scaleData(sample)
    % scaleData - Apply random scaling to the sample
    %
    % This function applies random scaling to the sample to simulate variations
    % in sensor readings due to changes in distance or perspective.
    %
    % Inputs:
    %   sample - The original data sample.
    %
    % Outputs:
    %   scaledSample - The data sample after scaling.
    
    scalingFactor = 0.9 + 0.2 * rand(); % Scale between 0.9 and 1.1
    scaledSample = sample * scalingFactor;
end

function rotatedSample = rotateData(sample)
    % rotateData - Apply random rotation to the sample
    %
    % This function applies a random rotation to the sample to simulate different
    % orientations of objects or perspectives in the sensor data.
    %
    % Inputs:
    %   sample - The original data sample.
    %
    % Outputs:
    %   rotatedSample - The data sample after rotation.
    
    rotationAngle = rand() * 2 * pi; % Random rotation between 0 and 2*pi radians
    rotationMatrix = [cos(rotationAngle), -sin(rotationAngle); sin(rotationAngle), cos(rotationAngle)];
    
    % Assuming the sample data is in a 2D format [x, y] for each point
    if size(sample, 2) == 2
        rotatedSample = (rotationMatrix * sample')';
    else
        rotatedSample = sample; % No rotation applied if data is not 2D
    end
    
end
