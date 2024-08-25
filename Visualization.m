function [allData, scenario, sensor] = TestScenarioForVisualization(RiskArray)
    % TestScenarioForVisualization - Returns sensor detections and includes
    % a visualization overlay that represents risk levels.

    % Create the drivingScenario object and ego car
    [scenario, egoVehicle] = createDrivingScenario();

    % Create all the sensors
    sensor = createSensor(scenario);

    % Prepare the figure for visualization
    figure('Name', 'Risk Visualization', 'NumberTitle', 'off');
    hold on;

    % Plot the scenario for the first time
    plot(scenario);

    % Map categorical values in RiskArray to numeric values
    riskLevels = categories(RiskArray); % Get the unique categories
    numericRiskArray = zeros(size(RiskArray)); % Initialize numeric array

    % Define a mapping from categorical levels to numeric values (0 to 1)
    for i = 1:length(riskLevels)
        % Assume that riskLevels are ordered from low to high risk
        numericRiskArray(RiskArray == riskLevels{i}) = (i-1) / (length(riskLevels) - 1);
    end

    % Loop to update scenario and visualization
    allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, 'LaneDetections', {}, 'PointClouds', {}, 'INSMeasurements', {});
    running = true;
    riskIndex = 1;
    
    while running
        % Generate the target poses of all actors relative to the ego vehicle
        poses = targetPoses(egoVehicle);
        time  = scenario.SimulationTime;

        % Generate detections for the sensor
        laneDetections = [];
        objectDetections = [];
        insMeas = [];
        if sensor.HasRoadsInputPort
            rdmesh = roadMesh(egoVehicle,min(500,sensor.MaxRange));
            [ptClouds, isValidPointCloudTime] = sensor(poses, rdmesh, time);
        else
            [ptClouds, isValidPointCloudTime] = sensor(poses, time);
        end

        % Aggregate all detections into a structure for later use
        if isValidPointCloudTime
            allData(end + 1) = struct( ...
                'Time',       scenario.SimulationTime, ...
                'ActorPoses', actorPoses(scenario), ...
                'ObjectDetections', {objectDetections}, ...
                'LaneDetections', {laneDetections}, ...
                'PointClouds',   {ptClouds}, ...
                'INSMeasurements',   {insMeas});
        end

        % Advance the scenario one time step and exit the loop if the scenario is complete
        running = advance(scenario);

        % Update the risk visualization
        if riskIndex <= length(numericRiskArray)
            currentRisk = numericRiskArray(riskIndex);
            color = [1-currentRisk, currentRisk, 0]; % Green to Red gradient
            riskOverlay(color);
            riskIndex = riskIndex + 1;
        end

        % Pause to sync visualization with the scenario simulation
        pause(0.1); % Adjust to match simulation time step
    end

    % Restart the driving scenario to return the actors to their initial positions.
    restart(scenario);

    % Release the sensor object so it can be used again.
    release(sensor);
end

%%%%%%%%%%%%%%%%%%%%
% Helper functions %
%%%%%%%%%%%%%%%%%%%%

function riskOverlay(color)
    % riskOverlay Creates a rectangular patch as a risk overlay with specified color
    patch([-5 5 5 -5], [-5 -5 5 5], color, 'FaceAlpha', 0.2, 'EdgeColor', 'none');
end

function sensor = createSensor(scenario)
    % createSensors Returns all sensor objects to generate detections

    % Assign into each sensor the physical and radar profiles for all actors
    profiles = actorProfiles(scenario);
    sensor = lidarPointCloudGenerator('SensorIndex', 1, ...
        'SensorLocation', [0.95 0], ...
        'EgoVehicleActorID', 3, ...
        'ActorProfiles', profiles);
end

function [scenario, egoVehicle] = createDrivingScenario
    % createDrivingScenario Returns the drivingScenario defined in the Designer

    % Construct a drivingScenario object.
    scenario = drivingScenario;

    % Add all road segments
    roadCenters = [10 0 0;
        35.2 0 0;
        45.6 0 0];
    road(scenario, roadCenters, 'Name', 'Road');

    % Add the actors
    pedestrian = actor(scenario, ...
        'ClassID', 4, ...
        'Length', 0.24, ...
        'Width', 0.45, ...
        'Height', 1.7, ...
        'Position', [12.8 10 0], ...
        'RCSPattern', [-8 -8;-8 -8], ...
        'Mesh', driving.scenario.pedestrianMesh, ...
        'Name', 'Pedestrian');
    waypoints = [12.8 10 0;
        20.7 10.2 0];
    speed = [1.5;1.5];
    trajectory(pedestrian, waypoints, speed);

    pedestrian1 = actor(scenario, ...
        'ClassID', 4, ...
        'Length', 0.24, ...
        'Width', 0.45, ...
        'Height', 1.7, ...
        'Position', [44.3 4.4 0], ...
        'RCSPattern', [-8 -8;-8 -8], ...
        'Mesh', driving.scenario.pedestrianMesh, ...
        'Name', 'Pedestrian1');
    waypoints = [44.3 4.4 0;
        39.6 3.1 0];
    speed = [1.5;1.5];
    trajectory(pedestrian1, waypoints, speed);

    % Add the ego vehicle
    egoVehicle = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [10.2 -0.1 0], ...
        'Mesh', driving.scenario.carMesh, ...
        'Name', 'Car');
    waypoints = [10.2 -0.1 0;
        45.5 0.1 0];
    speed = [15;15];
    trajectory(egoVehicle, waypoints, speed);
end
