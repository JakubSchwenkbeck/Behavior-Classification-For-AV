%% preprocessing Sensor Data


function processedData = preprocessSensorData(sensorData)
    % handles all steps to preprocess the Data from a AD Simulation

    [positions,velocities,speeds,yaws,angularVelocities,actorIDs,numTimeSteps] = extractFeatures(sensorData);
    [positions,velocities,speeds,yaws,angularVelocities]= missingData(positions,velocities,speeds,yaws,angularVelocities);
    [positions,velocities,speeds,yaws,angularVelocities]= noiseReduction(positions,velocities,speeds,yaws,angularVelocities);
    processedData = intoSingleMatrix(positions,velocities,speeds,yaws,angularVelocities,actorIDs,numTimeSteps);

   
end




function [positions,velocities,speeds,yaws,angularVelocities] = missingData(positions,velocities,speeds,yaws,angularVelocities)
% fills missing data with the mean of the column
  positions = fillmissing(positions, 'linear', 1);
  velocities = fillmissing(velocities, 'linear', 1);
  yaws = fillmissing(yaws, 'linear', 1);
  angularVelocities = fillmissing(angularVelocities, 'linear', 1);
     speeds = fillmissing(speeds, 'linear', 1);

end

function  [positions,velocities,speeds,yaws,angularVelocities] = noiseReduction(positions,velocities,speeds,yaws,angularVelocities)
 %Apply a moving average filter to reduce data noise

    windowSize = 5;
    positions = movmean(positions, windowSize, 1);
    velocities = movmean(velocities, windowSize, 1);
    yaws = movmean(yaws, windowSize, 1);
    angularVelocities = movmean(angularVelocities, windowSize, 1);
   speeds = movmean(speeds, windowSize, 1);


end

function [positions,velocities,speeds,yaws,angularVelocities,actorIDs,numTimeSteps] = extractFeatures(sensorData)
    % extracts the main features wanted from the sensor data for more easy
    % use later on. 

    % Position is the positon on a grid of an actor to a given time
    % Velocity is a vector with speed and direction
    % Yaw is the direction an actor is facing by angles
    % angular Velocitiy is the vel with an angle
    % actorIDs identifies the actor to each value
    % numTimeSteps is the number of timesteps measured

   numTimeSteps = length(sensorData);
    numActors = length(sensorData(1).ActorPoses);

    % Initialize matrices to store features
    positions = zeros(numTimeSteps, numActors, 3);
    velocities = zeros(numTimeSteps, numActors, 3);
    yaws = zeros(numTimeSteps, numActors, 1);
    angularVelocities = zeros(numTimeSteps, numActors, 3);
    actorIDs = zeros(numActors, 1);

    % Extract data from the struct
    for t = 1:numTimeSteps
        for a = 1:numActors
            positions(t, a, :) = sensorData(t).ActorPoses(a).Position;
            velocities(t, a, :) = sensorData(t).ActorPoses(a).Velocity;
            speeds(t, a,:) = norm(sensorData(t).ActorPoses(a).Velocity);
            yaws(t, a,:) = sensorData(t).ActorPoses(a).Yaw;
            angularVelocities(t, a, :) = sensorData(t).ActorPoses(a).AngularVelocity;
            actorIDs(a) = sensorData(t).ActorPoses(a).ActorID;
        end
    end
end





function features = intoSingleMatrix(positions,velocities,speeds,yaws,angularVelocities,actorIDs,numTimeSteps)
 % concatenates the extrated Values into a single Matrix to be processed by
 % the learning model later on

% Compute speed from velocity (velocity is a vector not the speed)

% Combine all features into a single matrix

    features = [reshape(positions, numTimeSteps, []), ...
                reshape(velocities, numTimeSteps, []), ...
                reshape(speeds, numTimeSteps, []), ...
                reshape(yaws, numTimeSteps, []), ...
                reshape(angularVelocities, numTimeSteps, [])];
      actorIDMatrix = repmat(actorIDs', numTimeSteps, 1);
  
   features = [features, actorIDMatrix];

end
