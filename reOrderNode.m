function [n1,b] = reOrderNode(n1,nodeRecord)
% �����ڽ��ߣ��������
    n1 = sortrows(n1,4);
    b = unique(n1(:,4))';
    for i = 1:length(b)
        a = find(n1(:,4)==b(i));
        n1(a(1):a(end),:) = sortrows(n1(a(1):a(end),:),-3);
    end
    b = [];
    for i = 1:size(n1,1)
        n = size(b,2)+1;
        if ~any(n1(i,1) == nodeRecord)
            b(1,n) = n1(i,1); % ��¼��
            b(2,n) = n1(i,5); % ��¼ָ��nodeArr��ָ��
            b(3,n) = n1(i,4);  % ��¼����
            b(4,n) = n1(i,3); % ��¼����
        else
             %����ڶ�������nodeRecord��
            b(1,n) = n1(i,2);
            b(2,n) = n1(i,5);
            b(3,n) = n1(i,4);
            b(4,n) = n1(i,3);
        end
    end
end