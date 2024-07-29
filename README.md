As part of the Matlab Challange, I chose to write a Project to classify Object behaviour and the risk it imposes on autonomous driving Cars.

After working in the Automotive Industry with Matlab, I really wanted to keep on using the Mathworks products and get better at various field within Software engenieering.


------Workflow:------

Data:
- Firstly, I started out by creating simple Scenes in the Scenario Simulater from the ADT (Autonomous Driving Toolbox). After experimenting with the Designer, I then extracted my first Signal Data
- After understanding the structure of the Signal Data provided, I wrote functions which preprocess the data for the learning model. Those functions are for example simple Noise Reduction, filling missing values or concatenating them into  a single Matrix

Model:
- With the Data in hand, I started thinking about which Learning Model would fit best for the kind of strucutre we have from the Signal Data
- I chose an (for now "simple") RNN which fits best with the data being structured by TimeSteps
- with the function createRNN, I handled the creation of traings-data and labels,aswell as the building and training of the RNN itself

  RNN:
  - sequenceInputLayer(numFeatures) % input layer, dimensions of features
  - lstmLayer(numHiddenUnits, 'OutputMode', 'last') % LSTM-layer
  - fullyConnectedLayer(numClasses) % fully connected layer
  - softmaxLayer % Softmax-layer for classification
  - classificationLayer]; % classification layer

  Training-options:
   ('adam', ...
    'MaxEpochs', 20, ...
    'MiniBatchSize', 20, ...
    'Verbose', 1, ...
    'Plots', 'training-progress')
  
Training and Data:
- After learning more about the RNN and how the Data is processed, I started a structured approach to retrieving Data and labelling them correctly
- By new Design, there is now no problem in switching between different number of actors for the single RNN
- With the first 40 simple scenarios, the RNN's accuracy lies between 95% and 99%
  

