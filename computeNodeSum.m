 path = 'E:\tmp\HW\ReadFile\case_example\case5.txt'; % file path
 caseData = readfile(path);
 % first col record node,second col record node load, third record
 % degree,four col record usernode
 nodeLoadSum = zeros(nodeCount,4); 
 a=0:nodeCount-1;
 nodeLoadSum(:,1) = a';
 nodeLoadSum(:,4) =NaN;
 userTotalNeed = 0;
for i = 1:edgeCount
    nodeLoadSum(nodeArr(i,1)+1,2) = nodeLoadSum(nodeArr(i,1)+1,2) + nodeArr(i,3);
    nodeLoadSum(nodeArr(i,1)+1,3) = nodeLoadSum(nodeArr(i,1)+1,3) + 1;
    nodeLoadSum(nodeArr(i,2)+1,2) = nodeLoadSum(nodeArr(i,2)+1,2) + nodeArr(i,3);
    nodeLoadSum(nodeArr(i,2)+1,3) = nodeLoadSum(nodeArr(i,2)+1,3) + 1;
end
for i = 1:userCount
    % node touch usernode need to add user's demand
    nodeLoadSum(userArr(i,2)+1,2) = nodeLoadSum(userArr(i,2)+1,2) + userArr(i,3);
    nodeLoadSum(userArr(i,2)+1,4) = userArr(i,2);   % node <--> usernode
    userTotalNeed = userTotalNeed + userArr(i,3);
end
sortrows(nodeLoadSum,-2); % second col grade down : loadCount sort
sortrows(nodeLoadSum,-3); % third col grade down : degree sort
userTotalNeed;