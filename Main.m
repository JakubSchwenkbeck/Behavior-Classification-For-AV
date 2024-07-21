function Main(AEBSensor)
 load('AEBSensor.mat', 'AEBSensor');
sensorData = AEBSensor;

data = preprocessSensorData(sensorData);
disp(data)
end
