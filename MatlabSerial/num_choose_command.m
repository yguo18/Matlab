function c=num_choose_command(num)
%% **********************************************************************
% num: ���Կط��봫�ݵ��ź�
% command:  �Կ�num��Ӧ��ָ��
% c: commandʮ������ָ��ת������Ӧ��ʮ����ָ��
% -----------------------------------------------------------------------------
switch  num
    case 1   
        command='FAFB00FE';    %��ȡ��ǰ�汾��Ϣ
        c=fun1(command);
    case 2
        command='FAFB01FE';    %���ͼ���ָ��
        c=fun1(command);
%     case 3
%         command='FAFB0601FE';   % ����ң��A��
%         c=fun1(command);
%     case 4
%         command='FAFB0602FE';   % ����ң��F��
%         c=fun1(command);
    case 3
        command='FAFB0201FE';  %�������Ȩ
        c=fun1(command);
    case 4
        command='FAFB0502FE';  %һ�����  		 	|FA FB 05 02 FE|
        c=fun1(command);
    case 5
        command='FAFB0401500000000007D00000FE';  % ����
        c=fun1(command);
    case 6
        command='FAFB0401500000000003E80000FE';  % ����
        c=fun1(command);
    case 7
        command='FAFB0401500000806403E80000FE';  %��1 m/s���ٶ������ƶ�
        c=fun1(command);
    case 8
        command='FAFB0401500000006403E80000FE';  %��1 m/s���ٶ������ƶ�
        c=fun1(command);
    case 9
        command='FAFB0401500064000003E80000FE';  %��1 m/s���ٶ���ǰ�ƶ�
        c=fun1(command);
    case 10
        command='FAFB0401508064000003E80000FE';  %��1 m/s���ٶ�����ƶ�
        c=fun1(command);
    case 11
        command='FAFB0401400000000000000000FE';  %���о�ֹ
        c=fun1(command);
    case 12
        command='FAFB07000A0F14FE';  % �����ȵ㲢 �Ը߶�10m ���ٶ�15��/s �뾶20m�˶�
        c=fun1(command);
    case 13
        command='FAFB0701FE';   %  �ر��ȵ�
        c=fun1(command);
%     case 4
%         command='FAFB0200FE';  %�ͷſ���Ȩ   	 	|FA FB 02 00 FE | 
%         c=fun1(command);
%     case 5
%         command='FAFB0301FE';  %�������        	|FA FB 03 01 FE| 
%         c=fun1(command);
%     case 6
%         command='FAFB0300FE';  %�������  		 |FA FB 03 00 FE|  
%         c=fun1(command);
    case 14
        command='FAFB0501FE';  %һ������  		 	|FA FB 05 01 FE|  
        c=fun1(command);
%     case 17
%         command='FAFB0503FE';  %һ������  		 	|FA FB 05 03 FE|
%         c=fun1(command);
    case 15
        command='FAFB0200FE';  %�ͷſ���Ȩ   	 	|FA FB 02 00 FE | 
        c=fun1(command);
end
end