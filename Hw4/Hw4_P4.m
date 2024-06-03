clc;
clear;
occupancy = logical([
    1 1 0 1 1 0 1 0;
    1 0 1 0 1 1 1 1;
    1 1 1 0 1 0 0 0;
    0 0 1 1 1 1 1 0;
    1 1 1 0 0 0 1 1;
    1 1 0 1 1 1 0 1;
    1 1 1 1 0 1 1 0;
    1 1 0 1 1 0 1 0;
]);

dest_row = 3;
dest_col = 3;

distance = grassfire(occupancy, dest_row, dest_col);
disp('Distance Grid:');
disp(distance);

%%
function distance = grassfire(occupancy, dest_row, dest_col)
    [occ_row,occ_col] = size(occupancy);
    % 设定加了边界的阵
    distance = inf(occ_row+2,occ_col+2);
    occ = false(occ_row+2,occ_col+2);
    occ(2:end-1,2:end-1) = occupancy;
    % 初始化终点为0
    distance(dest_row+1,dest_col+1) = 0;
    % 初始化邻居向量
    neighbor_pos = [0,1; 1,0; 0,-1; -1,0];

    while true
        % 记录原来的位置
        old_distance = distance;
        % 计算邻居位置
        for row = 2:occ_row+1
            for col = 2:occ_col+1
                if occ(row,col)%如果不是墙壁的
                    % 初始化最小值
                    min_distance = inf;

                    for k = 1:4
                        neighbor_row = row + neighbor_pos(k,1);
                        neighbor_col = col + neighbor_pos(k,2);
                        % 计算找到最小距离的邻居
                        min_distance = min(min_distance,old_distance(neighbor_row,neighbor_col));
                    end

                    if min_distance ~= inf

                        new_distance = min_distance+1;

                        if new_distance < old_distance(row,col)
                            distance(row,col) = new_distance;
                        end

                    end

                end
            end
        end
        % 循环结束条件
        if old_distance == distance 
            break;
        end

    end
    distance = distance(2:end-1,2:end-1);
end