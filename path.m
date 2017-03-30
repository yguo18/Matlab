serverNode = [0,1,24];
% 删除同时包含两个服务器的边
updataNodeArr = nodeArr;
size(updataNodeArr,1);
for i = 1 :size(nodeArr,1)
    if any(serverNode==nodeArr(i,1))&&any(serverNode==nodeArr(i,2))
        updataNodeArr(i,:)=[];
    end
end
userNode = userArr(:,2:3)';  %用户节点
% 把边编号
tmp = 1:size(updataNodeArr,1);
updataNodeArr = [updataNodeArr tmp'];
% 把相邻点进行筛选，
% 每一个cell{i}包含两行，第一行记录与i-1的相邻点，第二行记录在updataNodeArr中的编号即i-1与邻接点的边,而且进行的节点的排序
adjacentNode = cell(nodeCount,1);
for i = 0:nodeCount-1
   adjaNodeArr = [];
   for j = 1:size(updataNodeArr,1)
       m = size(adjaNodeArr,1)+1;
       if bitxor(updataNodeArr(j,1)==i,updataNodeArr(j,2)==i)  %单个点比较
           adjaNodeArr(m,:) = updataNodeArr(j,:);
       end
   end
   [adjaNodeArr ,b] = reOrderNode(adjaNodeArr,i);
   adjacentNode{i+1} = b;
end
% 在用户节点上删除服务器节点
recordServUserSamePoint = [];
for i = 1:userCount
    a = size(recordServUserSamePoint,1)+1;
    if any(userNode(1,i)==serverNode)
        recordServUserSamePoint(a) = userNode(1,i);
        userNode(:,i) = []; % 在用户节点上删除服务器节点
    end
end
%对消费节点进行广度优先搜素
nodeCellArr = cell(1,1);
for i = 1:size(userNode,2);
    adjacentNodeCp = adjacentNode
    currentNode = userNode(1,i);
    [a,boolen] = compareRepeatCount(adjacentNodeCp{currentNode + 1},serverNode);
    if boolen  % 如果为真的话，说明这一层包含服务器节点,找出节点路径
        possiblePath = updataNodeArr(a(2,1),:)
        diff = updataNodeArr(a(2,1),3) - userNode(2,i)
        %判断路径上的流量是否满足当前用户需求
        number = find(updataNodeArr(:,5)==a(2,1));
        if diff>0 %则是可行路径
            updataNodeArr(number,3) = diff;
        elseif diff == 0
                updataNodeArr(number,:) = [];
        else
            break
        end         
    else  % 更新 所有结点 的邻接点
        nextNode = [currentNode a(1,:)];
    end
    break
end