function [allData, scenario, sensor] = SwervingScenario(net)
    % SwervingScenario - Simulates a driving scenario and visualizes risk levels.
    % This function simulates the "Swerving" driving scenario and overlays risk visualization.
    % Args:
    %   net (network): The trained neural network used for risk assessment.
    % Returns:
    %   allData (struct): Sensor data including object detections, point clouds, etc.
    %   scenario (drivingScenario): The drivingScenario object.
    %   sensor (lidarPointCloudGenerator): The LiDAR sensor used in the scenario.

    % Create the driving scenario and the ego vehicle
    [scenario, egoVehicle] = createDrivingScenario();
  
    % Track previous handles for persistent variables like text or patches
    previousHandles = struct();

    % Create the sensors used in the scenario
    sensor = createSensor(scenario);

    RiskArray = testRNN(net,'SwervingData.mat');
    
    % Initial plot of the scenario
    plot(scenario);
    
    % Convert the categorical RiskArray into numeric format
    cellArray = cellstr(RiskArray);
    numericRiskArray = str2double(cellArray);

    % Initialize storage for sensor data and scenario information
    allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, 'LaneDetections', {}, 'PointClouds', {}, 'INSMeasurements', {});
    running = true;
    riskIndex = 1;
    timecount = 0;

    % Main loop to simulate the scenario and update the visualization
    textHandles = struct('Pedestrian', [], 'Ego', []);

    while running
        timecount = timecount + 1;

        % Generate the target poses of all actors relative to the ego vehicle
        poses = targetPoses(egoVehicle);
        time = scenario.SimulationTime;

        % Generate detections from the sensor
        laneDetections = [];
        objectDetections = [];
        insMeas = [];
        if sensor.HasRoadsInputPort
            rdmesh = roadMesh(egoVehicle, min(500, sensor.MaxRange));
            [ptClouds, isValidPointCloudTime] = sensor(poses, rdmesh, time);
        else
            [ptClouds, isValidPointCloudTime] = sensor(poses, time);
        end

        % Store detection data if valid
        if isValidPointCloudTime
            allData(end + 1) = struct( ...
                'Time', scenario.SimulationTime, ...
                'ActorPoses', actorPoses(scenario), ...
                'ObjectDetections', {objectDetections}, ...
                'LaneDetections', {laneDetections}, ...
                'PointClouds', {ptClouds}, ...
                'INSMeasurements', {insMeas});
        end

        % Update the risk visualization
        if riskIndex <= length(numericRiskArray)
            currentRisk = numericRiskArray(riskIndex);
            if mod(timecount, 10) == 0
                disp("The current Risk: " + currentRisk);
                % Update risk overlay
                previousHandles = riskOverlay(currentRisk, previousHandles);
                riskIndex = riskIndex + 1;
            end
        end

        % Set camera position and view for a bird's-eye (top-down) view
        camPos = egoVehicle.Position + [0 0 50];  % Directly above the ego vehicle (50 units above)
        camTarget = egoVehicle.Position;  % Focus on the ego vehicle
        camva(60);  % Field of view (can be adjusted as needed)
        campos(camPos);  % Set the camera position directly above
        camtarget(camTarget);  % Set the camera target to the ego vehicle

        % Update text labels for actors
        if isempty(textHandles.Pedestrian) % Initialize text labels
            textHandles.Pedestrian = text(36, 2, 1, 'Vehicle', 'FontSize', 8, 'Color', 'red');
            textHandles.Ego = text(10, -1, 1, 'egoVehicle', 'FontSize', 8, 'Color', [1, 0.5, 0]); % Orange
        else % Update text label positions
            pedPos = scenario.Actors(2).Position; % Position of the pedestrian
            egoPos = egoVehicle.Position;
            set(textHandles.Pedestrian, 'Position', [pedPos(1), pedPos(2) + 1.5, 0.5]);
            set(textHandles.Ego, 'Position', [egoPos(1), egoPos(2) - 2, 0.5]);
        end

        % Advance the scenario one time step; exit if scenario is complete
        running = advance(scenario);

        % Pause to sync visualization with the scenario simulation
        pause(0.1); % Adjust to match simulation time step
    end

    % Restart the scenario and release the sensor for reuse
    restart(scenario);
    release(sensor);
end

%%%%%%%%%%%%%%%%%%%%
% Helper functions % 
%%%%%%%%%%%%%%%%%%%%

function color = riskToColor(risk)
    % Convert risk level to a specific color based on discrete steps (0 to 1)
    % Green for low risk, Orange for mid-range, and Red for high risk

    if risk == 0
        color = [0, 1, 0]; % Green
    elseif risk <= 0.1
        color = [0.1, 1, 0]; % Light green
    elseif risk <= 0.2
        color = [0.3, 1, 0]; % Green-yellow
    elseif risk <= 0.3
        color = [0.5, 1, 0]; % Yellowish-green
    elseif risk <= 0.4
        color = [0.8, 1, 0]; % Yellow-green
    elseif risk <= 0.5
        color = [1, 1, 0]; % Yellow (middle)
    elseif risk <= 0.6
        color = [1, 0.8, 0]; % Yellow-orange
    elseif risk <= 0.7
        color = [1, 0.5, 0]; % Orange
    elseif risk <= 0.8
        color = [1, 0.3, 0]; % Darker orange
    elseif risk <= 0.9
        color = [1, 0.1, 0]; % Orange-red
    elseif risk == 1
        color = [1, 0, 0]; % Red
    else
        color = [0, 1, 0]; % Default to green for any unexpected value
    end
end


function previousHandles = riskOverlay(currentRisk, previousHandles)
    % Overlay risk visualization based on risk level
    if isfield(previousHandles, 'classificationText')
        delete(previousHandles.classificationText);
    end
    if isfield(previousHandles, 'riskText')
        delete(previousHandles.riskText);
    end

    color = riskToColor(currentRisk);
    patch([-20 50 50 -20], [-20 -20 20 20], [-0.5 -0.5 -0.5 -0.5], color, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

    classificationText = text(35, -12, 'Classification', 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', 'FontSize', 12, 'Color', 'k');
    riskText = text(27, -16, "Risk: " + num2str((currentRisk * 100)) + "%", ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
        'FontSize', 10, 'Color', 'k');

    previousHandles.classificationText = classificationText;
    previousHandles.riskText = riskText;
end

function sensor = createSensor(scenario)
    % Create and return the sensor object for the scenario
    profiles = actorProfiles(scenario);
    sensor = lidarPointCloudGenerator('SensorIndex', 1, ...
        'SensorLocation', [0.95 0], ...
        'ActorProfiles', profiles);
end

function [scenario, egoVehicle] = createDrivingScenario
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 1.1 0;
    49.3 1.4 0];
laneSpecification = lanespec(2);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Road');

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [0.6 -1 0], ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'Car');
waypoints = [0.6 -1 0;
    45.2 -0.5 0];
speed = [15;15];
trajectory(egoVehicle, waypoints, speed);

% Add the non-ego actors
car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [46.1 3.3 0], ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'Car1');
waypoints = [46.1 3.3 0;
    35.8 2.1 0;
    33.1 0.8 0;
    29.4 0 0;
    27.7 1.1 0;
    24.6 2.6 0;
    19.8 2.8 0;
    15.6 3.4 0;
    3.2 3.2 0];
speed = [30;30;30;30;30;30;30;30;30];
trajectory(car1, waypoints, speed);


 
end
