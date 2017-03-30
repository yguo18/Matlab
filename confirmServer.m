[nodEdgUserCount,nodeCount,edgeCount,userCount,nodeArr,userArr,nodeLoadSum,userTotalNeed,serverUnitCost]=computeNodeSum();
updataNodeArr = nodeArr;
sortrows(userArr,-2)
userNode = userArr(:,2:3)';  %用户节点
% 把边编号
tmp = 1:size(updataNodeArr,1);
updataNodeArr = [updataNodeArr tmp'];
% 把相邻点进行筛选，
% 每一个cell{i}包含两行，第一行记录与i-1的相邻点，第二行记录在updataNodeArr中的编号即i-1与邻接点的边,而且进行的节点的排序
adjacentNode = cell(nodeCount,1);
for i = 0:nodeCount-1
   adjaNodeArr = [];
   for j = 1:size(updataNodeArr,1)  % 在所有的节点队列列中筛选一个已记录的点和未记录的点
       m = size(adjaNodeArr,1)+1;
       if bitxor(updataNodeArr(j,1)==i,updataNodeArr(j,2)==i)  %单个点比较
           adjaNodeArr(m,:) = updataNodeArr(j,:);   
       end
   end
   [adjaNodeArr ,b] = reOrderNode(adjaNodeArr,i);
   b(2,:) = [];
   b(4,:) = 0;  % 以后用来记录关联度
   adjacentNode{i+1} = b;  % 记录了四行的数据1 点  2 单价 3 容量  4关联度
end
% priceArr = cell(1,1);
priceArr = [];
capArr = [];
userNode(3,:) = 1 - userNode(2,:)./sum(userNode(2,:),2);
for i = 1:length(userNode)
    randNode = userNode(1,i);
    currentLayerNode(1,1) = randNode;
    currentLayerNode(2,1) = 0;  % 记录单价
    currentLayerNode(3,1) = userNode(2,i); % 记录容量
    currentLayerNode(4,1) = userNode(3,i);
    recordUsedNode = [];
    recordUsedNode = [recordUsedNode currentLayerNode]; %记录使用的节点
    m =i;
    while 1
        nextLayerNode = [];
        for i = 1:size(currentLayerNode,2) % 求当前层每个节点的下一层节点
            % 首先在adjacentNode中取出当前结点的邻接点
            nodeQueue = [];
            nodeQueue = adjacentNode{currentLayerNode(1,i)+1};
            %删除重复点炒作   ji 在nodeQueue中删除recordUserNode中的点；
            nodeQueue = removeRepeatFigure(nodeQueue,recordUsedNode(1,:));
            if isempty(nodeQueue)
                continue;
            end
            nodeQueue(2,:) = nodeQueue(2,:) + currentLayerNode(2,i); % 计算节点之间的单价和
            nodeQueue(3,:) = findMinPathCap(nodeQueue(3,:),currentLayerNode(3,i));
            nodeQueue = reletivity(nodeQueue,serverUnitCost);
            nextLayerNode = [nextLayerNode nodeQueue];
            %记录用了多少点
            recordUsedNode = [recordUsedNode nodeQueue];
        end
        currentLayerNode = nextLayerNode;
        if isempty(currentLayerNode) || size(recordUsedNode,2) >= nodeCount
            break;
        end
    end
    recordUsedNode = recordUsedNode';
%     recordUsedNode = sortrows(recordUsedNode,1);
    tmpArr = [recordUsedNode(:,1) recordUsedNode(:,3)];
    tmpArr = addPoint(tmpArr,nodeCount);
    tmpArr = sortrows(tmpArr,1);
    capArr = [capArr tmpArr(:,2)];
    
    tmpArr = [recordUsedNode(:,1) recordUsedNode(:,4)];
    tmpArr = addPoint(tmpArr,nodeCount);
    tmpArr = sortrows(tmpArr,1);
    priceArr = [priceArr tmpArr(:,2)];
end
factor1 = sum(capArr,2); %容量
factor = sum(priceArr,2);
b = 0:length(factor)-1;
b = b';
factor = [b factor factor1];
factor = sortrows(factor,-2)
% sumNeed = 0;
% record = [];
% for i = 1:size(factor,1)
%     sumNeed = sumNeed + factor(i,3);
%     record = [record factor(i,1)];
%     for i = 1:size(nodeArr,1)
%         if any(nodeArr(i,1)==record) && any(nodeArr(i,2)==record)
%             sumNeed = sumNeed - 2*nodeArr(i,3);
%         end
%     end
%     if sumNeed >= userTotalNeed
%         break;
%     end
% end
% disp(record);
% % % % % % 