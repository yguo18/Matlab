% nodeRecord = zeros(1,50);
% nodeRecord(1,:) = NaN;
nodeRecord = [];
maxTreeMatrx = [];
% nodeArrSort = sortrows(nodeArr,-3);
nodeDegreeSort = sortrows(nodeLoadSum,-3);
nodeRecord = nodeDegreeSort(1,1);% �Ա������һ����ʼ
localNodeArr = [];
copyNodeRecordSort = [];
n = 2;
% ��ѭ�������еĽڵ���䵽nodeRecord
% while ~any(diff(copyNodeRecordSort) == 0) &&  ~(length(nodeRecord)==50)
while ~(length(nodeRecord)==50)
    m = size(localNodeArr,1)+1;
    for i = 1:(size(nodeArr,1))
        if nodeArr(i,1)==nodeRecord(end) || nodeArr(i,2)==nodeRecord(end)
            localNodeArr(m,:) = nodeArr(i,:);
            m = m+1;
        end
    end
    localNodeArr = sortrows(localNodeArr,-3); % ��������
    % ���������ͬ��ѡ�񵥼�С����һ��
    % minLocalNodeArr��¼������ͬ��
    minLocalNodeArr = [];
    % ��������ѡ���һ��
    minLocalNodeArr = localNodeArr(1,:);
    if any(diff(localNodeArr(:,3)))==0 && size(localNodeArr,1)>=2 
        j = 1;
        for i = 1: size(localNodeArr,1)-1
            if localNodeArr(i,3)==localNodeArr(i+1,3)  %���������ͬ
                minLocalNodeArr(j+1,:) = localNodeArr(i+1,:);
                i = i + 1;
                j = j + 1;
            end
        end
    end
    % ����ѡ�񵥼۽�С��һ��
    minLocalNodeArr = sortrows(minLocalNodeArr,4); % ����������
    % ��¼������ͬ��
    minLocalNodeCostArr = []; %��С�ľֲ�������
    % ��������ѡ���һ��
    minLocalNodeCostArr = minLocalNodeArr(1,:); 
    %��������ͬ��������ѡ�񵥼���ͬ��
    if any(diff(minLocalNodeArr(:,4)))==0 && size(minLocalNodeArr,1)>=2
        j = 1;
        for i = 1:size(minLocalNodeArr,1)-1
            if minLocalNodeArr(i,4)==minLocalNodeArr(i+1,4)
                minLocalNodeCostArr(j+1,:) = minLocalNodeArr(i+1,:);
                i = i + 1;
                j = j + 1;
            end
        end
    end
    %�������Ҳ��ͬ��ѡ��߱Ƚ϶�ĵ�
    if size(minLocalNodeCostArr,1)>=2
        %����֪�������ĸ��ڵ�
        a = [];%��ʱ����
        m = 1;
        for i = 1 :size(minLocalNodeCostArr,1)
            if ~(minLocalNodeCostArr(i,1) == nodeRecord(end))
                a(m) = minLocalNodeCostArr(i,1);
                m = m + 1;
            end
            if ~(minLocalNodeCostArr(i,2) == nodeRecord(end))
                a(m) = minLocalNodeCostArr(i,2);
                m = m + 1;
            end
          
        end
        %�ڵ��������ı�
        b = [];
        for i = 1:length(a)
            % b(i,1) = a(i);
            b(i,1) = nodeLoadSum(a(1)+1,1); % ��¼��
            b(i,2) = nodeLoadSum(a(1)+1,3); % ��¼��
        end
        %���� ѡ�������Ľڵ�
        b = sortrows(b,-2);
    else  % minLocal ��һ�е�
        if ~(minLocalNodeCostArr(1,1) == nodeRecord(end))
            b(1,1) = minLocalNodeCostArr(1,1);
        end
        if ~(minLocalNodeCostArr(1,2) == nodeRecord(end))
            b(1,1) = minLocalNodeCostArr(1,2);
        end
        b(1,2) = nodeLoadSum(b(1,1)+1,3);
    end
    for i = 1:size(localNodeArr,1)-1
        if (localNodeArr(i,1)==b(1,1) && localNodeArr(i,2)==nodeRecord(end)) || (localNodeArr(i,2)==b(1,1) && localNodeArr(i,1)==nodeRecord(end))
            q = size(maxTreeMatrx,1)+1;
            maxTreeMatrx(q,:) = localNodeArr(i,:);
            localNodeArr(i,:)= [];%ɾ�����б�
        end
    end
    % ��nodeArr��ҲҪɾ��������
    for i = 1:size(nodeArr,1)-1
        if (nodeArr(i,1)==b(1,1) && nodeArr(i,2)==nodeRecord(end)) || (nodeArr(i,2)==b(1,1) && nodeArr(i,1)==nodeRecord(end))
            nodeArr(i,:)= [];%ɾ�����б�
        end
    end
    if length(nodeRecord)==50
        break;
    end
    if any(nodeRecord==b(1,1))
        continue;
    end
    nodeRecord(1,n) = b(1,1);
    n = n + 1;
    % ���ƽڵ� ���д�С���������
    copyNodeRecordSort = sort(nodeRecord);
    
end
