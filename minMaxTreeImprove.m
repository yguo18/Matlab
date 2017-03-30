[nodEdgUserCount,nodeCount,edgeCount,userCount,nodeArr,userArr,nodeLoadSum,userTotalNeed]=computeNodeSum();
nodeRecord = []; %记录已经遍历过的点
maxTreeMatrx = []; %记录最小树
nodeDegreeSort = sortrows(nodeLoadSum,-3);
nodeRecord(1) = nodeDegreeSort(1,1);% 以边数最多一条开始

n1 = 2;
% 大循环，所有的节点填充到nodeRecord
% while ~any(diff(copyNodeRecordSort) == 0) &&  ~(length(nodeRecord)==50)
while 1
    localNodeArr = [];
    ptrNodeArr = [];
    m = size(localNodeArr,1)+1;
    for i = 1:(size(nodeArr,1))
        if bitxor(any(nodeArr(i,1)==nodeRecord),any(nodeArr(i,2)==nodeRecord)) 
            localNodeArr(m,:) = nodeArr(i,:);
            ptrNodeArr(m) = i; %添加指向nodeArr的指针
            m = m+1;
        end
    end
    localNodeArr = [localNodeArr,ptrNodeArr'];
    localNodeArr = sortrows(localNodeArr,4); % 按单价升序
    if size(localNodeArr,1)>=2  % any 用法 存在即合理  any不要和~=同时用，不容易控制
        if any(localNodeArr(2:end,4) == localNodeArr(1,4)) %如果存在与单价相同
            a = find(localNodeArr(2:end,4) == localNodeArr(1,4)); % 找出单价相同所在的行，放在minlocal
            minLocalNodeArr = localNodeArr(1:a(end),:);
            minLocalNodeArr = sortrows(minLocalNodeArr,-3); % 如果条件成立说明minlocal至少也是 2 rows
            if size(minLocalNodeArr,1)>=2
                % 如果容量相同的话，执行if  否则跳过，说明没有容量相同的，选择第一行
                if any(minLocalNodeArr(2:end,3) == minLocalNodeArr(1,3)) %如果存在与最大容量相同的
                    a = find(minLocalNodeArr(2:end,3) == minLocalNodeArr(1,3));
                    minLocalNodeArr = minLocalNodeArr(1:a(end),:);  %找出了容量相同，单价相同的节点边
                    %a = find(~(minLocalNodeArr==nodeRecord))
                    b = [];
                    n = 1;
                    for i = 1:size(minLocalNodeArr,1)  % 找出节点 边比较多的
                        %有且只能有一个在里面
                        if bitxor(any(minLocalNodeArr(i,1)== nodeRecord), any(minLocalNodeArr(i,2)== nodeRecord))% 如果第一个结点不在nodeRecod中，记录
                            if ~any(minLocalNodeArr(i,1)== nodeRecord)
                                b(n,1) = minLocalNodeArr(i,1); % 记录点
                                b(n,2) = minLocalNodeArr(i,5); % 记录指向nodeArr的指针
                            else
                                 %否则第二个不在nodeRecord中
                                b(n,1) = minLocalNodeArr(i,2);
                                b(n,2) = minLocalNodeArr(i,5);
                            end
                            n = n + 1;
                        end
                    end
                    % 在nodeLoadSum中找到对应的边
                    c = [];
                    for i = 1:size(b,1)
                        c(i,1) = b(i,1);%点
                        c(i,2) = nodeLoadSum(b(i,1)+1,3); % 边
                        c(i,3) = b(i,2);% 指向nodeArr的数组``
                    end
                    c = sortrows(c,-2); % 按边排序
                    nodeRecord(n1) = c(1,1);
                    rmaxTreeMatrxSize = size(maxTreeMatrx,1);
                    %指向localNodeArr
                    maxTreeMatrx(rmaxTreeMatrxSize+1,:) = localNodeArr(find(localNodeArr(:,5)==c(1,3)),:); 
                else
                    %则容量不相同 把minLocalNodeArr第一行的值存入maxTreeMatrx
                    rmaxTreeMatrxSize = size(maxTreeMatrx,1);
                    maxTreeMatrx(rmaxTreeMatrxSize+1,:) = minLocalNodeArr(1,:);
                    %记录node
                    if any(minLocalNodeArr(1,1)==nodeRecord) % 点包含在nodeRecord中
                        nodeRecord(n1) = minLocalNodeArr(1,2);
                    else
                        nodeRecord(n1) = minLocalNodeArr(1,1);
                    end
                end
            else  %minLocalNodeArr是一维的
                rmaxTreeMatrxSize = size(maxTreeMatrx,1);
                maxTreeMatrx(rmaxTreeMatrxSize+1,:) = minLocalNodeArr(1,:);
                %记录node
                if any(minLocalNodeArr(1,1)==nodeRecord) % 点包含在nodeRecord中
                    nodeRecord(n1) = minLocalNodeArr(1,2);
                else
                    nodeRecord(n1) = minLocalNodeArr(1,1);
                end
            end
        else
            %则单价不相同 把localNodeArr的第一行值存入maxTreeMatrx
            rmaxTreeMatrxSize = size(maxTreeMatrx,1);
            maxTreeMatrx(rmaxTreeMatrxSize+1,:) = localNodeArr(1,:);
            %记录node
            if any(localNodeArr(1,1)==nodeRecord) % 点包含在nodeRecord中
                nodeRecord(n1) = localNodeArr(1,2);
            else
                nodeRecord(n1) = localNodeArr(1,1);
            end
        end
    else  %说明localNodeArr是一维的
        rmaxTreeMatrxSize = size(maxTreeMatrx,1);
        maxTreeMatrx(rmaxTreeMatrxSize+1,:) = localNodeArr(1,:);
        %记录node
        if any(localNodeArr(1,1)==nodeRecord) % 点包含在nodeRecord中
            nodeRecord(n1) = localNodeArr(1,2);
        else
            nodeRecord(n1) = localNodeArr(1,1);
        end 
    end
    if n1==nodeCount
        break;
    end
    n1 = n1 + 1;
end
