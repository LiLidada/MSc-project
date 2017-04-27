numHiddenList = getappdata(0,'numHiddenList');
oriFeatures_test = getappdata(0,'oriFeatures_test');
tarLabels_vec_test = getappdata(0,'tarLabels_vec_test');
[numtestPatterns,~] = size(tarLabels_vec_test);

if isempty(numHiddenList)
    
else
    numTrain = getappdata(0,'numTrain');
    
    WeightIHList = getappdata(0,'WeightIHList');
    WeightHOList = getappdata(0,'WeightHOList');

    avgtrainAccuracyList = getappdata(0,'avgtrainAccuracyList');
    stdTrain = getappdata(0,'stdTrain');

    % Preallocate for speed
    testAccuracyList = zeros(length(numHiddenList),1);
    % testTimeList = zeros(length(numHiddenList),1);

    for i = 1:length(numHiddenList)

        [Output_test,TestingTime] = ELM_test(oriFeatures_test,....
        WeightIHList(i).WeightIH,WeightHOList(i).WeightHO,tarLabels_vec_test);

        testAccuracyList(i,1) = sum(Output_test == tarLabels_vec_test,1)/numtestPatterns;
    %         testTimeList(i,j) = TestingTime;

    end

    [maxTest,indTest] = max(testAccuracyList);

    [maxTrain,indTrain] = max(avgtrainAccuracyList);

    figure
    errorbar(numHiddenList,nonzeros(avgtrainAccuracyList),stdTrain,'--bs',...
        'LineWidth',2,...
        'MarkerSize',5,...
        'MarkerEdgeColor','b');hold on
    plot(numHiddenList,nonzeros(testAccuracyList),'r-*','MarkerSize',7,'LineWidth',3);

    legend('Train','Test');

    set(gca,'FontSize',25);
    str1=sprintf('Best train accuracy = %.2f%s when numHidden = %d',maxTrain*100,'%',numHiddenList(indTrain));
    str2=sprintf('Best test accuracy = %.2f%s when numHidden = %d',maxTest*100,'%',numHiddenList(indTest));
    title({str1,str2});
    xlabel('Number of hidden units');
    ylabel('Accuracy');
end