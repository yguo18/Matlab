function mArr = removeRepeatFigure(mArr,nArr)
 %%%%%%���ܣ��Ƚ������������Ƿ����ظ����� 1�У�����
    a = size(mArr,2);
    m = []; %������¼ɾ�������� 
    for i = 1:a
        if any(mArr(1,i)==nArr)
            m = [m i];
        end
    end
    % ��m�������򰴴�С��˳��
    m = sort(m,'descend'); % �ݼ�����
    for i = 1:size(m,2)
        mArr(:,m(i)) = [];
    end
end