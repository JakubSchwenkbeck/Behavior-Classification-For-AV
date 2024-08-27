function testScenarios = generateTestScenarios(numScenarios, numObjects, numTimeSteps)
    % generateTestScenarios - Generates driving scenarios with features and sophisticated risk labels for RNN training.
    %
    % This function creates synthetic driving scenarios, extracts features 
    % using LiDAR sensors, and generates risk level labels automatically based on more sophisticated rules.
    %
    % Inputs:
    %   numScenarios - Number of driving scenarios to generate (scalar).
    %   numObjects   - Number of objects (vehicles, pedestrians, etc.) in each scenario (scalar).
    %   numTimeSteps - Number of time steps in each scenario (scalar).
    %
    % Outputs:
    %   testScenarios - A cell array of size 1xnumScenarios, where each cell contains:
    %                  {features, labels}.
    %                  features: A 3D array [numObjects, numTimeSteps, numFeatures],
    %                            representing the features (e.g., distance, speed) of each object.
    %                  labels: A 2D array [numObjects, numTimeSteps],
    %                          representing the risk level labels for each object at each time step.
    %
    % Example:
    %   scenarios = generateTestScenarios(10, 5, 50);
    %   This generates 10 scenarios, each with 5 objects over 50 time steps.

    % Initialize cell array to store test scenarios
    testScenarios = cell(1, numScenarios);

    for i = 1:numScenarios
        % Create a driving scenario and ego vehicle
        [scenario, egoVehicle] = createDrivingScenario();

        % Initialize the LiDAR sensor for the scenario
        sensor = createSensor(scenario);

        % Preallocate space for features and labels
        features = zeros(numObjects, numTimeSteps, 6); % 6 features (e.g., distance, speed)
        labels = zeros(numObjects, numTimeSteps); % Risk labels

        % Run the scenario for the specified number of time steps
        for t = 1:numTimeSteps
            % Advance scenario simulation
            advance(scenario);

            % Generate point cloud data from the sensor
            ptCloud = sensor(egoVehicle);

            % Process the point cloud to extract features for each object
            for obj = 1:min(numObjects, ptCloud.Count)
                % Example features (distances, speeds)
                objPosition = ptCloud.Locations(obj, :);
                objVelocity = ptCloud.Velocities(obj, :);
                features(obj, t, 1) = objPosition(1);  % Distance (x-coordinate)
                features(obj, t, 2) = objPosition(2);  % Lateral position (y-coordinate)
                features(obj, t, 3) = norm(objVelocity); % Speed (magnitude of velocity)
                features(obj, t, 4:6) = objVelocity; % Velocity components (vx, vy, vz)

                % Calculate relative velocity with respect to ego vehicle
                egoVelocity = egoVehicle.Velocity;
                relativeVelocity = objVelocity - egoVelocity;

                % Sophisticated rule-based label generation
                distance = features(obj, t, 1);
                speed = features(obj, t, 3);
                relativeSpeed = norm(relativeVelocity);
                lateralPosition = features(obj, t, 2);

                % Evaluate risk based on distance, speed, relative speed, and lateral position
                if distance < 5 && relativeSpeed > 10
                    labels(obj, t) = 1;  % High risk - imminent collision likely
                elseif distance < 10 && speed > 5 && abs(lateralPosition) < 2
                    labels(obj, t) = 0.7;  % High risk - object in the path of the ego vehicle
                elseif distance < 15 && speed > 3 && abs(relativeSpeed) > 5
                    labels(obj, t) = 0.5;  % Moderate risk - object moving unpredictably
                elseif distance < 20 && abs(lateralPosition) < 5
                    labels(obj, t) = 0.3;  % Low risk - object is nearby but not directly in path
                else
                    labels(obj, t) = 0;  % No significant risk
                end
            end
        end

        % Store the features and labels for the current scenario
        testScenarios{i} = {features, labels};
    end
end
