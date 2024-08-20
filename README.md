# Behavior Classificator for Autonomous Vehicles

Welcome to the **Behavior Classificator for Autonomous Vehicles** project! This project is part of the **Matlab-Simulink Challenge** and focuses on classifying object behavior and assessing the risk it poses to autonomous vehicles. The project leverages MATLAB and Simulink to create a robust model for autonomous driving scenarios.

## Table of Contents
- [Overview](#overview)
- [Workflow](#workflow)
  - [Data Understanding](#data-understanding)
  - [Model](#model)
  - [Initial RNN Setup](#initial-rnn-setup)
  - [Training and Data](#training-and-data)
- [Results](#results)
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
2. **Initial RNN:**
   - **Layers:**
     - `sequenceInputLayer(numFeatures)` - Input layer
     - `lstmLayer(numHiddenUnits, 'OutputMode', 'last')` - LSTM layer
     - `fullyConnectedLayer(numClasses)` - Fully connected layer
     - `softmaxLayer` - Softmax layer for classification
     - `classificationLayer` - Classification layer
   - **Training Options:**
     - Optimizer: Adam
     - Max Epochs: 20
     - MiniBatchSize: 20
     - Verbose: 1
     - Plots: Training-progress

### Initial RNN Setup

1. **Revised RNN:**
   - **Layers:**
     - `sequenceInputLayer(numFeatures)` - Input layer
     - `lstmLayer(numHiddenUnits, 'OutputMode', 'sequence')` - First LSTM layer
     - `dropoutLayer(0.2)` - Dropout layer
     - `fullyConnectedLayer(numUniqueValues)` - Fully connected layer
     - `softmaxLayer` - Softmax layer for classification
     - `classificationLayer` - Classification layer
   - **Training Options:**
     - Optimizer: Adam
     - Max Epochs: 1000
     - Initial Learn Rate: 1e-3
     - MiniBatchSize: 32
     - Shuffle: Every-epoch
     - Validation Frequency: 50
     - Verbose: False
     - Plots: Training-progress

### Training and Data

1. **Structured Approach:** Implemented a structured approach to data retrieval and labeling.
2. **Model Performance:** The RNN achieved an accuracy of 95% to 99% with initial scenarios.

## Results

The initial testing of the RNN model shows high accuracy in classifying object behavior, with results ranging between 95% and 99%. 

![Training Progress](https://github.com/user-attachments/assets/56803e7d-4022-4adb-b4b2-c6bad6e020c6)

## Getting Started

To get started with this project:

1. **Clone the Repository:**
   `git clone https://github.com/JakubSchwenkbeck/Behavior-Classification-For-AV/.git`
2. **Navigate to the Project Directory:**
   `cd behavior-classificator`
3. **Run the Model:** Follow the instructions in the `scripts` directory to set up and run the model.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


