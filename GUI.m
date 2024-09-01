function GUI
    % GUI - Creates a graphical user interface for the Main function.
    % 
    % This GUI allows the user to load data, train a model, and visualize
    % the results using the buttons provided.

    % Create the main figure window with a nice background color and modern look
    fig = uifigure('Name', 'AV Classifier GUI', 'Position', [100 100 600 450], ...
                   'Color', [0.95 0.95 0.95]);

    % Add a title label with improved font and alignment
    title = uilabel(fig, 'Text', 'Autonomous Vehicle Risk Classifier', ...
                    'Position', [50 370 500 50], 'FontSize', 22, ...
                    'FontWeight', 'bold', 'FontColor', [0.2 0.2 0.8], ...
                    'HorizontalAlignment', 'center');

    % Add a panel for buttons to organize layout
    panel = uipanel(fig, 'Position', [100 60 400 300], 'BackgroundColor', [1 1 1], ...
                    'BorderType', 'none', 'ShadowColor', [0.7 0.7 0.7]);

    % Button to load data with modern styling
    loadDataBtn = uibutton(panel, 'push', ...
        'Text', 'Load Data', ...
        'Position', [100 220 200 40], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.2 0.6 0.8], 'FontColor', 'white', ...
        'ButtonPushedFcn', @(btn,event) loadDataCallback());

    % Button to train the model with modern styling
    trainModelBtn = uibutton(panel, 'push', ...
        'Text', 'Train Model', ...
        'Position', [100 160 200 40], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.2 0.8 0.4], 'FontColor', 'white', ...
        'ButtonPushedFcn', @(btn,event) trainModelCallback());

    % Button to visualize the model with modern styling
    visualizeBtn = uibutton(panel, 'push', ...
        'Text', 'Visualize Model', ...
        'Position', [100 100 200 40], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.8 0.4 0.2], 'FontColor', 'white', ...
        'ButtonPushedFcn', @(btn,event) visualizeModelCallback());

    % Button for using a pretrained model with modern styling (no callback)
    usePretrainedBtn = uibutton(panel, 'push', ...
        'Text', 'Use Pretrained Model', ...
        'Position', [100 40 200 40], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.6 0.2 0.8], 'FontColor', 'white');

    % Add a logo or image (optional, if you have an image file)
    try
       % img = uiimage(fig, 'ImageSource', 'logo.png', 'Position', [240 380 120 60]);
    catch
        % If the image isn't found, no logo will be displayed
    end

    % Callback for loading data
    function loadDataCallback()
        % Load the data by calling loadAllData from the Main function
        folderPath = uigetdir('C:\', 'Select Sensor Data Folder');
        if folderPath ~= 0
            [dataSize, allData] = loadAllData(folderPath);
            uialert(fig, ['Loaded ' num2str(dataSize) ' files from ' folderPath], 'Data Loaded');
        end
    end

    % Callback for training the model
    function trainModelCallback()
        % Load data first if not already loaded
        if ~exist('allData', 'var') || isempty(allData)
            uialert(fig, 'Please load data before training the model.', 'Error');
            return;
        end
        labels = createLabels(2, length(allData));
        net = createRNN(allData, labels);
        uialert(fig, 'Model training completed.', 'Training Done');
    end

    % Callback for visualizing the model
    function visualizeModelCallback()
        % Load test data and visualize the model results
        filename = "VisualData.mat";
        if ~exist('net', 'var')
            uialert(fig, 'Please train the model before visualizing.', 'Error');
            return;
        end
        RiskArray = testRNN(net, filename);
        Visualization(RiskArray);
    end
end
