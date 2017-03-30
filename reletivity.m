function nodeQueue = reletivity(nodeQueue,serverUnitCost)
%1 结点 2 单价 3 容量 4 关联度
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
    m = sort(m,'descend'); % 递减排序
    for i = 1:size(m,2)
        nodeQueue(:,m(i)) = [];
    end
end