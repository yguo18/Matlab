% serverNode = [0,3,22];
% ɾ��ͬʱ���������������ı�
updataNodeArr = nodeArr;
size(updataNodeArr,1);
% for i = 1 :size(nodeArr,1)
%     if any(serverNode==nodeArr(i,1))&&any(serverNode==nodeArr(i,2))
%         updataNodeArr(i,:)=[];
%     end
% end
userNode = userArr(:,2:3)';  %�û��ڵ�
% �ѱ߱��
tmp = 1:size(updataNodeArr,1);
updataNodeArr = [updataNodeArr tmp'];
% �����ڵ����ɸѡ��
% ÿһ��cell{i}�������У���һ�м�¼��i-1�����ڵ㣬�ڶ��м�¼��updataNodeArr�еı�ż�i-1���ڽӵ�ı�,���ҽ��еĽڵ������
adjacentNode = cell(nodeCount,1);
for i = 0:nodeCount-1
   adjaNodeArr = [];
   for j = 1:size(updataNodeArr,1)
       m = size(adjaNodeArr,1)+1;
       if bitxor(updataNodeArr(j,1)==i,updataNodeArr(j,2)==i)  %������Ƚ�
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
% recordUsedNode = [recordUsedNode currentLayerNode]; %��¼ʹ�õĽڵ�
% 
% while 1
%     nextLayerNode = [];
%     for i = 1:length(currentLayerNode)
%         m = size(randNodeTreeArr,2);
%         % ������adjacentNode��ȡ����ǰ�����ڽӵ�
%         nodeQueue = adjacentNode{currentLayerNode(i)+1};
%         %ɾ���ظ��㳴��   ji ��nodeQueue��ɾ��recordUserNode�еĵ㣻
%         nodeQueue = removeRepeatFigure(nodeQueue,recordUsedNode);
%         randNodeTreeArr{m+i} = nodeQueue; 
%         nextLayerNode = [nextLayerNode nodeQueue(1,:)];
%         %��¼���˶��ٵ�
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
recordUsedNode = [recordUsedNode currentLayerNode]; %��¼ʹ�õĽڵ�

while 1
    nextLayerNode = [];
    for i = 1:length(currentLayerNode) % ��ǰ��ÿ���ڵ����һ��ڵ�
        m = size(randNodeTreeArr,2);
        % ������adjacentNode��ȡ����ǰ�����ڽӵ�
        nodeQueue = adjacentNode{currentLayerNode(i)+1};
        %ɾ���ظ��㳴��   ji ��nodeQueue��ɾ��recordUserNode�еĵ㣻
        nodeQueue = removeRepeatFigure(nodeQueue,recordUsedNode);
        randNodeTreeArr{m+i} = nodeQueue; 
        nextLayerNode = [nextLayerNode nodeQueue(1,:)];
        %��¼���˶��ٵ�
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