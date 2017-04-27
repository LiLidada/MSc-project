function text2mat(textFile)
    
    % textFile : % e.g., 'optdigits_train.txt'
    % numeric data only
    % save results to 'matFile.mat'
        
    M = dlmread(textFile);
    
    save matFile.mat M

end