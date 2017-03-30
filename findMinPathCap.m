function  nodeQueue = findMinPathCap(nodeQueue,currentNode)
    for i = 1:size(nodeQueue,2)
        if nodeQueue(i) > currentNode
            nodeQueue(i) = currentNode;
        end
    end
end