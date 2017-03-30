function [a,boolen] = compareRepeatCount(mArr,nArr)
 %%%%%%功能，比较两个矩阵中是否有重复的数 1行，多列
    a = [];
    for i = 1:size(mArr,2)
        m = size(a,2)+1;
        if any(mArr(1,i) == nArr)
            a(1,m) = mArr(1,i); % 第一行记录边点
            a(2,m) = mArr(2,i); % 第二行记录边
        end
    end
    if length(a)
        boolen = 1;
    else
        boolen = 0;
    end
end
