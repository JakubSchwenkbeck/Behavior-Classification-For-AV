function Main(AEBSensor)
 load('AEBSensor.mat', 'AEBSensor');
sensorData = AEBSensor;

data = preprocessSensorData(sensorData);


net = createRNN(data);
disp(net);



end

