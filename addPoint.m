function m = addPoint(m,nodeCount)
%%%²¹µã²Ù×÷
    for i = 0:nodeCount-1;
        if ~any(i == m(:,1))
            n = size(m,1);
            m(n+1,1) = i;
            m(n+1,2) = 0;
        end
    end
end