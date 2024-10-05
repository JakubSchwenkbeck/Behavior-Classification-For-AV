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

    % Create the driving scenario and the ego vehicle with pedestrians
    [scenario, egoVehicle,pedestrian,pedestrian1] = createDrivingScenario();

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
% Convert categorical array to cell array of character vectors
cellArray = cellstr(RiskArray);

% Convert the cell array of strings to a numeric array
numericRiskArray = str2double(cellArray);

    % Initialize storage for sensor data and scenario information
    allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, ...
                     'LaneDetections', {}, 'PointClouds', {}, 'INSMeasurements', {});
    running = true;
    riskIndex = 1;

    % Main loop to simulate the scenario and update the visualization
    % Initialize handle arrays
circleHandles = [];
    textHandles = struct('Ped1', [], 'Ped2', [], 'Ego', []);

timecount = 0;

% Loop to process each time step
while running
    timecount = timecount +1;
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
        if mod(timecount, 9) == 0
        disp(" The current Risk : " + currentRisk)
        % Update existing circles or create new ones
        for idx = 1:numel(circleHandles)
            if isvalid(circleHandles(idx))
                delete(circleHandles(idx));
            end
        end
     
       
        riskIndex = riskIndex + 1;

        end
                        previousHandles = riskOverlay(currentRisk, previousHandles);

    end
    
    % Set camera position and target for a 3D view from the side (left behind the car)
camPos = egoVehicle.Position + [-20 -5 10];  % Camera is 15 units behind, 5 units to the left, and 5 units above the car
camTarget = egoVehicle.Position + [10 0 0]; % Camera looks 10 units ahead of the car
camva(60); % Field of view (adjust as necessary)
campos(camPos); % Set camera position
camtarget(camTarget); % Set where the camera is looking

      
        % Update the positions of the text labels to follow their respective actors
        if isempty(textHandles.Ped1) % If labels haven't been initialized, create them
            textHandles.Ped1 = text(12, 10, 1, 'Ped1', 'FontSize', 8, 'Color', 'blue');
            textHandles.Ped2 = text(44, 4, 1, 'Ped2', 'FontSize', 8, 'Color', 'red');
textHandles.Ego = text(10, -1, 1, 'egoVehicle', 'FontSize', 8, 'Color', [1, 0.5, 0]); % Orange color using RGB triplet

        else % Update their positions
            ped1Pos = pedestrian.Position; % Pedestrian 1 position
            ped2Pos = pedestrian1.Position; % Pedestrian 2 position
            egoPos = egoVehicle.Position; % Ego vehicle position

            set(textHandles.Ped1, 'Position', [ped1Pos(1), ped1Pos(2)+3.5, 0.5]);
            set(textHandles.Ped2, 'Position', [ped2Pos(1), ped2Pos(2)+3.5, 0.5]);
            set(textHandles.Ego, 'Position', [egoPos(1), egoPos(2)-2, 0.5]);
        end

    % Advance the scenario one time step; exit if scenario is complete
    running = advance(scenario);

    % Pause to sync visualization with the scenario simulation
    pause(0.1); % Adjust to match simulation time step
end




    % Restart the scenario to reset actor positions
    restart(scenario);

    % Release the sensor object for reuse
    release(sensor);
end

%%%%%%%%%%%%%%%%%%%%
% Helper functions %
%%%%%%%%%%%%%%%%%%%%
function color = riskToColor(risk)
    % Maps risk level to color
    % Risk levels: 0 = No risk, 0.3 = Low risk, 0.5 = Moderate risk, 0.7 = High risk, 1 = Very high risk
 % Refined color selection based on risk level (continuous gradient)
if risk >= 0.6
    color = [1, (1 - risk) / 0.3, 0];  % Gradient from orange to red
elseif risk >= 0.5
    color = [1, (risk - 0.4) / 0.2, 0]; % Gradient from yellow to orange
elseif risk >= 0.2
    color = [1, 1, (risk - 0.2) / 0.2]; % Gradient from green to yellow
else
    color = [0, 1, 0]; % Pure green for low risk
end

end
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
    color = riskToColor(currentRisk);
    % Create the overlay patch
    patch([-20 50 50 -20], [-20 -20 20 20], color, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

    % Add label for classification in the center of the overlay
    classificationText = text(35, -12, 'Classification', 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', 'FontSize', 12, 'Color', 'k');

    % Add label with the classification risk level
    riskText = text(27, -16, " The current risk level is:" + num2str((currentRisk * 100)) + "% ", ...
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

function [scenario, egoVehicle,pedestrian,pedestrian1] = createDrivingScenario
    % createDrivingScenario - Sets up a driving scenario for simulation.
    %
    % This helper function creates a driving scenario with defined roads and 
    % actors (including pedestrians and vehicles). An ego vehicle is also 
    % added to the scenario, which will be used in the simulation.
    %
    % Returns:
    %   scenario (drivingScenario): The initialized driv ing scenario object.
    %   egoVehicle (vehicle): The ego vehicle in the scenario.

    % Create a driving scenario object
    scenario = drivingScenario;

    % Define road segments
    roadCenters = [10 0 0.1;
                   35.2 0 0.1;
                   45.6 0 0];
    road(scenario, roadCenters, 'Name', 'Road');

    % Add pedestrians
    pedestrian = actor(scenario, ...
        'ClassID', 4, ...
        'Length', 0.24, ...
        'Width', 0.45, ...
        'Height', 1.7, ...
        'Position', [12.8 10 0.1], ...
        'RCSPattern', [-8 -8; -8 -8], ...
        'Mesh', driving.scenario.pedestrianMesh, ...
        'Name', 'Pedestrian');
    waypoints = [12.8 10 0.1;
                 20.7 10.2 0.1];
    speed = [1.5; 1.5];
    trajectory(pedestrian, waypoints, speed);

    pedestrian1 = actor(scenario, ...
        'ClassID', 4, ...
        'Length', 0.24, ...
        'Width', 0.45, ...
        'Height', 1.7, ...
        'Position', [44.3 3.4 0.1], ...
        'RCSPattern', [-8 -8; -8 -8], ...
        'Mesh', driving.scenario.pedestrianMesh, ...
        'Name', 'Pedestrian1');
    waypoints = [44.3 3.9 0.1;
                 39.6 2.7 0.1];
    speed = [2; 2];
    trajectory(pedestrian1, waypoints, speed);

    % Add the ego vehicle
    egoVehicle = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [10.2 -0.1 0.1], ...
        'Mesh', driving.scenario.carMesh, ...
        'Name', 'Car');
    waypoints = [10.2 -0.1 0.1;
                 45.5 0.1 0.1];
    speed = [15; 15];
    trajectory(egoVehicle, waypoints, speed);
end
