function int_to_hex(a)
%% ���� ������ת������Ӧ��ʮ��������
% a����������
% aԪ�صķ�Χ   -2^15 ~ 2^15-1
%               -32768~32767
% find ���ص��Ƕ�Ӧ����
m=length(a);
a=a*100;
a((find(a<0)))=abs(a((find(a<0))))+32768;
c=cell(1,m);
for i=1:m
    c{i}=dec2hex(a(i));
end
disp(c);
end