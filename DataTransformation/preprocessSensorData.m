%% Preprocessing Sensor Data

function processedData = preprocessSensorData(sensorData)
    % Preprocesses the sensor data from an autonomous driving simulation.
    %
    % This function takes raw sensor data and applies a series of preprocessing
    % steps, including feature extraction, handling missing data, noise reduction,
    % and combining features into a single matrix. The resulting processed data
    % is formatted for use in training and testing an RNN model.
    %
    % Args:
    %   sensorData (struct): Raw sensor data from the simulation, containing
    %   positional, velocity, and other dynamic information of various actors.
    %
    % Returns:
    %   processedData (matrix): A matrix containing preprocessed features,
    %   ready for input into a learning model.
    
    % Extract relevant features from the sensor data
    [positions, velocities, speeds, yaws, angularVelocities, actorIDs, numTimeSteps] = extractFeatures(sensorData);
    
    % Handle missing data in the extracted features
    [positions, velocities, speeds, yaws, angularVelocities] = missingData(positions, velocities, speeds, yaws, angularVelocities);
    
    % Reduce noise in the extracted features
    [positions, velocities, speeds, yaws, angularVelocities] = noiseReduction(positions, velocities, speeds, yaws, angularVelocities);
    
    % Combine all features into a single matrix for further processing
    processedData = intoSingleMatrix(positions, velocities, speeds, yaws, angularVelocities, actorIDs, numTimeSteps);

    % Adjust the matrix to ensure consistent column dimensions
    processedData = adjustCols(processedData);
end

function [positions, velocities, speeds, yaws, angularVelocities] = missingData(positions, velocities, speeds, yaws, angularVelocities)
    % Handles missing data by filling gaps using linear interpolation.
    %
    % This function fills missing data points in the sensor data using linear
    % interpolation along each column.
    %
    % Args:
    %   positions, velocities, speeds, yaws, angularVelocities: Feature matrices
    %   with potential missing values.
    %
    % Returns:
    %   positions, velocities, speeds, yaws, angularVelocities: Feature matrices
    %   with missing values filled.

    positions = fillmissing(positions, 'linear', 1);
    velocities = fillmissing(velocities, 'linear', 1);
    speeds = fillmissing(speeds, 'linear', 1);
    yaws = fillmissing(yaws, 'linear', 1);
    angularVelocities = fillmissing(angularVelocities, 'linear', 1);
end

function [positions, velocities, speeds, yaws, angularVelocities] = noiseReduction(positions, velocities, speeds, yaws, angularVelocities)
    % Reduces noise in the sensor data using a moving average filter.
    %
    % This function smooths the extracted features by applying a moving average
    % filter to reduce the impact of noise in the data.
    %
    % Args:
    %   positions, velocities, speeds, yaws, angularVelocities: Feature matrices
    %   with potential noise.
    %
    % Returns:
    %   positions, velocities, speeds, yaws, angularVelocities: Smoothed feature
    %   matrices.

    windowSize = 5; % Define the window size for the moving average filter
    positions = movmean(positions, windowSize, 1);
    velocities = movmean(velocities, windowSize, 1);
    speeds = movmean(speeds, windowSize, 1);
    yaws = movmean(yaws, windowSize, 1);
    angularVelocities = movmean(angularVelocities, windowSize, 1);
end

function [positions, velocities, speeds, yaws, angularVelocities, actorIDs, numTimeSteps] = extractFeatures(sensorData)
    % Extracts and organizes key features from the sensor data.
    %
    % This function retrieves and structures the essential features from the 
    % simulation data, including positions, velocities, speeds, yaws, angular 
    % velocities, actor IDs, and the number of timesteps.
    %
    % Args:
    %   sensorData (struct): Raw sensor data from the simulation.
    %
    % Returns:
    %   positions (matrix): Positions of actors over time.
    %   velocities (matrix): Velocities of actors over time.
    %   speeds (matrix): Speeds of actors over time.
    %   yaws (matrix): Yaw angles of actors over time.
    %   angularVelocities (matrix): Angular velocities of actors over time.
    %   actorIDs (matrix): IDs of actors in the simulation.
    %   numTimeSteps (int): Number of time steps in the simulation data.

    numTimeSteps = length(sensorData);
    numActors = length(sensorData(1).ActorPoses);

    % Initialize matrices to store features for all actors over all timesteps
    positions = zeros(numTimeSteps, numActors, 3);
    velocities = zeros(numTimeSteps, numActors, 3);
    speeds = zeros(numTimeSteps, numActors, 1);
    yaws = zeros(numTimeSteps, numActors, 1);
    angularVelocities = zeros(numTimeSteps, numActors, 3);
    actorIDs = zeros(numTimeSteps, numActors, 1);

    % Loop through each timestep and each actor to extract features
    for t = 1:numTimeSteps
        for a = 1:numActors
            positions(t, a, :) = sensorData(t).ActorPoses(a).Position;
            velocities(t, a, :) = sensorData(t).ActorPoses(a).Velocity;
            speeds(t, a, :) = norm(sensorData(t).ActorPoses(a).Velocity);
            yaws(t, a, :) = sensorData(t).ActorPoses(a).Yaw;
            angularVelocities(t, a, :) = sensorData(t).ActorPoses(a).AngularVelocity;
            actorIDs(t, a, :) = sensorData(t).ActorPoses(a).ActorID;
        end
    end
end

function features = intoSingleMatrix(positions, velocities, speeds, yaws, angularVelocities, actorIDs, numTimeSteps)
    % Combines extracted features into a single matrix.
    %
    % This function reshapes and concatenates the extracted features into a 
    % single matrix format suitable for input into the learning model.
    %
    % Args:
    %   positions, velocities, speeds, yaws, angularVelocities, actorIDs: 
    %   Feature matrices extracted from the sensor data.
    %   numTimeSteps (int): Number of time steps in the simulation data.
    %
    % Returns:
    %   features (matrix): Combined feature matrix ready for model processing.

    features = [reshape(positions, numTimeSteps, []), ...
                reshape(velocities, numTimeSteps, []), ...
                reshape(speeds, numTimeSteps, []), ...
                reshape(yaws, numTimeSteps, []), ...
                reshape(angularVelocities, numTimeSteps, []), ...
                reshape(actorIDs, numTimeSteps, [])];
end

function result = adjustCols(matrix)
    % Adjusts the number of columns in the feature matrix to a fixed size.
    %
    % This function ensures the feature matrix has a consistent number of columns 
    % by either truncating or padding with zeros to meet the desired dimension.
    %
    % Args:
    %   matrix (matrix): Original feature matrix with varying column count.
    %
    % Returns:
    %   result (matrix): Adjusted feature matrix with a fixed number of columns.

    [rows, cols] = size(matrix);
    targetCols = 12 * 6; % Target number of columns (e.g., 6 actors with 12 features each)

    % Initialize the result matrix with zeros
    result = zeros(rows, targetCols);

    % Adjust the columns by copying or truncating the original matrix
    if cols <= targetCols
        result(:, 1:cols) = matrix; % Copy original columns if within target
    else
        result = matrix(:, 1:targetCols); % Truncate to targetCols if exceeding
    end
end
