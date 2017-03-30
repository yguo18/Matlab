function [n1,b] = reOrderNode(n1,nodeRecord)
% 找相邻结点边，并求出边
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
            b(1,n) = n1(i,1); % 记录点
            b(2,n) = n1(i,5); % 记录指向nodeArr的指针
            b(3,n) = n1(i,4);  % 记录单价
            b(4,n) = n1(i,3); % 记录容量
        else
             %否则第二个不在nodeRecord中
            b(1,n) = n1(i,2);
            b(2,n) = n1(i,5);
            b(3,n) = n1(i,4);
            b(4,n) = n1(i,3);
        end
    end
end