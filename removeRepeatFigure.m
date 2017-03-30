function mArr = removeRepeatFigure(mArr,nArr)
 %%%%%%功能，比较两个矩阵中是否有重复的数 1行，多列
    a = size(mArr,2);
    m = []; %用来记录删除的行数 
    for i = 1:a
        if any(mArr(1,i)==nArr)
            m = [m i];
        end
    end
    % 对m进行排序按大到小的顺序
    m = sort(m,'descend'); % 递减排序
    for i = 1:size(m,2)
        mArr(:,m(i)) = [];
    end
end