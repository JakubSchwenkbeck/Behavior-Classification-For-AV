function allLabels = createLabels(numActor,sizee)

labelsCellArray = cell(sizee, 1);
    

if(numActor ==2 )

label1 = [0,0,0,0,0,0,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.24,0.24,0.24,0.24,0.24,0.25,0.25,0.26,0.3,0.3,0.3];


%AEB 2
label2  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.12,0.13,0.14,0.15,0.2,0.2,0.2,0.22,0.23,0.24,0.25,0.26,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,6,0.6,0.6,0.6,0.6,0.75,0.75,0.75,0.75,0.75,0.86,0.86,0.86,0.86,0.86,0.8,0.8,0.7];
%AEB 3
label3  =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.1,0.1,0.11,0.12,0.12,0.13,0.14,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.16,0.17,0.2,0.205,0.21,0.2,0.22,0.23,0.24,0.25,0.26,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.3,0.3,0.25,0.25,0.22,0.2 ];

label4 = [0,0,0,0,0,0,0,0.5,0.5,0.1,0.1,0.1,0.1,0.15,0.15,0.15,0.2,0.2,0.25,0.3,0.3,0.35,0.4,0.45,0.55,0.5,0.5,0.6,0.65,0.7,0.75,0.8,0.85,0.95,0.9,0.9,0.9,0.9,0.9,0.9,1];

label5 = [0.9,0.9,0.9,0.9,0.9,0.9,1];

label6 = [0.7,0.8,0.8,0.84,0.88,0.9,0.93,0.94,0.95,0.99];

label7 = [0.6,0.7,0.8,0.8,0.84,0.88,0.9,0.93,0.94,0.95,0.99];

label8 = [0.7,0.7,0.65,0.6,0.55,0.5,0.4,0.35,0.2,0.2,0.1,0.1,0.1,0.1,0,0,0,0,0];

label9 = [0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.25,0.25,0.25,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.25,0.25,0.25,0.25,0.2,0.12,0.11,0.1,0.1];

label10 = [0.2,0.2,0.3,0.3,0.2];
label11 = [0.2,0.2,0.3,0.3,0.3,0.3,0.5,0.5,0.55,0.6,0.7,0.7,0.7,0.75,0.76,0.8,0.8,0.85,0.85,0.8,0.8,0.7,0.7,0.6,0.6,0.4,0.3,0.3,0.4,0.3,0.4,0.4,0.4,0.4,0.4,0.4];


label91 = [0.2,0.2,0.2,0.2,0.2,0.2,0.3,0.3,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.5,0.5,0.5,0.5,0.5,0.5,0.4,0.4,0.4,0.4,0.4,0.4,0.3,0.3,0.3,0.3,0.3,0.2,0.2,0.2,0.2];

label92 = [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.15,0.15,0.15,0.15,0.15,0.2,0.2,0.2,0.2,0.24,0.24,0.24,0.24,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.35,0.3,0.35,0.34,0.35,0.34,0.3,0.3,0.3,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.1];

noiseLevel = 0.01; % Adjust this to control the amount of noise

% Add small random noise to each array to create new versions
try
label93 = label4 + abs( noiseLevel * randn(size(label4)));
label94 = label5 +abs(  noiseLevel) * randn(size(label5));
label95 = label6 +abs(  noiseLevel) * randn(size(label6));
label96 = label7 +abs(  noiseLevel )* randn(size(label7));
label97 = label8 +abs(  noiseLevel )* randn(size(label8));
label98 = label9 + abs( noiseLevel )* randn(size(label9));
catch

label93 = label4 + 0.01;
label94 = label5 +0.01;
label95 = label6 +0.01;
label96 = label7 +0.01;
label97 = label8 +0.01;
label98 = label9 + 0.01;

end

%disp(label93)



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





elseif(numActor == 3)


elseif(numActor == 4)


end
end