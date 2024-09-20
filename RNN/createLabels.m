function Labels = createLabels(numActor,Num)

 % The label classiffies the risk from no risk 0 to huge risk / danger 1
 % The labelling is in 10 steps:
 % 0 - no risk
 % 0.1 - not risky at all
 % 0.2 - no worries yet
 % 0.3 - shouldn't have to worry
 % 0.4 - keep an eye out
 % 0.5 - watch the scene closely
 % 0.6 - this is not a good situation
 % 0.7 - bad situation, slow down
 % 0.8 - start to break hard
 % 0.9 - break 100%, stop immediatly
 % 1 - crash


%% This is just a small part of Scenarios, as I was alone and didn't have the time to create thousands of scenarios. I hope this still shows what the RNN will be capable of 


%% LOAD ALL LABELS

Labels = cell(1,Num);

%% CAR AND PREDESTRIAN

%% No Risk at all - Car driving straight, pedestrian far far away not moving, car varies speeds
Labels{1} = zeros(1,7);
Labels{2} = zeros(1,7);
Labels{3} = zeros(1,15);
Labels{4} = zeros(1,14);
Labels{5} = zeros(1,14);
Labels{6} = zeros(1,41);
Labels{7} = zeros(1,40);

%% No Risk at all - Car driving straight, pedestrian far away moving slow, car varies speeds

Labels{8} = zeros(1,39);
Labels{9} = zeros(1,36);
Labels{10} = zeros(1,35);
Labels{11} = zeros(1,8);
Labels{12} = zeros(1,9);
Labels{13} = zeros(1,8);

%% Adding sligth risk by moving Pedestrian closer

Labels{14} = [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];
Labels{15} = [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];
Labels{16} = [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];


%% moving pedestrian even closer, now even with gradually changing risk or Pedestrian on Sidewalk

Labels{17} = 2* [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];
Labels{18} = 2* [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];
Labels{19} = 2* [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];
Labels{20} = [0.2,0.2,0.1,0.1,0.1,0.1,0,0,0,0,0,0];
Labels{21} = [0.2,0.2,0.2,0.2,0.2,0.1,0.1,0,0,0,0,0];
Labels{22} = [0.4,0.4,0.3,0.3,0.3,0.3,0.3,0.2,0.2,0.1,0,0];
Labels{23} = [0.4,0.4,0.3,0.3,0.3,0.3,0.3,0.2,0.2,0.1,0,0];
Labels{24} = [0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.4,0.4,0.5,0.4,0.4,0.3,0.3,0.3,0.2,0.2,0.1,0.1,0,0,0,0];
Labels{25} = [0.2,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.3,0.1,0.1,0.1,0.1,0,0,0,0];

Labels{26} = [0.2,0.2,0.2,0.2,0.1,0.1,0.1,0.1,0,0];
Labels{27} =[0,0,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.1,0.1,0.1,0,0,0,0,0,0,0,0,0,0];


%% Only car drivig different streets
Labels{28} = zeros(1,56);
Labels{29} = zeros(1,24);
Labels{30} = [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];
Labels{31} = [0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2];
Labels{32} = [0.1,0.2,0.3,0.3,0.3,0.2,0.1];
Labels{33} = [0.1,0.1,0.2,0.2,0.3,0.3,0.2,0.2,0.2,0.1,0.1,0.1];
Labels{34} = [0,0,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.1,0.1,0.1,0.1,0.1,0.1,0];
Labels{35} = [0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0,0,0,0,0];
Labels{36} = zeros(1,26);   
Labels{37} = zeros(1,24);
Labels{38} = [0.1,0.1,0.1,0.2,0.2,0.3,0.3,0.4,0.6,0.6,0.5,0.5,0.4,0.3,0.2,0.2,0.1,0.1,0.1,0.1,0.1,0,0,0];
Labels{39} = [0,0.1,0.1,0.2,0.2,0.3,0.3,0.4,0.6,0.6,0.5,0.5,0.4,0.3,0.2,0.2,0.1,0.1,0.1,0.1,0];

%% Moderate risk level (0.3 - 0.4) Pedestrian moving towards street
Labels{40} = [0.3,0.5,0.3,0.2,0.1,0.1];
Labels{41} = [0.3,0.5,0.3,0.2,0.1,0.1];
Labels{42} = [0.3,0.5,0.3,0.2,0.1,0.1];
Labels{43} = [0.3,0.5,0.3,0.2,0.1,0.1];
Labels{44} = [0.3,0.5,0.3,0.2,0.1,0.1];
Labels{45} = [0.1,0.2,0.2,0.3,0.3,0.2,0.1];
Labels{46} = [0.3,0.4,0.5,0.3,0.2,0.1,0.1];
% 
%% More Risky Situations (with gradients)


%% Frontal Crash -1



%% 3 Actors



end
