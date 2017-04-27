function Ymat = LabelVec2Mat(Yvec)
% This function is to convert labels from vector to matrix.

[~,numCols] = size(Yvec);
% Let rows of Yvec represent examples
if numCols ~= 1
    Yvec = Yvec';
end

[examples,~] = size(Yvec);
klabels = max(Yvec); % num of different kinds of labels

if min(Yvec) == 0
    %%% Yvec contains label 0 (e.g., label of hand written digits:0..9)
    % in Ymat, each column represents an example, rows represent labels
    % if the label of an example is L, then the (L+1)th row is 1
    % Yvec = [0  2  3]
    % Ymat =  1  0  0
    %         0  0  0
    %         0  1  0
    %         0  0  1 
    Ymat = zeros(klabels + 1,examples);

    for i = 1:examples
            Ymat(Yvec(i)+1,i) = 1;
    end
else
    %%% Yvec contails labels without 0
    % in Ymat, each column represents an exmaple, rows represent labels
    % if the label of an example is L, then the Lth row is 1
    % Yvec = [1  2  3]
    % Ymat =  1  0  0
    %         0  1  0
    %         0  0  1
    Ymat = zeros(klabels,examples);

    for i = 1:examples
            Ymat(Yvec(i),i) = 1;
    end
end
       
end