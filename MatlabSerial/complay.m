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
% set(s, 'BytesAvailableFcn', {'instrcallback'});
% set(s,'BytesAvailableFcnCount',30);
% set(s,'BytesAvailableFcnMode','byte');
fopen(s);

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
%   fprintf(s, '%s',command);
%   fprintf(s,command);
    fwrite(s, command, 'async');
    
%   receiveData = fread(s,10)';
%   ������Ӧ��Ϣ
%     while s.BytesAvailable
%         fscanf(s)
%     end
    fscanf(s)
  
%   n_bytes = get(s,'BytesAvailable');     %����������
%   if n_bytes      %��Ч��ȡ ��ֹMatlab�ӳٽ���������
%        Data = fread(s, n_bytes, 'uchar')';     % �������ݲ�����Data�� ֱ��Ϊʮ������ֵ��ʽ
%   end

   if num==15      %����ֹͣ  ����ѭ�� 
      stopasync(s);
      break;
   end

end
fclose(s);
delete(s);
% delete(instrfind);  % ������д���

