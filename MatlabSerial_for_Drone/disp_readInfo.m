function disp_readInfo(s,command)
    fwrite(s, command, 'async');         %  ����ָ��
    data=fscanf(s);                      %  ��ȡ������Ϣ
    while isempty(data)                  %  �жϷ�����Ϣ�Ƿ�Ϊ��
        fwrite(s, command, 'async');     %  ���Ϊ�����ڷ���һ����Ӧ��ָ��
        data=fscanf(s);                  %  ֱ���ɹ�������Ϣ
    end
    disp(data);                          %  ��ʾ������Ϣ
end