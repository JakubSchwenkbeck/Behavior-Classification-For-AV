function [allData, scenario, sensor] = TestScenarioForVisualization(RiskArray)
    % TestScenarioForVisualization - Simulates a driving scenario and visualizes risk levels.
    %
    % This function simulates a driving scenario using a pre-defined set of roads,
    % actors (e.g., pedestrians, vehicles), and an ego vehicle equipped with sensors.
    % The function overlays a risk visualization based on the input `RiskArray`.
    % The simulation results, including sensor detections and scenario data, are 
    % stored and returned for further analysis.
    %
    % Args:
    %   RiskArray (categorical array): An array representing risk levels for each
    %   time step in the scenario. The risk levels are assumed to be ordered from
    %   low to high risk.
    %
    % Returns:
    %   allData (struct): A struct array containing sensor data, including 
    %   object detections, lane detections, point clouds, and INS measurements 
    %   for each time step.
    %   scenario (drivingScenario): The drivingScenario object that defines the 
    %   environment and actors in the simulation.
    %   sensor (lidarPointCloudGenerator): The sensor object used for generating 
    %   point cloud data in the scenario.

    % Create the driving scenario and the ego vehicle
    [scenario, egoVehicle] = createDrivingScenario();

    % previous handles keep track of persistent variables like texts in the
    % loop
    previousHandles = struct();

    % Create the sensors used in the scenario
    sensor = createSensor(scenario);

    % Prepare the figure for visualization
    figure('Name', 'Risk Visualization', 'NumberTitle', 'off');
    hold on;

    % Initial plot of the scenario
    plot(scenario);

    % Map categorical values in RiskArray to numeric values between 0 and 1
    riskLevels = categories(RiskArray); % Get unique risk categories
    numericRiskArray = zeros(size(RiskArray)); % Initialize numeric array

    % Define mapping from categorical risk levels to numeric values (0 to 1)
    for i = 1:length(riskLevels)
        % Assume risk levels are ordered from low to high risk
        numericRiskArray(RiskArray == riskLevels{i}) = (i-1) / (length(riskLevels) - 1);
    end

    % Initialize storage for sensor data and scenario information
    allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, ...
                     'LaneDetections', {}, 'PointClouds', {}, 'INSMeasurements', {});
    running = true;
    riskIndex = 1;

    % Main loop to simulate the scenario and update the visualization
    % Initialize handle arrays for pedestrian circles
circleHandles = [];

% Loop to process each time step
while running
    % Generate the target poses of all actors relative to the ego vehicle
    poses = targetPoses(egoVehicle);
    time  = scenario.SimulationTime;

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

    % Aggregate and store detection data
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

        % Update existing circles or create new ones
        for idx = 1:numel(circleHandles)
            if isvalid(circleHandles(idx))
                delete(circleHandles(idx));
            end
        end
        circleHandles = [];
        
        % Draw new circles for each pedestrian
        pedestrianPoses = getPedestrianPoses(scenario); % You need to implement this function
        
        for p = 1:size(pedestrianPoses, 1)
            pedestrianPos = pedestrianPoses(p, :);
            % Choose circle color based on risk
            color = riskToColor(currentRisk);
            
            % Draw circle on Y = 0 plane
            theta = linspace(0, 2*pi, 100);
            x = 1 * cos(theta); % Radius of the circle
            y = 1 * sin(theta); % Radius of the circle
            z = zeros(size(theta)); % Z = 0 for the plane

            % Update or create circle plot
            hold on;
            circleHandles(p) = plot3(pedestrianPos(1) + x, pedestrianPos(2) + y, 0 * z, 'Color', color, 'LineWidth', 2);
        end

        previousHandles = riskOverlay(currentRisk, previousHandles);
        riskIndex = riskIndex + 1;
    end

    % Advance the scenario one time step; exit if scenario is complete
    running = advance(scenario);

    % Pause to sync visualization with the scenario simulation
    pause(0.1); % Adjust to match simulation time step
end

function color = riskToColor(risk)
    % Maps risk level to color
    % Risk levels: 0 = No risk, 0.3 = Low risk, 0.5 = Moderate risk, 0.7 = High risk, 1 = Very high risk
    if risk >= 0.7
        color = 'r'; % Red for high risk
    elseif risk >= 0.5
        color = 'orange'; % Orange for moderate risk
    elseif risk >= 0.3
        color = 'yellow'; % Yellow for low risk
    else
        color = 'g'; % Green for no risk
    end
end
function pedestrianPoses = getPedestrianPoses(scenario)
    % getPedestrianPoses - Retrieves the positions of all pedestrians in the scenario.
    %
    % Args:
    %   scenario - The driving scenario object.
    %
    % Returns:
    %   pedestrianPoses - A matrix where each row represents a pedestrian's position [x, y].
    
    % Initialize an empty array to store pedestrian positions
    pedestrianPoses = [];
    
    % Get all actors in the scenario
    actors = scenario.Actors;
    
    % Loop through all actors
    for i = 1:length(actors)
        actor = actors(i);
        
        % Check if the actor is a pedestrian
        if isa(actor, 'matlab.driving.scenario.Pedestrian')
            % Get the actor's position
            position = actor.Position;
            
            % Append the position to the array
            pedestrianPoses = [pedestrianPoses; position];
        end
    end
end



    % Restart the scenario to reset actor positions
    restart(scenario);

    % Release the sensor object for reuse
    release(sensor);
end

%%%%%%%%%%%%%%%%%%%%
% Helper functions %
%%%%%%%%%%%%%%%%%%%%

function previousHandles =riskOverlay(currentRisk,previousHandles)
    % riskOverlay - Adds a colored overlay representing risk level.
    %
    % This helper function creates a rectangular patch over the scenario
    % visualization, with the specified color indicating the current risk
    % level. The color is semi-transparent.
    %
    % Args:
    %   currentRisk: numerical number between 0 and 1
    %   previousHandles: a struct with handles to the previous text objects

    % Delete previous text objects if they exist
    if isfield(previousHandles, 'classificationText')
        delete(previousHandles.classificationText);
    end
    if isfield(previousHandles, 'riskText')
        delete(previousHandles.riskText);
    end

    % Define the color based on the current risk level
    color = [1-currentRisk, currentRisk, 0]; % Green to Red gradient

    % Create the overlay patch
    patch([-5 5 5 -5], [-5 -5 5 5], color, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

    % Add label for classification in the center of the overlay
    classificationText = text(2, 0, 'Classification', 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', 'FontSize', 12, 'Color', 'k');

    % Add label with the classification risk level
    riskText = text(-2, 0, " The current Risk level is:" + num2str((currentRisk * 100)) + "% ", ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
        'FontSize', 10, 'Color', 'k');

    % Return handles to the new text objects
    previousHandles.classificationText = classificationText;
    previousHandles.riskText = riskText;
end


function sensor = createSensor(scenario)
    % createSensor - Creates and returns a sensor object for the scenario.
    %
    % This helper function initializes a LiDAR sensor for the ego vehicle
    % in the driving scenario. The sensor generates point cloud data, which 
    % can be used for object detection and environment perception.
    %
    % Args:
    %   scenario (drivingScenario): The driving scenario containing the actors.
    %
    % Returns:
    %   sensor (lidarPointCloudGenerator): The initialized LiDAR sensor object.

    profiles = actorProfiles(scenario);
    sensor = lidarPointCloudGenerator('SensorIndex', 1, ...
        'SensorLocation', [0.95 0], ...
        'EgoVehicleActorID', 3, ...
        'ActorProfiles', profiles);
end

function [scenario, egoVehicle] = createDrivingScenario
    % createDrivingScenario - Sets up a driving scenario for simulation.
    %
    % This helper function creates a driving scenario with defined roads and 
    % actors (including pedestrians and vehicles). An ego vehicle is also 
    % added to the scenario, which will be used in the simulation.
    %
    % Returns:
    %   scenario (drivingScenario): The initialized driving scenario object.
    %   egoVehicle (vehicle): The ego vehicle in the scenario.

    % Create a driving scenario object
    scenario = drivingScenario;

    % Define road segments
    roadCenters = [10 0 0;
                   35.2 0 0;
                   45.6 0 0];
    road(scenario, roadCenters, 'Name', 'Road');

    % Add pedestrians
    pedestrian = actor(scenario, ...
        'ClassID', 4, ...
        'Length', 0.24, ...
        'Width', 0.45, ...
        'Height', 1.7, ...
        'Position', [12.8 10 0], ...
        'RCSPattern', [-8 -8; -8 -8], ...
        'Mesh', driving.scenario.pedestrianMesh, ...
        'Name', 'Pedestrian');
    waypoints = [12.8 10 0;
                 20.7 10.2 0];
    speed = [1.5; 1.5];
    trajectory(pedestrian, waypoints, speed);

    pedestrian1 = actor(scenario, ...
        'ClassID', 4, ...
        'Length', 0.24, ...
        'Width', 0.45, ...
        'Height', 1.7, ...
        'Position', [44.3 4.4 0], ...
        'RCSPattern', [-8 -8; -8 -8], ...
        'Mesh', driving.scenario.pedestrianMesh, ...
        'Name', 'Pedestrian1');
    waypoints = [44.3 4.4 0;
                 39.6 3.1 0];
    speed = [1.5; 1.5];
    trajectory(pedestrian1, waypoints, speed);

    % Add the ego vehicle
    egoVehicle = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [10.2 -0.1 0], ...
        'Mesh', driving.scenario.carMesh, ...
        'Name', 'Car');
    waypoints = [10.2 -0.1 0;
                 45.5 0.1 0];
    speed = [15; 15];
    trajectory(egoVehicle, waypoints, speed);
end
