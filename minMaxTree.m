[nodEdgUserCount,nodeCount,edgeCount,userCount,nodeArr,userArr,nodeLoadSum,userTotalNeed]=computeNodeSum();
nodeRecord = [];
maxTreeMatrx = [];
nodeDegreeSort = sortrows(nodeLoadSum,-3);
nodeRecord(1) = nodeDegreeSort(1,1);% �Ա������һ����ʼ

n1 = 2;
% ��ѭ�������еĽڵ���䵽nodeRecord
% while ~any(diff(copyNodeRecordSort) == 0) &&  ~(length(nodeRecord)==50)
while 1
    localNodeArr = [];
    ptrNodeArr = [];
    m = size(localNodeArr,1)+1;
    for i = 1:(size(nodeArr,1))
        if bitxor(any(nodeArr(i,1)==nodeRecord),any(nodeArr(i,2)==nodeRecord)) 
            localNodeArr(m,:) = nodeArr(i,:);
            ptrNodeArr(m) = i; %���ָ��nodeArr��ָ��
            m = m+1;
        end
    end
    localNodeArr = [localNodeArr,ptrNodeArr'];
    localNodeArr = sortrows(localNodeArr,-3); % ��������
    if size(localNodeArr,1)>=2  % any �÷� ���ڼ�����  any��Ҫ��~=ͬʱ�ã������׿���
        if any(localNodeArr(2:end,3) == localNodeArr(1,3)) %������������������ͬ
            a = find(localNodeArr(2:end,3) == localNodeArr(1,3)); % �ҳ�������ͬ���ڵ��У�����minlocal
            minLocalNodeArr = localNodeArr(1:a(end),:);
            minLocalNodeArr = sortrows(minLocalNodeArr,4); % �����������˵��minlocal����Ҳ�� 2 rows
            % ���������ͬ�Ļ���ִ��if  ����������˵��û�е�����ͬ�ģ�ѡ���һ��
            if size(minLocalNodeArr,1)>=2
                if any(minLocalNodeArr(2:end,4) == minLocalNodeArr(1,4)) %�����������С������ͬ��
                    a = find(minLocalNodeArr(2:end,4) == minLocalNodeArr(1,4));
                    minLocalNodeArr = minLocalNodeArr(1:a(end),:);  %�ҳ���������ͬ��������ͬ�Ľڵ��
                    %a = find(~(minLocalNodeArr==nodeRecord))
                    b = [];
                    n = 1;
                    for i = 1:size(minLocalNodeArr,1)  % �ҳ��ڵ� �߱Ƚ϶��
                        %����ֻ����һ��������
                        if bitxor(any(minLocalNodeArr(i,1)== nodeRecord), any(minLocalNodeArr(i,2)== nodeRecord))% �����һ����㲻��nodeRecod�У���¼
                            if ~any(minLocalNodeArr(i,1)== nodeRecord)
                                b(n,1) = minLocalNodeArr(i,1); % ��¼��
                                b(n,2) = minLocalNodeArr(i,5); % ��¼ָ��nodeArr��ָ��
                            else
                                 %����ڶ�������nodeRecord��
                                b(n,1) = minLocalNodeArr(i,2);
                                b(n,2) = minLocalNodeArr(i,5);
                            end
                            n = n + 1;
                        end
                    end
                    % ��nodeLoadSum���ҵ���Ӧ�ı�
                    c = [];
                    mCount = 1;
                    for i = 1:size(b,1)
                        c(mCount,1) = b(i,1);%��
                        c(mCount,2) = nodeLoadSum(b(i,1)+1,3); % ��
                        c(mCount,3) = b(i,2);% ָ��nodeArr������
                    end
                    c = sortrows(c,-2);
                    nodeRecord(n1) = c(1,1);
                    rmaxTreeMatrxSize = size(maxTreeMatrx,1);
                    %ָ��localNodeArr
                    maxTreeMatrx(rmaxTreeMatrxSize+1,:) = localNodeArr(find(localNodeArr(:,5)==c(1,3)),:);  
                else
                    %�򵥼۲���ͬ ��minLocalNodeArr��һ�е�ֵ����maxTreeMatrx
                    rmaxTreeMatrxSize = size(maxTreeMatrx,1);
                    maxTreeMatrx(rmaxTreeMatrxSize+1,:) = minLocalNodeArr(1,:);
                    %��¼node
                    if any(minLocalNodeArr(1,1)==nodeRecord) % �������nodeRecord��
                        nodeRecord(n1) = minLocalNodeArr(1,2);
                    else
                        nodeRecord(n1) = minLocalNodeArr(1,1);
                    end
                end
            else % ˵��minLocalNodeArr��һά��
                rmaxTreeMatrxSize = size(maxTreeMatrx,1);
                maxTreeMatrx(rmaxTreeMatrxSize+1,:) = localNodeArr(1,:);
                %��¼node
                if any(localNodeArr(1,1)==nodeRecord) % �������nodeRecord��
                    nodeRecord(n1) = localNodeArr(1,2);
                else
                    nodeRecord(n1) = localNodeArr(1,1);
                end
            end
        else  
            %����������ͬ ��localNodeArr�ĵ�һ��ֵ����maxTreeMatrx
            rmaxTreeMatrxSize = size(maxTreeMatrx,1);
            maxTreeMatrx(rmaxTreeMatrxSize+1,:) = localNodeArr(1,:);
            %��¼node
            if any(localNodeArr(1,1)==nodeRecord) % �������nodeRecord��
                nodeRecord(n1) = localNodeArr(1,2);
            else
                nodeRecord(n1) = localNodeArr(1,1);
            end
        end
    else %localNodeArrֻ��һά
         %����������ͬ ��localNodeArr�ĵ�һ��ֵ����maxTreeMatrx
        rmaxTreeMatrxSize = size(maxTreeMatrx,1);
        maxTreeMatrx(rmaxTreeMatrxSize+1,:) = localNodeArr(1,:);
        %��¼node
        if any(localNodeArr(1,1)==nodeRecord) % �������nodeRecord��
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
