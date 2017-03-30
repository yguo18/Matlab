function int_to_hex(a)
%% 功能 符号数转换成相应的十六进制数
% a必须是数组
% a元素的范围   -2^15 ~ 2^15-1
%               -32768~32767
% find 返回的是对应的列
m=length(a);
a=a*100;
a((find(a<0)))=abs(a((find(a<0))))+32768;
c=cell(1,m);
for i=1:m
    c{i}=dec2hex(a(i));
end
disp(c);
end