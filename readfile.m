path = 'E:\tmp\HW\ReadFile\case_example\case0.txt';
caseData = fopen(path,'r');
nodEdgUserCount = zeros(1,3);
b = fgets(caseData);
nodEdgUserCount = str2num(b);
nodeCount = nodEdgUserCount(1);
edgeCount = nodEdgUserCount(2);
userCount = nodEdgUserCount(3);
nodeArr = zeros(edgeCount,4);
userArr = zeros(userCount,3);
i = 1;
j = 1;
while ~feof(caseData)
    b = fgets(caseData);
    b = str2num(b);
    if ~isempty(b) && size(b,2)==1
        serverUnitCost=b;
    end
    if ~isempty(b) && size(b,2)==4
        nodeArr(i,:)= b;
        i = i+1;
    end
    if ~isempty(b) && size(b,2)==3
        userArr(j,:) = b;
        j = j+1;
    end
end
        