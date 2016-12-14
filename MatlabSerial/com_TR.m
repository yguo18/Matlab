clear,clc;
delete(instrfind);  % ������д���
strSerialPortNum = input('���ںţ����֣���');
strSerialPortName =sprintf('%s%d','COM',strSerialPortNum);
s = serial(strSerialPortName);
%s = serial('com6');
set(s, 'baudrate', 115200);
s.Terminator='CR'; %������ֹ��ΪCR���س�������ȱʡΪLF�����з���
s.Timeout=0.6;   % ����һ�ζ���д����������ʱ��Ϊ0.6s,ȱʡֵΪ10s
s.ReadAsyncMode = 'continuous';    %�첽ͨ��ʱ����������������
fopen(s);
for i=-2:0
    command=num_choose_command(i);   
    disp_readInfo(s,command);
end
while 1                 
%------------------------------------------------------
%       �Կزɼ�
%          |
%          v
%         num

    num=input('�Կ�ָ�');
%-------------------------------------------------------
%   ѡָ
    command=num_choose_command(num);
%   ��ָ
    disp_readInfo(s,command);
   if num==5||num==9      %����ֹͣ  ����ѭ�� 
        command=num_choose_command(13);
        disp_readInfo(s,command);
        stopasync(s);
        break;
   end

end
fclose(s);
delete(s);


