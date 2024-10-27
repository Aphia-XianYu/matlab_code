clc;
clear;
A_matrix = [-23, -18, 2, -19, -15;
            -1, -16, 10, 1, 3;
            -15, -23, 1, 8, 7;
            -19, 7, 2, 19, -4;
            -15, -11, -3, -11, -15;];
B_matrix = [22;-21;-20;-18;-17];
fprintf('xS01:\n');
xSol1(A_matrix,B_matrix);
fprintf('\nxS02:\n');
xSol2(A_matrix,B_matrix);
fprintf('\nxS03:\n');
xSol3(A_matrix,B_matrix);

%%
% Straight 直接求解
function xSol1(A_matrix,B_matrix)
    mat_ans = A_matrix\B_matrix;
    fprintf('x_1 = %.4f', mat_ans(1));
    fprintf('\nx_2 = %.4f', mat_ans(2));
    fprintf('\nx_3 = %.4f', mat_ans(3));
    fprintf('\nx_4 = %.4f', mat_ans(4));
    fprintf('\nx_5 = %.4f\n', mat_ans(5));
end
%%
% Cramer 利用克莱姆法则
function xSol2(A_matrix,B_matrix)
    D = det(A_matrix);
    mat_ans = ones(length(B_matrix),1) ;
    for i = 1:size(A_matrix,2)
        A_sub = A_matrix;
        % 替换矩阵
        A_sub(:,i)=B_matrix;
        D_i = det(A_sub);
        mat_ans(i)=(D_i/D);
    end
    fprintf('x_1 = %.4f', mat_ans(1));
    fprintf('\nx_2 = %.4f', mat_ans(2));
    fprintf('\nx_3 = %.4f', mat_ans(3));
    fprintf('\nx_4 = %.4f', mat_ans(4));
    fprintf('\nx_5 = %.4f\n', mat_ans(5));
end
%%
%高斯消元法
function xSol3(A_matrix,B_matrix)
    [n,~] =size(A_matrix);
    aug_mat = [A_matrix,B_matrix];%增广矩阵
    for k = 1:n-1
        %选取主元
        [~,max_row] = max(abs(aug_mat(k:n,k)));%找到最大值
        max_row = max_row + k-1;
        %交换行
        temp = aug_mat(k,:);
        aug_mat(k,:) = aug_mat(max_row,:);
        aug_mat(max_row,:) = temp;

        for i = k+1:n
            factor = aug_mat (i,k)/aug_mat(k,k);
            aug_mat(i,k:n+1) = aug_mat(i,k:n+1)- factor*aug_mat(k,k:n+1);
        end
    end

    mat_ans = zeros(n,1);
    %回代求解
    for i = n:-1:1
        mat_ans(i) = (aug_mat(i,n+1)-aug_mat(i,i+1:n)*mat_ans(i+1:n))/aug_mat(i,i);
    end
    fprintf('x_1 = %.4f', mat_ans(1));
    fprintf('\nx_2 = %.4f', mat_ans(2));
    fprintf('\nx_3 = %.4f', mat_ans(3));
    fprintf('\nx_4 = %.4f', mat_ans(4));
    fprintf('\nx_5 = %.4f\n', mat_ans(5));
end