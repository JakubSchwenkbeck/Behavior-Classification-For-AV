
# Behavior Classificator for Autonomous Vehicles

Welcome to the **Behavior Classificator for Autonomous Vehicles** project! This project is part of the [**Matlab-Simulink Challenge**](https://github.com/mathworks/MATLAB-Simulink-Challenge-Project-Hub) and focuses on classifying object behavior and assessing the risk it poses to autonomous vehicles. The project leverages MATLAB and Simulink to create a robust model for autonomous driving scenarios.

<p align="center"> <img src="https://github.com/user-attachments/assets/bfd22392-e0c2-414f-be75-7d11b05dc627" alt="Visual Data" width="600"/> </p>

## Table of Contents
- [Overview](#overview)
- [About Me](#about-me)
- [Workflow](#workflow)
- [Additons](#additions)
- [Conclusion](#conclusion)
- [Getting Started](#getting-started)
- [License](#license)

## Overview

The project aims to classify the behavior of objects within autonomous driving scenarios using a Recurrent Neural Network (RNN). The goal is to understand the behavior of objects and predict their risk level, which is crucial for the safe operation of autonomous vehicles.

## About Me

I am Jakub, currently enrolled as computer science student pursuing a bachelors degree. Since I am working with Matlab for some time now, I was more than excited to have the oppertunity to partake in the Matlab/Simulink Challenge. 

Studying for the Bachelors degree means, that this project (classified for Masters/Doctors) was a big challenge and I therefore altered some goals and expectations to fit my personal skills. I hope it can be reviewed under a undergrad standard and if minor issues occur, the project isn't just thrown away:)

I chose this particular project because, not only am I interested and enthusiastic in learning more about Artifical Intelligence, but I really like to create Matlab Code with real world applications.

## Workflow


## 1. **First Setup**
To begin this project, I created a MATLAB project, initialized a Git repository, and connected it to this remote repository. I used the Automated Driving Toolbox™ and Deep Learning Toolbox™ to build, simulate, and train models.

### **Required Toolboxes:**
- **Automated Driving Toolbox™**
- **Deep Learning Toolbox™**

## 2. **Data Understanding & Transformation**
### Scene Creation:
The Scenario Designer from the Automated Driving Toolbox™ was used to create driving scenarios, including traffic, pedestrians, and different driving behaviors.

### Data retrieval:
The Data [Found here](https://www.dropbox.com/scl/fo/u1n1o0anct4c4yhb6cblb/AFp1VxLP_zYPJmahg9-xAUE?rlkey=crsaqf5a2vtgbr6xyoeei3vce&st=032cfis8&dl=0) is created by running the Scene Builder simulation and then exporting the sensor data. They don't hold the scenario itself but only the sensor data, therefore they can be opened in the normal Matlab workplace


### Data Transformation:
- **preprocessSensorData.m**: A custom script to clean and preprocess sensor data, including noise reduction and handling missing data.
- **dataAugmentation.m**: Data augmentation was applied to expand the training dataset by simulating variations in sensor noise.

## 3. **Model**
### Model Selection:
I chose an RNN to classify risky vs. safe behavior since it is ideal for processing sequences of time-series data and can capture temporal dependencies in object behavior.

### RNN Setup:
- **createRNN.m**: Contains the implementation of the RNN model using LSTM layers for time-series classification.
- **createLabels.m**: Function to generate appropriate labels (safe/risky) for the training data.
Here’s the structure of the RNN:

```matlab 

layers = [
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits, 'OutputMode', 'sequence')
    dropoutLayer(0.2)
    fullyConnectedLayer(numUniqueValues)
    softmaxLayer
    classificationLayer];
Training Options:
```
```matlab

options = trainingOptions('adam', ...
    'MaxEpochs', 2500, ...
    'InitialLearnRate', 1e-3, ...
    'MiniBatchSize', 32, ...
    'Shuffle', 'every-epoch', ...
    'ValidationFrequency', 50, ...
    'Verbose', false, ...
    'Plots', 'training-progress');
```
### Training:
- **trainRNN.m**: The RNN is trained with a dataset of vehicle and pedestrian trajectories labeled as safe or risky.
The training achieved an accuracy of 95%-99% in classifying behaviors.

## 4. **Scenario Simulation and Evaluation**
### Scenario Creation:
- **createScenarios.m**: Automates the process of generating different driving scenarios involving various pedestrian and vehicle behaviors.
- **TestScenario for visualization.mat**: This file contains a specific scenario used to test and visualize model performance.
### Evaluation:
- **evalModel.m**: Evaluates the RNN's performance by predicting object behavior and comparing it to the ground truth.
- **generateConfusionMatrix.m**: Generates a confusion matrix to visualize the classification performance across different scenarios.
- **exportTrainedModel.m**: Exports the trained RNN model for future use or deployment.
### Risk Prediction:
- **predictRiskOnNewData.m**: After training, this script uses the RNN model to predict the risk level of new sensor data in real-time.

## 5. **Visualization**
- **Visualization Folder**: Contains various visualizations related to scenario testing, including 2D and 3D representations of object trajectories and behaviors.
- **Main.m**: Main entry point to run the project, visualize results, and interact with the GUI.
- **GUI.m**: A custom GUI for interacting with the project’s scenarios, results, and predictions.

  The Scene(s) are created in the Scenebuilder and then via the 'export Matlab function' utility converted into a program. 
## 6. **Integration with Java Interface**
### Java-Matlab Interface:
I extended the project by integrating a JavaInterface to connect a Model that performs object recognition. The integration between MATLAB and Java enhances the object risk classification model by incorporating visual input directly from the vehicle’s sensors.

- **LoadJavaModel.m**: A script Interface to load the Java-based object recognition model into MATLAB. The object recognition model assists in identifying and tracking objects visually, which adds another layer of risk prediction based on labels, shapes, or movement predictions from the Java model.
## 7. **Results**
The RNN model achieved an accuracy ranging between 95% and 99% when tested on various driving scenarios. The confusion matrix generated after testing shows that the model is highly effective at distinguishing between safe and risky behaviors.

<p align="center"> <img src="https://github.com/user-attachments/assets/e1ce36d4-42f5-4251-9ed3-69531c12b6ef" alt="Training Progress" width="800"/> </p>


## Additions

With the selfwritten Model in Java and an selfwritten JavaMatlab interface, the Object Recognition model from java could get visual input from the car to help enhance the object risk classification with additonal data such as labels or movement predictions


## Conclusion

This project demonstrated the effectiveness of using RNNs for classifying object behavior in autonomous driving scenarios. By leveraging MATLAB and Simulink, I was able to build a model that accurately predicts the risk level posed by different objects, which is essential for the safe operation of autonomous vehicles.

### What I Learned:
- **Data Preprocessing:** The importance of preprocessing in improving model performance.
- **Model Selection:** Why RNNs are particularly well-suited for time-series data in autonomous driving.
- **MATLAB-Simulink Integration:** How to effectively use MATLAB and Simulink together for modeling and simulation.

### Future Enhancements:
- **Real-World Testing:** Integrate real-world data to further validate the model.
- **Model Optimization:** Explore different architectures and hyperparameters to enhance model accuracy and efficiency.
- **Enhanced features:** Make Movement Predictions and classify Objects, e.g. using [My Own AI Model](https://github.com/JakubSchwenkbeck/Object-Recognition-Prediction)
- **Deployment:** Develop methods for deploying the trained model in real-time autonomous systems.

## Getting Started

To get started with this project:

1. **Clone the Repository:**
   `git clone https://github.com/JakubSchwenkbeck/Behavior-Classification-For-AV.git`
2. **Navigate to the Project Directory:**
   `cd Behavior-Classification-For-AV`
3. **Run the Model:** `Go to the Main.m Function,which is the Main entry point. It can run out of the box (with the right Toolboxes;). You can also run the GUI.m function to be able to interact with the graphical user-interface prvided`.
   
(4.   **Download a small Dataset** )
   [Dropbox Link](https://www.dropbox.com/scl/fo/u1n1o0anct4c4yhb6cblb/AFp1VxLP_zYPJmahg9-xAUE?rlkey=crsaqf5a2vtgbr6xyoeei3vce&st=032cfis8&dl=0)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.













