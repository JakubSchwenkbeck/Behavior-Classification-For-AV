
function processedData = preprocessSensorData(sensorData)
    [pos,vel,yaw,numtimesteps] = extractFeatures(sensorData);
      [pos,vel,yaw]= missingData(pos,vel,yaw);
       [pos,vel,yaw]= noiseReduction(pos,vel,yaw);
    processedData = intoSingleMatrix(pos,vel,yaw,numtimesteps);

   
end


function [pos,vel,yaw] = missingData(pos,vel,yaw)

  pos = fillmissing(pos, 'linear', 1);
    vel = fillmissing(vel, 'linear', 1);
    yaw = fillmissing(yaw, 'linear', 1);


end

function  [pos,vel,yaw] = noiseReduction(pos,vel,yaw)
 %Apply a moving average filter

    windowSize = 5;
    pos = movmean(pos, windowSize, 1);
    vel = movmean(vel, windowSize, 1);
    yaw = movmean(yaw, windowSize, 1);




end

function [positions,velocities,yaw,numTimeSteps] = extractFeatures(sensorData)

 numTimeSteps = length(sensorData);
    numActors = length(sensorData(1).ActorPoses);
    disp("num actors : "+numActors);
    % Initialize matrices to store positions, velocities, and yaw
    positions = zeros(numTimeSteps, numActors, 3);
    velocities = zeros(numTimeSteps, numActors, 3);
    yaw = zeros(numTimeSteps, numActors, 3);

    % Extract data from the struct
    for t = 1:numTimeSteps
        for a = 1:numActors
            positions(t, a, :) = sensorData(t).ActorPoses(a).Position;
            velocities(t, a, :) = sensorData(t).ActorPoses(a).Velocity;
            yaw(t, a, :) = sensorData(t).ActorPoses(a).Yaw;
        end
    end
end






function features = intoSingleMatrix(pos,vel,yaw,numTimeSteps)
   
% Compute speed from velocity
speeds = sqrt(sum(vel.^2, 3));

% Combine all features into a single matrix
features = [reshape(pos, numTimeSteps, []), reshape(vel, numTimeSteps, []), reshape(yaw, numTimeSteps, []), speeds];
%disp(pos)
%disp(reshape(pos, numTimeSteps, []))
end
