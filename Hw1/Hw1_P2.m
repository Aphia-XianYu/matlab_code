clc;
clear;
matrix_create();
%%
function matrix_create()
% 创建从 0 开始到 360 的步长为 30 的角度向量
degrees = 0:30:360;

% 计算正弦值和余弦值
sines = sind(degrees);
cosines = cosd(degrees);

% 生成矩阵
table_matrix = [degrees' sines' cosines'];

% 打印矩阵
disp(' Degrees      Sines     Cosines');
disp(table_matrix);
end
