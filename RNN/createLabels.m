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





%% LOAD ALL LABELS

Labels = cell(1,Num);


%% No Risk at all - Car driving straight, pedestrian far far away not moving
Labels{1} = zeros(1,7);
Labels{2} = zeros(1,7);
Labels{3} = zeros(1,15);
Labels{4} = zeros(1,14);
Labels{5} = zeros(1,14);
Labels{6} = zeros(1,41);
Labels{7} = zeros(1,40);









end
