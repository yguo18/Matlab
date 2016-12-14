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
%��ʼ��
for i=-2:0
    command=num_choose_command(i);   
    fwrite(s, command, 'async');         %  ����ָ��
    data=fscanf(s);                      %  ��ȡ������Ϣ
    while isempty(data)                  %  �жϷ�����Ϣ�Ƿ�Ϊ��
        fwrite(s, command, 'async');     %  ���Ϊ�����ڷ���һ����Ӧ��ָ��
        data=fscanf(s);                  %  ֱ���ɹ�������Ϣ
    end
    disp(data);                          %  ��ʾ������Ϣ
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
    fwrite(s, command, 'async');         %  ����ָ��
    data=fscanf(s);                      %  ��ȡ������Ϣ
    while isempty(data)                  %  �жϷ�����Ϣ�Ƿ�Ϊ��
        fwrite(s, command, 'async');     %  ���Ϊ�����ڷ���һ����Ӧ��ָ��
        data=fscanf(s);                  %  ֱ���ɹ�������Ϣ
    end
    disp(data);                          %  ��ʾ������Ϣ
%---------------------------------------
%     if num>1
%        for i=1:3
%           fwrite(s, command, 'async');
%           fscanf(s)
%        end
%     else
%           fwrite(s, command, 'async');
%           fscanf(s)
%     end
%-----------------------------------------
%   ������Ӧ��Ϣ
%    delay(100);
%    fscanf(s)
  
%   n_bytes = get(s,'BytesAvailable');     %����������
%   if n_bytes      %��Ч��ȡ ��ֹMatlab�ӳٽ���������
%        Data = fread(s, n_bytes, 'char=>uchar')';     % �������ݲ�����Data�� ֱ��Ϊʮ������ֵ��ʽ
%   end

   if num==5||num==9      %����ֹͣ  ����ѭ�� 
        command=num_choose_command(13);
        fwrite(s, command, 'async');
        data=fscanf(s);
        while isempty(data)
            fwrite(s, command, 'async');
            data=fscanf(s);
        end
        disp(data);
        stopasync(s);
        break;
   end

end
fclose(s);
delete(s);

