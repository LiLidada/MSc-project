function [Output_actual,Time] = ELM_test(Input,WeightIH,WeightHO,Target_vec_test,acSelection)

[~, numPatterns] = size(Input);

start_time = cputime;

% Input bias unit value is 1
Input = cat(1,ones(1,numPatterns),Input);
% Add in weighted contribution from each input unit
SumH = WeightIH * Input;
% compute to give activation
if acSelection == 2
    Hidden = sin(SumH); 
    disp('*** sine_ELM_test')
elseif acSelection == 3
    Hidden = double(hardlim(SumH));
    disp('*** hardim_ELM_test')
elseif acSelection == 4
    Hidden = tribas(SumH);
    disp('*** tribas_ELM_test')
elseif acSelection == 5
    Hidden = radbas(SumH);
    disp('*** radbas_ELM_test')
else
    Hidden = 1 ./ (1 + exp(-SumH));
    disp('*** sigmoid_ELM_test')
end

% Add in weighted contribution from each hidden unit
SumO = WeightHO * Hidden;

end_time = cputime;
Time = end_time - start_time;

% - 1 because (rows - 1) represents the actual label of digits
% e.g. 1st row has the maximum value means that pattern has label 0
[~,Output_actual] = max(SumO,[],1);
if min(Target_vec_test) == 0
    Output_actual = (Output_actual - 1)';
else
    Output_actual = Output_actual';
end
    
end