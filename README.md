
# Behavior Classificator for Autonomous Vehicles

Welcome to the **Behavior Classificator for Autonomous Vehicles** project! This project is part of the **Matlab-Simulink Challenge** and focuses on classifying object behavior and assessing the risk it poses to autonomous vehicles. The project leverages MATLAB and Simulink to create a robust model for autonomous driving scenarios.

![DataVisualization](https://github.com/user-attachments/assets/cdd6de8c-3c24-4d7a-b106-c87d6dfe2f8d)

## Table of Contents
- [Overview](#overview)
- [Workflow](#workflow)
  - [Data Understanding](#data-understanding)
  - [Model](#model)
  - [RNN Setup](#rnn-setup)
  - [Training and Data](#training-and-data)
- [Results](#results)
- [Conclusion](#conclusion)
- [Getting Started](#getting-started)
- [License](#license)

## Overview

The project aims to classify the behavior of objects within autonomous driving scenarios using a Recurrent Neural Network (RNN). The goal is to understand the behavior of objects and predict their risk level, which is crucial for the safe operation of autonomous vehicles.

## Workflow

### Data Understanding

1. **Scene Creation:** Used the Scenario Designer from the Autonomous Driving Toolbox (ADT) to create initial scenes.
2. **Signal Data Extraction:** Extracted signal data from the scenes and analyzed the data structure.
3. **Preprocessing:** Developed functions to preprocess the data, including noise reduction, filling missing values, and concatenating data into a unified matrix.

### Model

1. **Model Selection:** Chose a Recurrent Neural Network (RNN) suitable for time-series data.
   - **Why RNNs?** RNNs are particularly suitable for this project because they are designed to process sequences of data, making them ideal for understanding temporal dependencies in time-series data such as the behavior of objects in autonomous driving scenarios. MATLAB's deep learning toolbox provides efficient tools for designing, training, and evaluating RNNs, making it a strong choice for this application.

### RNN Setup

1. **Revised RNN:**

```matlab
layers = [
    sequenceInputLayer(numFeatures) % Input layer, dimensions of features
    lstmLayer(numHiddenUnits, 'OutputMode', 'sequence') % LSTM layer
    dropoutLayer(0.2) % Dropout layer with 20% rate
    fullyConnectedLayer(numUniqueValues) % Fully connected layer
    softmaxLayer % Softmax layer for classification
    classificationLayer]; % Classification layer
end

options = trainingOptions('adam', ...
    'MaxEpochs', 2500, ...
    'InitialLearnRate', 1e-3, ... % Adjusting learn rate for better convergence
    'MiniBatchSize', 32, ...
    'Shuffle', 'every-epoch', ...
    'ValidationFrequency', 50, ...
    'Verbose', false, ...
    'Plots', 'training-progress');
end
```

### Training and Data

1. **Structured Approach:** Implemented a structured approach to data retrieval and labeling.
2. **Model Performance:** The RNN achieved an accuracy of 95% to 99% with initial scenarios.

## Results

The initial testing of the RNN model shows high accuracy in classifying object behavior, with results ranging between 95% and 99%. 

![Training Progress](https://github.com/user-attachments/assets/0e56a7cd-e740-48a7-97cb-cccf3f8dfc70)


## Conclusion

This project demonstrated the effectiveness of using RNNs for classifying object behavior in autonomous driving scenarios. By leveraging MATLAB and Simulink, I was able to build a model that accurately predicts the risk level posed by different objects, which is essential for the safe operation of autonomous vehicles.

### What I Learned:
- **Data Preprocessing:** The importance of preprocessing in improving model performance.
- **Model Selection:** Why RNNs are particularly well-suited for time-series data in autonomous driving.
- **MATLAB-Simulink Integration:** How to effectively use MATLAB and Simulink together for modeling and simulation.

### Future Enhancements:
- **Real-World Testing:** Integrate real-world data to further validate the model.
- **Model Optimization:** Explore different architectures and hyperparameters to enhance model accuracy and efficiency.
- **Deployment:** Develop methods for deploying the trained model in real-time autonomous systems.

## Getting Started

To get started with this project:

1. **Clone the Repository:**
   `git clone https://github.com/JakubSchwenkbeck/Behavior-Classification-For-AV/.git`
2. **Navigate to the Project Directory:**
   `cd behavior-classificator`
3. **Run the Model:** Follow the instructions in the `scripts` directory to set up and run the model.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


