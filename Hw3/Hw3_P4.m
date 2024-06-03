clc;
clear;
scramble('test.txt','out.txt');

%%
function scramble(in,out)

    fid_in = fopen(in,'r');
    fid_out = fopen(out,"w");

    while true
        %读取文件
        line = fgets(fid_in);

        if line == -1
            break;
        end
        % 获取每行所有字符串并打乱
        words = textscan(line,'%s');
        words = words{1};
        words = cellstr(words);%改变数据结构
        for i = 1:length(words)
             Word = scrambleWord(char(words{i}));%打乱字符
             fprintf(fid_out,'%s ',Word);%写入文本
        end
        fprintf(fid_out,'\n');
    end
    
    fclose(fid_in);
    fclose(fid_out);


end
%% 
function out = scrambleWord(in)
    % 不大于三的字符串也没有打乱的必要（因为打乱后还是本身）
    if(numel(in)<=3)
        out = in;
        return;
    end
    %获取中间字符串
    middle = in(2:end-1);
    %找出字符串中字符
    middle_letters = middle(isletter(middle));
    %打乱对应字符
    middle_letters = middle_letters(randperm(numel(middle_letters)));
    %把打乱后的字符重新插回去
    middle(isletter(middle)) = middle_letters;

    out=[in(1),middle,in(end)];
    
end
