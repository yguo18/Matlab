function nodeQueue = reletivity(nodeQueue,serverUnitCost)
%1 ��� 2 ���� 3 ���� 4 ������
    m = [];
    for i = 1:size(nodeQueue,2)
        releDegree = serverUnitCost/(nodeQueue(2,i)*nodeQueue(3,i));
        if releDegree < 1
            m = [m i];
        else
%             nodeQueue(4,i) = nodeQueue(3,i)*nodeQueue(2,i);
            nodeQueue(4,i) = 1/nodeQueue(2,i);
        end
    end
    m = sort(m,'descend'); % �ݼ�����
    for i = 1:size(m,2)
        nodeQueue(:,m(i)) = [];
    end
end