clc;
clear;
%%
% Game of Life
%
% given a list of shapes
block = [1 1; 1 1];
boat = [1 1 0; 1 0 1; 0 1 0];
blinker = [1 1 1];
toad = [0 1 1 1; 1 1 1 0];
glider = [1 1 1; 1 0 0; 0 1 0];
LWSS = [0 1 0 0 1; 1 0 0 0 0; 1 0 0 0 1; 1 1 1 1 0];

% initialize the cells
% please insert your shapes here!!!
in = zeros(50);

in (10, 10:12) = blinker;

in (20:22, 20:22) = glider;

in (25:28, 30:34) = LWSS;

% run the simulation
iterations = 1000;

for i = 1:iterations
    image(logical(in));
    colormap ([1 1 1; 0 0 0]);

    in = updateCells(in);
    pause(0.001);
end
%%
function out = getCell(in,row,col)
    % 获取矩阵行列数
    [in_row,in_col]= size(in);
    
    if 1<=row && 1<=col && row<=in_row && col<=in_col
        out = in(row,col);
    else
        out = 0;
    end

end

%%
function out = countNeighbors(in)
    % 获取矩阵行列数
    [in_row,in_col] = size(in);
    % 记录邻居数
    out = zeros(in_row,in_col);
    % 计算邻居
    for i = 1:in_row
        for j = 1:in_col
            % 数邻居
            out(i,j) = getCell(in,i-1,j-1)+getCell(in,i-1,j)+getCell(in,i-1,j+1)+...
                       getCell(in,i  ,j-1)                  +getCell(in,i  ,j+1)+...
                       getCell(in,i+1,j-1)+getCell(in,i+1,j)+getCell(in,i+1,j+1);
        end
    end

end
%%
function out = updateCells(in)
    [row,col] = size(in);
    % 获取邻居数
    Neighbor_cell = countNeighbors(in);
    out = zeros(row,col);
    % 更新状态
    for i = 1:row
        for j = 1:col

            if in(i,j)==1 %有细胞
                if Neighbor_cell(i,j)<=1||Neighbor_cell(i,j)>=4
                    out(i,j) = 0;
                else
                    out(i,j) = 1;
                end
            else % 没细胞
                if Neighbor_cell(i,j)==3
                    out(i,j) = 1;
                else 
                    out(i,j) = 0;
                end
                
            end
        end
    end
end
