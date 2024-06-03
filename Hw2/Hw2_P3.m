clc;
clear;
find_all_Narcis();

%%
% 找三位数中的水仙花数
function  find_all_Narcis()
    Nar_nums = [];
    for i = 100:999
        if (Narcis_helper(i))
            Nar_nums(length(Nar_nums)+1)= i;
        end
    end
    disp(Nar_nums);
end
%%
% 判断三位数是否为水仙花数
function out = Narcis_helper(n)
    out = false;
    % 获取每一位数
    num = str2num(num2str(n)')';
    if num(1)^3+num(2)^3+num(3)^3==n
        out = true;
    end
    
end