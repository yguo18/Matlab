function [a,boolen] = compareRepeatCount(mArr,nArr)
 %%%%%%���ܣ��Ƚ������������Ƿ����ظ����� 1�У�����
    a = [];
    for i = 1:size(mArr,2)
        m = size(a,2)+1;
        if any(mArr(1,i) == nArr)
            a(1,m) = mArr(1,i); % ��һ�м�¼�ߵ�
            a(2,m) = mArr(2,i); % �ڶ��м�¼��
        end
    end
    if length(a)
        boolen = 1;
    else
        boolen = 0;
    end
end
