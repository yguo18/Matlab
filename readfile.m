function caseData = readfile(path)
    %path = 'E:\tmp\HW\ReadFile\case_example\case0.txt';
    fid = fopen(path,'r');
    caseData.nodEdgUserCount = zeros(1,3);
    b = fgets(fid);
    caseData.nodEdgUserCount = str2num(b);
    caseData.nodeCount = caseData.nodEdgUserCount(1);
    caseData.edgeCount = caseData.nodEdgUserCount(2);
    caseData.userCount = caseData.nodEdgUserCount(3);
    caseData.nodeArr = zeros(caseData.edgeCount,4);
    caseData.userArr = zeros(caseData.userCount,3);
    i = 1;
    j = 1;
    while ~feof(fid)
        b = fgets(fid);
        b = str2num(b);
        if ~isempty(b) && size(b,2)==1
            caseData.serverUnitCost=b;
        end
        if ~isempty(b) && size(b,2)==4
            caseData.nodeArr(i,:)= b;
            i = i+1;
        end
        if ~isempty(b) && size(b,2)==3
            caseData.userArr(j,:) = b;
            j = j+1;
        end
    end
end
        