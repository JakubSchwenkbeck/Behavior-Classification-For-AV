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
  
Training:
- After I had a running RNN which could handle a single data set, it was time to get it working with multiple data sets of different scenarios
- The data right now is only compatible with data from the same amount of actors involved, so I'm (at least now) going to follow the data structure
- After Hanlding which data will be loaded (2 Actors, 3 Actors ,...) and setting the labels for each Matrix, I changed some functions in createRNN to have it work with multiple data sets

  Creating more Scnearios and Data:
  - For further understanding and feeding the Model with data, I now started to build more Scenarios with different Actors and risk levels, aswell as classified them with categrical labels
  - The scenarios should be similar in some points but still different real situations, modelling real problems an autonomous driving Car would face in traffi
  - Later on, the RNN should be able to operate on live sensor data with a short term history buffer of sensor data
  - Therefore, not only long sequences should be tested but rather a mixture of quick scenarios, snapshots and regular traffic scenarios

After creating more and more data for the model to test, after 19 scenarios, this is the current state :
![AV-Classifier-Training from 23-07](https://github.com/user-attachments/assets/24301eb2-7270-43bc-9c55-1a3a6d647f0a)


