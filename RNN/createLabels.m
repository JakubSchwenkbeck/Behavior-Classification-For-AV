function allLabels = createLabels(numActor,sizee)

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



if(numActor ==2 )

label1 = [0,0,0,0,0,0,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3];


%AEB 2
label2  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,6,0.6,0.6,0.6,0.6,0.7,0.7,0.7,0.7,0.7,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.7];
%AEB 3
label3  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.3,0.3,0.2,0.2,0.2,0.2 ];

label4 = [0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.4,0.4,0.5,0.5,0.5,0.6,0.6,0.7,0.7,0.8,0.8,0.9,0.9,0.9,0.9,0.9,0.9,0.9,1];

label5 = [0.9,0.9,0.9,0.9,0.9,0.9,1];

label6 = [0.7,0.8,0.8,0.8,0.9,0.9,0.9,1,1,1];

label7 = [0.6,0.7,0.8,0.8,0.8,0.9,0.9,0.9,0.9,1,1];

label8 = [0.7,0.7,0.6,0.6,0.5,0.5,0.4,0.4,0.2,0.2,0.1,0.1,0.1,0.1,0,0,0,0,0];

label9 = [0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.2,0.2,0.2,0.2,0.2,0.1,0.1,0.1,0.1];

label10 = [0.2,0.2,0.3,0.3,0.2];
label11 = [0.2,0.2,0.3,0.3,0.3,0.3,0.5,0.5,0.5,0.6,0.7,0.7,0.7,0.7,0.7,0.8,0.8,0.8,0.8,0.8,0.8,0.7,0.7,0.6,0.6,0.4,0.3,0.3,0.4,0.3,0.4,0.4,0.4,0.4,0.4,0.4];


label91 = [0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.5,0.5,0.5,0.5,0.5,0.5,0.4,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.3,0.3,0.3,0.2,0.2,0.2,0.2];

label92 = [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.1];


labelB1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.5,0.5,0.5,0.5,0.6,0.6,0.6,0.7,0.8,0.8,0.8,0.8,0.9,0.9,0.9,0.9,1,1,1,1,1,1,1,1,1,1,1,0.9,0.9,0.8,0.8,0.8,0.8,0.7,0.7,0.6,0.6,0.5,0.5,0.5,0.4,0.4,0.4,0.3,0.3,0.2,0.2,0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];

labelB2 = [0,0,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.5,0.5,0.5,0.6,0.6,0.6,0.7,0.7,0.8,0.8,0.9,0.9,0.9,0.9,1,1];

labelB3 = [0.1,0.2,0.2,0.3,0.4,0.5,0.5,0.6,0.7,0.7,0.8,0.8,0.8,0.9,0.9,0.9];

labelB4 = [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.3,0.4,0.4,0.5,0.5,0.5,0.5,0.6,0.6,0.7,0.7,0.8,0,0.8,0.8,0.9,0.9,0.9,0.9,0.9,1,1,1,1,];

labelB5 = [0,0,0,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.5,0.5,0.6,0.6,0.6,0.6,0.6,0.6,0.7,0.7,0.7,0.7,0.7,0.7,0.7,0.7,0.7,0.7,0.7,0.8,0.8,0.7,0.8,0.7,0.7,0.7,0.8,0.8,0.7,0.7,0.7,0.7,0.7,0.7,0.6,0.6,0.6,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];
labelB6 = [0,0,0.1,0.1,0.1,0.1,0.2,0.2,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.5,0.5,0.6,0.6,0.6,0.6,0.6,0.6,0.7,0.7,0.7,0.7,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.9,0.8,0.9,0.8,0.8,0.8,0.8,0.7,0.7,0.7,0.7,0.7,0.7,0.6,0.6,0.6,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,];

labelB7 = [0,0.1,0.1,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.4,0.4,0.5,0.5,0.5,0.5,0.6,0.6,0.7,0.7,0.7,0.8,0.8,0.8,0.8,0.9,0.9,0.9,1,1,1,1,1];


labelB8 = [0,0,0,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.3,0.2,0.2,0.1,0.1,0.1,0.1,0,0,0,0,0,0];

noiseLevel = 0.01; % Adjust this to control the amount of noise

% Add small random noise to each array to create new versions
try
label93 = label4 + abs( noiseLevel * randn(size(label4)));
label94 = label5 +abs(  noiseLevel) * randn(size(label5));
label95 = label6 +abs(  noiseLevel) * randn(size(label6));
label96 = label7 +abs(  noiseLevel )* randn(size(label7));
label97 = label8 +abs(  noiseLevel )* randn(size(label8));
label98 = label9 + abs( noiseLevel )* randn(size(label9));
labelB11 = labelB1 + abs( noiseLevel )* randn(size(labelB1));
labelB21 = labelB2 + abs( noiseLevel )* randn(size(labelB2));
labelB31 = labelB3 + abs( noiseLevel )* randn(size(labelB3));
labelB41 = labelB4 + abs( noiseLevel )* randn(size(labelB4));
labelB51 = labelB5 + abs( noiseLevel )* randn(size(labelB5));
labelB61 = labelB6 + abs( noiseLevel )* randn(size(labelB6));
labelB71 = labelB7 + abs( noiseLevel )* randn(size(labelB7));
labelB81 = labelB8 + abs( noiseLevel )* randn(size(labelB8));

catch

label93 = label4 + 0.01;
label94 = label5 +0.01;
label95 = label6 +0.01;
label96 = label7 +0.01;
label97 = label8 +0.01;
label98 = label9 + 0.01;
labelB11 = labelB1 +0.01;
labelB21 = labelB2 +0.01;
labelB31 = labelB3 +0.01;
end

%disp(label93)


try
allLabels{1} = categorical(label1);

allLabels{2} = categorical(label10);

allLabels{3} = categorical(label11);

allLabels{4} = categorical(label2);
allLabels{5} = categorical(label3);
allLabels{6} = categorical(label4);
allLabels{7} = categorical(label5);
allLabels{8} = categorical(label6);

allLabels{9} = categorical(label7);

allLabels{10} = categorical(label8);
allLabels{11} = categorical(label9);
allLabels{12} = categorical(label91);
allLabels{13} = categorical(label92);
allLabels{14} = categorical(label93);
allLabels{15} = categorical(label94);
allLabels{16} = categorical(label95);
allLabels{17} = categorical(label96);
allLabels{18} = categorical(label97);
allLabels{19} = categorical(label98);
allLabels{20} = categorical(labelB1);
allLabels{21} = categorical(labelB11);
allLabels{22} = categorical(labelB2);
allLabels{23} = categorical(labelB21);
allLabels{24} = categorical(labelB3);
allLabels{25} = categorical(labelB31);
allLabels{26} = categorical(labelB4);
allLabels{27} = categorical(labelB41);
allLabels{28} = categorical(labelB5);
allLabels{29} = categorical(labelB51);

allLabels{30} = categorical(labelB6);
allLabels{31} = categorical(labelB61);

allLabels{32} = categorical(labelB7);
allLabels{33} = categorical(labelB71);
allLabels{34} = categorical(labelB8);
allLabels{35} = categorical(labelB81);
catch
createLabels(numActor,sizee);
end






elseif(numActor == 3)


elseif(numActor == 4)


end
end



function testData(label)
[~,x]= size(label);
for i = 1:x
val = label(i);
if(val > 1)
    disp("Greater 1 at "+i )
end
if(mod(val*10,1) ~= val*10 )
    disp(i)
end

end
end
