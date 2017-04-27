function [bestWeightIH,bestWeightHO,minValidErr,index] = back_propagation(Input_train,Input_valid,Target_train,Target_valid,Target_train_vec,Target_valid_vec,totalEpoch,numHidden,smallwt,eta,alpha)

[numInput, patterns_train] = size(Input_train);
[numOutput,~] = size(Target_train);
[~, patterns_valid] = size(Input_valid);
trainErrList = zeros(1,totalEpoch); 
validErrList = zeros(1,totalEpoch);

% Preallocate for speed
WeightIH0 = zeros(1, numHidden);
WeightHO0 = zeros(1,numOutput);
WeightIH = zeros(numInput,numHidden);
WeightHO = zeros(numHidden,numOutput);
DeltaWeightIH0 = zeros(1,numHidden);
DeltaWeightHO0 = zeros(1,numOutput);
DeltaWeightIH = zeros(numInput,numHidden);
DeltaWeightHO = zeros(numHidden,numOutput);
SumH_train = zeros(numHidden,patterns_train);
SumH_valid = zeros(numHidden,patterns_valid);
SumO_train = zeros(numOutput,patterns_train);
SumO_valid = zeros(numOutput,patterns_valid);
Hidden_train = zeros(numHidden,patterns_train);
Hidden_valid = zeros(numHidden,patterns_valid);
Output_train = zeros(numOutput,patterns_train);
Output_valid = zeros(numOutput,patterns_valid);
DeltaO = zeros(numOutput,1);
DeltaH = zeros(numHidden,1);
SumDOW = zeros(numHidden,1);

% Initialize WeightIH 
% rng('default'); % get same results when using "randn"
for j = 1:numHidden 
    WeightIH0(1,j) = 2 * (randn(1) - 0.5) * smallwt;
    for i = 1: numInput
        WeightIH(i,j) = 2 * (randn(1) - 0.5) * smallwt;
    end
end

% initialize WeightHO 
for k = 1:numOutput
    WeightHO0(1,k) = 2 * (randn(1) - 0.5) * smallwt;
    for j = 1:numHidden
        WeightHO(j,k) = 2 * (randn(1) - 0.5) * smallwt;
    end
end

Output_vec_train = zeros(totalEpoch, patterns_train);
Output_vec_valid = zeros(totalEpoch, patterns_valid);


for epoch = 1:totalEpoch   

    trainError = 0;
    validError = 0;

     % Calculate validation error
    for pp = 1:patterns_valid

        % j loop computes hidden unit activations
        for j = 1:numHidden 
            % Add in weighted contribution from each input unit 
            SumH_valid(j,pp) = WeightIH0(1,j) + sum(Input_valid(:,pp) .* WeightIH(:,j));      
            Hidden_valid(j,pp) = 1/(1 + exp(-SumH_valid(j,pp))); % compute sigmoid to give activation        
        end

        % k loop computes output unit activations
        for k = 1:numOutput 
            SumO_valid(k,pp) = WeightHO0(1,k) + sum(Hidden_valid(:,pp) .* WeightHO(:,k));
            Output_valid(k,pp) = 1/(1 + exp(-SumO_valid(k,pp)));
            validError = validError - (Target_valid(k,pp) * log(Output_valid(k,pp)) + (1 - Target_valid(k,pp)) * log(1 - Output_valid(k,pp)))/patterns_valid; % the Cross-Entropy error function
        end

        % Output_valid is a matrix that for validation pattern pp, there are numOutput values
        % for each label. The label that has maximum values is the label
        % for validation pattern pp
        [~,indexLabel_valid] = max(Output_valid(:,pp));
        Output_vec_valid(epoch,pp) = indexLabel_valid;

    end

    % If the training patterns are presented in the same systematic order 
    % during each epoch, it is possible for weight oscillations to occur. 
    % It is therefore generally a good idea to use a new random order for 
    % the training patterns for each epoch. 
    np = randperm(patterns_train);
    for p = np(1:end) % p loop over training patterns

        % j loop computes hidden unit activations
        for j = 1:numHidden     
            % Add in weighted contribution from each input unit
            SumH_train(j,p) = WeightIH0(1,j) + sum(Input_train(:,p) .* WeightIH(:,j));             
            Hidden_train(j,p) = 1/(1 + exp(-SumH_train(j,p))); % compute sigmoid to give activation        
        end

        % k loop computes output unit activations
        for k = 1:numOutput 
            % add in weighted contribution from each hidden unit
            SumO_train(k,p) = WeightHO0(1,k) + sum(Hidden_train(:,p) .* WeightHO(:,k));          
            Output_train(k,p) = 1/(1 + exp(-SumO_train(k,p)));
            % trainError = trainError + sqrt(1/patterns_train * (Targets_train(k,p) - Output(k,p)) * (Targets_train(k,p) - Output(k,p))); % Root Mean Squared Error
            trainError = trainError - (Target_train(k,p) * log(Output_train(k,p)) + (1 - Target_train(k,p)) * log(1 - Output_train(k,p)))/patterns_train; % the Cross-Entropy error function
               
%                 DeltaO(k,1) = (Target_train(k,p) - Output_train(k,p)) * Output_train(k,p) * (1 - Output_train(k,p));
            DeltaO(k,1) = Target_train(k,p) - Output_train(k,p);
        end

        % Output_train is a matrix that for training pattern p, there are numOutput values
        % for each label. The label that has maximum values is the label
        % for training pattern p
        [~,indexLabel_train] = max(Output_train(:,p));
        Output_vec_train(epoch,p) = indexLabel_train;

        % Back-propagate errors to hidden layer
        for j = 1:numHidden 
            SumDOW(j,1) = sum(WeightHO(j,:)' .* DeltaO); 
            DeltaH(j,1) = SumDOW(j,1) * Hidden_train(j,p) * (1 - Hidden_train(j,p));
        end

        % Update weights WeightIH
        for j = 1:numHidden 
            DeltaWeightIH0(j) = eta * DeltaH(j,1) + alpha * DeltaWeightIH0(j);
            WeightIH0(j) = WeightIH0(j) + DeltaWeightIH0(j);
            DeltaWeightIH(:,j) =  eta * Input_train(:,p) * DeltaH(j,1) + alpha * DeltaWeightIH(:,j);
            WeightIH(:,j) = WeightIH(:,j) + DeltaWeightIH(:,j);
        end

        % Update weights WeightHO
        for k = 1:numOutput 
            DeltaWeightHO0(k) = eta * DeltaO(k,1) + alpha * DeltaWeightHO0(k);
            WeightHO0(k) = WeightHO0(k) + DeltaWeightHO0(k); 
            DeltaWeightHO(:,k) = eta * Hidden_train(:,p) * DeltaO(k,1) + alpha * DeltaWeightHO(:,k);
            WeightHO(:,k) = WeightHO(:,k) + DeltaWeightHO(:,k);
        end

    end            

    trainErrList(1,epoch) = trainError; 
    validErrList(1,epoch) = validError;
    [minValidErr,index] = min(nonzeros(validErrList));

    if validError == minValidErr
        bestWeightIH = cat(1,WeightIH0,WeightIH);
        bestWeightHO = cat(1,WeightHO0,WeightHO);
    end


end

% Plot train error against epoch
figure
plot(1:totalEpoch,trainErrList,'b-o','MarkerSize',7,'LineWidth',3);hold on
plot(1:totalEpoch,validErrList,'r-o','MarkerSize',7,'LineWidth',3);
set(gca,'FontSize',25);
str=sprintf('Minimum validation error = %f at epoch = %d', minValidErr, index);
title(str);  
legend('Train Cross-Entropy error','Validation Cross-Entropy error');

    
% Plot percentage of correct classified labels against epoch

if min(Target_train_vec) == 0 % hand written digits data set has 0 label
    Output_vec_train = Output_vec_train - 1;
    Output_vec_valid = Output_vec_valid - 1;
end
    
trainAccuracy = zeros(1,totalEpoch);
validAccuracy = zeros(1,totalEpoch);
for e = 1:totalEpoch
    
    trainAccuracy(1,e) = sum(Output_vec_train(e,:) == Target_train_vec,2)/patterns_train;
    validAccuracy(1,e) = sum(Output_vec_valid(e,:) == Target_valid_vec,2)/patterns_valid;

end

[maxTrain,indTrain] = max(trainAccuracy);
[maxValid,indValid] = max(validAccuracy);

figure
plot(1:totalEpoch, trainAccuracy, 'c-*','MarkerSize',7,'LineWidth',3);hold on
plot(1:totalEpoch, validAccuracy, 'm-*','MarkerSize',7,'LineWidth',3);
set(gca, 'FontSize', 25);
str1=sprintf('Best train accuracy = %.2f%s at epoch = %d',maxTrain*100,'%',indTrain);
str2 = sprintf('Best validation accuracy = %.2f%s at epoch = %d',maxValid*100,'%',indValid);
title({str1,str2});
xlabel('epoch');
ylabel('Accuracy');
legend('TrainAccuracy','ValidAccuracy');


