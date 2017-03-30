path = 'E:\tmp\HW\case_example\0 Primary\0.txt';
[nodEdgUserCount,nodeCount,edgeCount,userCount,nodeArr,userArr,nodeLoadSum,userTotalNeed,serverUnitCost]=computeNodeSum(path);
updataNodeArr = nodeArr;
guoyi = sortrows(userArr,-2);
a = guoyi(:,2);
b = unique(a);
if length(b) == length(a)
    ah = 1
else
    ah = 0
end
