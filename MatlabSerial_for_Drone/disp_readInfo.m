function disp_readInfo(s,command)
    fwrite(s, command, 'async');         %  发送指令
    data=fscanf(s);                      %  读取返回信息
    while isempty(data)                  %  判断返回信息是否为空
        fwrite(s, command, 'async');     %  如果为空则在发送一次相应的指令
        data=fscanf(s);                  %  直至成功返回信息
    end
    disp(data);                          %  显示返回信息
end