[nodEdgUserCount,nodeCount,edgeCount,userCount,nodeArr,userArr,nodeLoadSum,userTotalNeed,serverUnitCost]=computeNodeSum();
updataNodeArr = nodeArr;
sortrows(userArr,-2)
userNode = userArr(:,2:3)';  %�û��ڵ�
% �ѱ߱��
tmp = 1:size(updataNodeArr,1);
updataNodeArr = [updataNodeArr tmp'];
% �����ڵ����ɸѡ��
% ÿһ��cell{i}�������У���һ�м�¼��i-1�����ڵ㣬�ڶ��м�¼��updataNodeArr�еı�ż�i-1���ڽӵ�ı�,���ҽ��еĽڵ������
adjacentNode = cell(nodeCount,1);
for i = 0:nodeCount-1
   adjaNodeArr = [];
   for j = 1:size(updataNodeArr,1)  % �����еĽڵ��������ɸѡһ���Ѽ�¼�ĵ��δ��¼�ĵ�
       m = size(adjaNodeArr,1)+1;
       if bitxor(updataNodeArr(j,1)==i,updataNodeArr(j,2)==i)  %������Ƚ�
           adjaNodeArr(m,:) = updataNodeArr(j,:);   
       end
   end
   [adjaNodeArr ,b] = reOrderNode(adjaNodeArr,i);
   b(2,:) = [];
   b(4,:) = 0;  % �Ժ�������¼������
   adjacentNode{i+1} = b;  % ��¼�����е�����1 ��  2 ���� 3 ����  4������
end
% priceArr = cell(1,1);
priceArr = [];
capArr = [];
userNode(3,:) = 1 - userNode(2,:)./sum(userNode(2,:),2);
for i = 1:length(userNode)
    randNode = userNode(1,i);
    currentLayerNode(1,1) = randNode;
    currentLayerNode(2,1) = 0;  % ��¼����
    currentLayerNode(3,1) = userNode(2,i); % ��¼����
    currentLayerNode(4,1) = userNode(3,i);
    recordUsedNode = [];
    recordUsedNode = [recordUsedNode currentLayerNode]; %��¼ʹ�õĽڵ�
    m =i;
    while 1
        nextLayerNode = [];
        for i = 1:size(currentLayerNode,2) % ��ǰ��ÿ���ڵ����һ��ڵ�
            % ������adjacentNode��ȡ����ǰ�����ڽӵ�
            nodeQueue = [];
            nodeQueue = adjacentNode{currentLayerNode(1,i)+1};
            %ɾ���ظ��㳴��   ji ��nodeQueue��ɾ��recordUserNode�еĵ㣻
            nodeQueue = removeRepeatFigure(nodeQueue,recordUsedNode(1,:));
            if isempty(nodeQueue)
                continue;
            end
            nodeQueue(2,:) = nodeQueue(2,:) + currentLayerNode(2,i); % ����ڵ�֮��ĵ��ۺ�
            nodeQueue(3,:) = findMinPathCap(nodeQueue(3,:),currentLayerNode(3,i));
            nodeQueue = reletivity(nodeQueue,serverUnitCost);
            nextLayerNode = [nextLayerNode nodeQueue];
            %��¼���˶��ٵ�
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
factor1 = sum(capArr,2); %����
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