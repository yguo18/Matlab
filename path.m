serverNode = [0,1,24];
% ɾ��ͬʱ���������������ı�
updataNodeArr = nodeArr;
size(updataNodeArr,1);
for i = 1 :size(nodeArr,1)
    if any(serverNode==nodeArr(i,1))&&any(serverNode==nodeArr(i,2))
        updataNodeArr(i,:)=[];
    end
end
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
% ���û��ڵ���ɾ���������ڵ�
recordServUserSamePoint = [];
for i = 1:userCount
    a = size(recordServUserSamePoint,1)+1;
    if any(userNode(1,i)==serverNode)
        recordServUserSamePoint(a) = userNode(1,i);
        userNode(:,i) = []; % ���û��ڵ���ɾ���������ڵ�
    end
end
%�����ѽڵ���й����������
nodeCellArr = cell(1,1);
for i = 1:size(userNode,2);
    adjacentNodeCp = adjacentNode
    currentNode = userNode(1,i);
    [a,boolen] = compareRepeatCount(adjacentNodeCp{currentNode + 1},serverNode);
    if boolen  % ���Ϊ��Ļ���˵����һ������������ڵ�,�ҳ��ڵ�·��
        possiblePath = updataNodeArr(a(2,1),:)
        diff = updataNodeArr(a(2,1),3) - userNode(2,i)
        %�ж�·���ϵ������Ƿ����㵱ǰ�û�����
        number = find(updataNodeArr(:,5)==a(2,1));
        if diff>0 %���ǿ���·��
            updataNodeArr(number,3) = diff;
        elseif diff == 0
                updataNodeArr(number,:) = [];
        else
            break
        end         
    else  % ���� ���н�� ���ڽӵ�
        nextNode = [currentNode a(1,:)];
    end
    break
end