clc;
clear;
linear_solve();

%%
function linear_solve()
    % 获取参数
    coef = input('Enter values for a, b, c, d, e, f :');
    % 将参数转换成增广矩阵求解
    coef_matrix = [coef(1),coef(2);coef(4),coef(5)];
    aug_matrix = [coef(3);coef(6)];
    % 如果行列式为0，向量线性相关
    if(det(coef_matrix)==0)
        % 相等情况判断
        if (coef(3)*coef(4)==coef(6)*coef(1))
            fprintf('Coincident\n')
        else
            fprintf('Parallel\n')
        end
    else
        % 解矩阵
        an = coef_matrix\aug_matrix;
        fprintf('x = %.2f,y = %.2f\n',an(1),an(2))
    end
end
