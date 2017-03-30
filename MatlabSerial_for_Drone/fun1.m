function c=fun1(command)

% command ='FAFB00FE';
%œ‘ æ÷∏¡Ó
m=length(command);
z=cell(1,m/2);
c=zeros(1,m/2);
for i=1:m/2
    z{i}=strcat('0x',command(2*i-1:2*i));
    c(1,i)=hex2dec(command(2*i-1:2*i));
end
disp(z);
% disp(c);
end