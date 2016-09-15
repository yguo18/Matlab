function c=num_choose_command(num)
%% **********************************************************************
% num: 从脑控翻译传递的信号
% command:  脑控num相应的指令
% c: command十六进制指令转换成相应的十进制指令
% -----------------------------------------------------------------------------
switch  num
    case 1   
        command='FAFB00FE';    %获取当前版本信息
        c=fun1(command);
    case 2
        command='FAFB01FE';    %发送激活指令
        c=fun1(command);
%     case 3
%         command='FAFB0601FE';   % 虚拟遥控A挡
%         c=fun1(command);
%     case 4
%         command='FAFB0602FE';   % 虚拟遥控F挡
%         c=fun1(command);
    case 3
        command='FAFB0201FE';  %请求控制权
        c=fun1(command);
    case 4
        command='FAFB0502FE';  %一键起飞  		 	|FA FB 05 02 FE|
        c=fun1(command);
    case 5
        command='FAFB0401500000000007D00000FE';  % 上升
        c=fun1(command);
    case 6
        command='FAFB0401500000000003E80000FE';  % 下升
        c=fun1(command);
    case 7
        command='FAFB0401500000806403E80000FE';  %以1 m/s的速度向左移动
        c=fun1(command);
    case 8
        command='FAFB0401500000006403E80000FE';  %以1 m/s的速度向右移动
        c=fun1(command);
    case 9
        command='FAFB0401500064000003E80000FE';  %以1 m/s的速度向前移动
        c=fun1(command);
    case 10
        command='FAFB0401508064000003E80000FE';  %以1 m/s的速度向后移动
        c=fun1(command);
    case 11
        command='FAFB0401400000000000000000FE';  %空中静止
        c=fun1(command);
    case 12
        command='FAFB07000A0F14FE';  % 开启热点并 以高度10m 角速度15度/s 半径20m运动
        c=fun1(command);
    case 13
        command='FAFB0701FE';   %  关闭热点
        c=fun1(command);
%     case 4
%         command='FAFB0200FE';  %释放控制权   	 	|FA FB 02 00 FE | 
%         c=fun1(command);
%     case 5
%         command='FAFB0301FE';  %解锁电机        	|FA FB 03 01 FE| 
%         c=fun1(command);
%     case 6
%         command='FAFB0300FE';  %锁定电机  		 |FA FB 03 00 FE|  
%         c=fun1(command);
    case 14
        command='FAFB0501FE';  %一键返航  		 	|FA FB 05 01 FE|  
        c=fun1(command);
%     case 17
%         command='FAFB0503FE';  %一键降落  		 	|FA FB 05 03 FE|
%         c=fun1(command);
    case 15
        command='FAFB0200FE';  %释放控制权   	 	|FA FB 02 00 FE | 
        c=fun1(command);
end
end