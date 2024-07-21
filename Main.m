function Main(AEBSensor)
sensorData = AEBSensor;

data = preprocessSensorData(sensorData);
disp(data)
end
