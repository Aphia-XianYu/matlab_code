clc;
clear;

a = cleanup([5 17 -20 99 3.4 2 8 -6]);
b = nearZero([1 5 3 0 2 7 0 8 9 1 0]);
[x,y] = nearestNumbers([2 5 3 10 0 -3.1]);
disp(a);
disp(b);
disp([x,y]);

%%
function y = cleanup(x)
    %找到不满足元素条件索引
    id = x<0|x>10;
    y = x;
    y(id)=NaN;

end
%%
function y = nearZero(x)
    %找到为零元素索引
    zero_id = find(x == 0);
    y = -inf;

    for i = 1:length(zero_id)
        %零元素左侧元素
        if zero_id(i)>1 
            y = max(y,x(zero_id(i)-1));
        end
        %零元素右侧元素
        if zero_id(i)<length(x)
            y = max(y,x(zero_id(i)+1));
        end
    end

end
%%
%
function [index1, index2] = nearestNumbers(A)
    res = inf;
    %这个是使用贪心算法的
    % for i = 1:length(A)
    %     for j = i+1:length(A)
    %         res = min(res,abs(A(i)-A(j)));
    %         if res ==abs(A(i)-A(j))
    %             index1 = i;
    %             index2 = j;
    %         end
    %     end
    % end
    
    %对矩阵元素按从小到大排序，比较两两元素的差，求得差最小的两个元素
    search_mat = sort(A);
    for i = 1:length(search_mat)-1
        % 做差比较
        res = min (res,abs(search_mat(i)-search_mat(i+1)));
        % 找到元素下标
        if res == abs(search_mat(i)-search_mat(i+1))
            temp_index1 = find(A == search_mat(i),1);
            temp_index2 = find(A == search_mat(i+1),1);
        end
    end
    index1 = min(temp_index1,temp_index2);
    index2 = max(temp_index1,temp_index2);
    
end
