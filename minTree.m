% nodeRecord = zeros(1,50);
% nodeRecord(1,:) = NaN;
nodeRecord = [];
maxTreeMatrx = [];
% nodeArrSort = sortrows(nodeArr,-3);
nodeDegreeSort = sortrows(nodeLoadSum,-3);
nodeRecord = nodeDegreeSort(1,1);% 以边数最多一条开始
localNodeArr = [];
copyNodeRecordSort = [];
n = 2;
% 大循环，所有的节点填充到nodeRecord
% while ~any(diff(copyNodeRecordSort) == 0) &&  ~(length(nodeRecord)==50)
while ~(length(nodeRecord)==50)
    m = size(localNodeArr,1)+1;
    for i = 1:(size(nodeArr,1))
        if nodeArr(i,1)==nodeRecord(end) || nodeArr(i,2)==nodeRecord(end)
            localNodeArr(m,:) = nodeArr(i,:);
            m = m+1;
        end
    end
    localNodeArr = sortrows(localNodeArr,-3); % 按带宽降序
    % 如果容量相同，选择单价小的那一组
    % minLocalNodeArr记录容量相同的
    minLocalNodeArr = [];
    % 在排序中选择第一个
    minLocalNodeArr = localNodeArr(1,:);
    if any(diff(localNodeArr(:,3)))==0 && size(localNodeArr,1)>=2 
        j = 1;
        for i = 1: size(localNodeArr,1)-1
            if localNodeArr(i,3)==localNodeArr(i+1,3)  %如果容量相同
                minLocalNodeArr(j+1,:) = localNodeArr(i+1,:);
                i = i + 1;
                j = j + 1;
            end
        end
    end
    % 排序选择单价较小的一个
    minLocalNodeArr = sortrows(minLocalNodeArr,4); % 按单价升序
    % 记录单价相同的
    minLocalNodeCostArr = []; %更小的局部化矩阵
    % 在排序中选择第一个
    minLocalNodeCostArr = minLocalNodeArr(1,:); 
    %在容量相同的数据中选择单价相同的
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
    %如果单价也相同，选择边比较多的点
    if size(minLocalNodeCostArr,1)>=2
        %首先知道含有哪个节点
        a = [];%临时矩阵
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
        %节点所包含的边
        b = [];
        for i = 1:length(a)
            % b(i,1) = a(i);
            b(i,1) = nodeLoadSum(a(1)+1,1); % 记录点
            b(i,2) = nodeLoadSum(a(1)+1,3); % 记录边
        end
        %排序 选出边最多的节点
        b = sortrows(b,-2);
    else  % minLocal 是一行的
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
            localNodeArr(i,:)= [];%删除已有边
        end
    end
    % 在nodeArr里也要删除那条边
    for i = 1:size(nodeArr,1)-1
        if (nodeArr(i,1)==b(1,1) && nodeArr(i,2)==nodeRecord(end)) || (nodeArr(i,2)==b(1,1) && nodeArr(i,1)==nodeRecord(end))
            nodeArr(i,:)= [];%删除已有边
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
    % 复制节点 进行从小到大的排序
    copyNodeRecordSort = sort(nodeRecord);
    
end
