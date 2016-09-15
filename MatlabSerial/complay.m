clear,clc;
delete(instrfind);  % 清楚所有串口
strSerialPortNum = input('串口号（数字）：');
strSerialPortName =sprintf('%s%d','COM',strSerialPortNum);
s = serial(strSerialPortName);
%s = serial('com6');
set(s, 'baudrate', 115200);
s.Terminator='CR'; %设置终止符为CR（回车符），缺省为LF（换行符）
s.Timeout=0.6;   % 设置一次读或写操作最大完成时间为0.6s,缺省值为10s
s.ReadAsyncMode = 'continuous';    %异步通信时，连续读串口数据
% set(s, 'BytesAvailableFcn', {'instrcallback'});
% set(s,'BytesAvailableFcnCount',30);
% set(s,'BytesAvailableFcnMode','byte');
fopen(s);

while 1                 
%------------------------------------------------------
%       脑控采集
%          |
%          v
%         num

    num=input('脑控指令：');
%-------------------------------------------------------
%   选指
    command=num_choose_command(num);
%   传指
%   fprintf(s, '%s',command);
%   fprintf(s,command);
    fwrite(s, command, 'async');
    
%   receiveData = fread(s,10)';
%   接收响应信息
%     while s.BytesAvailable
%         fscanf(s)
%     end
    fscanf(s)
  
%   n_bytes = get(s,'BytesAvailable');     %数据总数量
%   if n_bytes      %有效读取 防止Matlab延迟进入或误进入
%        Data = fread(s, n_bytes, 'uchar')';     % 读走数据并存入Data中 直接为十进制数值形式
%   end

   if num==15      %设置停止  跳出循换 
      stopasync(s);
      break;
   end

end
fclose(s);
delete(s);
% delete(instrfind);  % 清楚所有串口

