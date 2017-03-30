% serverNode = [0,3,22];
% 删除同时包含两个服务器的边
updataNodeArr = nodeArr;
size(updataNodeArr,1);
% for i = 1 :size(nodeArr,1)
%     if any(serverNode==nodeArr(i,1))&&any(serverNode==nodeArr(i,2))
%         updataNodeArr(i,:)=[];
%     end
% end
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

% randNode = userNode(1,randint(1,1,[1 size(userNode,2)]));
% currentLayerNode = randNode;
% randNodeTreeArr = cell(1,1);  %jilu ceng jidian
% number = size(randNodeTreeArr,2);
% randNodeTreeArr{number} = currentLayerNode;
% recordUsedNode = [];
% recordUsedNode = [recordUsedNode currentLayerNode]; %记录使用的节点
% 
% while 1
%     nextLayerNode = [];
%     for i = 1:length(currentLayerNode)
%         m = size(randNodeTreeArr,2);
%         % 首先在adjacentNode中取出当前结点的邻接点
%         nodeQueue = adjacentNode{currentLayerNode(i)+1};
%         %删除重复点炒作   ji 在nodeQueue中删除recordUserNode中的点；
%         nodeQueue = removeRepeatFigure(nodeQueue,recordUsedNode);
%         randNodeTreeArr{m+i} = nodeQueue; 
%         nextLayerNode = [nextLayerNode nodeQueue(1,:)];
%         %记录用了多少点
%         recordUsedNode = [recordUsedNode nodeQueue(1,:)];
%     end
%     currentLayerNode = nextLayerNode;
%     if length(recordUsedNode) == nodeCount;
%         break;
%     end
% end
randNode = userNode(1,randint(1,1,[1 size(userNode,2)]));
currentLayerNode = randNode;
randNodeTreeArr = cell(1,1);  %jilu ceng jidian
% number = size(randNodeTreeArr,2);
m = size(randNodeTreeArr,2);
randNodeTreeArr{m} = currentLayerNode;
recordUsedNode = [];
recordUsedNode = [recordUsedNode currentLayerNode]; %记录使用的节点

while 1
    nextLayerNode = [];
    for i = 1:length(currentLayerNode) % 求当前层每个节点的下一层节点
        m = size(randNodeTreeArr,2);
        % 首先在adjacentNode中取出当前结点的邻接点
        nodeQueue = adjacentNode{currentLayerNode(i)+1};
        %删除重复点炒作   ji 在nodeQueue中删除recordUserNode中的点；
        nodeQueue = removeRepeatFigure(nodeQueue,recordUsedNode);
        randNodeTreeArr{m+i} = nodeQueue; 
        nextLayerNode = [nextLayerNode nodeQueue(1,:)];
        %记录用了多少点
        recordUsedNode = [recordUsedNode nodeQueue(1,:)];
    end
    currentLayerNode = nextLayerNode;
    m = size(randNodeTreeArr,2);
    randNodeTreeArr{m+1} = currentLayerNode;
    if length(recordUsedNode) == nodeCount;
        break;
    end
end
randNodeTreeArr = randNodeTreeArr';