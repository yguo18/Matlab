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
fopen(s);
% for i=-2:0
%     command=num_choose_command(i);   
%     disp_readInfo(s,command);
% end
for num = -2:13          
%   选指
    command=num_choose_command(num);
%   传指
    disp_readInfo(s,command);
    if num==5||num==9      %设置停止  跳出循换 
        command=num_choose_command(13);
        disp_readInfo(s,command);
        stopasync(s);
        break;
    end
%    delay(10000);
    pause(2);  % 设置延迟，delay  时间 /s
end
fclose(s);
delete(s);
