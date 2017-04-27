function newData = meanNormalisation(data)

[numExamples,numFeatures] =  size(data);

mu = nanmean(data); % mean ignoring NaN values
data = data - ones(numExamples,1) * mu;
for dim = 1:numFeatures
    data(:,dim) = data(:,dim) ./ std(data(:,dim));
end

newData = data;

end


