function [Output_actual,Time,WeightIH,WeightHO] = ELM(Input,Target,numHidden,Target_vec,selection,acSelection)

[numInput, numPatterns] = size(Input);

start_time = cputime;

% Fill 'WeightIH' with Uniformly distributed random numbers
if selection == 5
    WeightIH = (rand(numHidden,numInput+1)*2-1)*100;
    disp('*** range [-100, 100]');
elseif selection == 2 
    WeightIH = (rand(numHidden,numInput+1)*2-1)/10;
    disp('*** range [-0.1, 0.1]');
elseif selection == 3
    WeightIH = (rand(numHidden,numInput+1)*2-1)/100;
    disp('*** range [-0.01, 0.01]');
elseif selection == 4
    WeightIH = (rand(numHidden,numInput+1)*2-1)*10;
    disp('*** range [-10, 10]');
else
    WeightIH = rand(numHidden,numInput+1)*2-1;
    disp('*** range [-1, 1]');
end


% Input bias unit value is 1
Input = cat(1,ones(1,numPatterns),Input);
% Add in weighted contribution from each input unit
SumH = WeightIH * Input;
% compute to give activation
if acSelection == 2
    Hidden = sin(SumH); 
    disp('*** sine applied');
elseif acSelection == 3
    Hidden = double(hardlim(SumH));
    disp('*** hardim applied');
elseif acSelection == 4
    Hidden = tribas(SumH);
    disp('*** tribas applied');
elseif acSelection == 5
    Hidden = radbas(SumH);
    disp('*** radbas applied');
else
    Hidden = 1 ./ (1 + exp(-SumH));
    disp('*** sigmoid applied');
end

% Moore-Penrose pseudoinverse 
WeightHO = Target * pinv(Hidden);

% Add in weighted contribution from each hidden unit
SumO = WeightHO * Hidden;

end_time = cputime;
Time = end_time - start_time;

% - 1 because (rows - 1) represents the actual label of digits
% e.g. 1st row has the maximum value means that pattern has label 0
[~,Output_actual] = max(SumO,[],1);
if min(Target_vec) == 0
    Output_actual = (Output_actual - 1)';
else
    Output_actual = Output_actual';
end
    
end