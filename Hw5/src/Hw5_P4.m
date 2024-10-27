clc;
clear;

% 设定参数
g = 9.81; 
c = 0.2; 
x0 = 0; 
y0 = 0; 
vxa = 5; 
vxb = 15; 
vy = 10; 
tstep = 0.01; 
dis = 20; 
tol = 0.01;

vxOpt = goldCornhole(g, c, x0, y0, vxa, vxb, vy, tstep, dis, tol);
fprintf('Optimal x velocity: %.4f m/s\n', vxOpt);

%%
function vxOpt = goldCornhole(g, c, x0, y0, vxa, vxb, vy, tstep, dis, tol)
    % 获取最大速度与最小速度
    v_max = max(vxa, vxb);
    v_min = min(vxa, vxb);
    % 定义黄金分割比
    phi = (1 + sqrt(5)) / 2;
    
    % 迭代
    while (v_max - v_min) > tol
        % 划分速度
        v_1 = v_max - (v_max - v_min) / phi;
        v_2 = v_min + (v_max - v_min) / phi;
        % 获取对应速度下的距离
        disX1 = projectileSim(g, c, x0, y0, v_1, vy, tstep);
        disX2 = projectileSim(g, c, x0, y0, v_2, vy, tstep);
        
        % 更新速度
        if abs(disX1 - dis) < abs(disX2 - dis)
            v_max = v_2;
        else
            v_min = v_1;
        end

    end

    vxOpt = (v_max + v_min) / 2;
end

%%
function disX = projectileSim(g, c, x0, y0, vx0, vy0, tstep)
    
    pos_x = x0;
    pos_y = y0;
    
    while pos_y >= 0
        % 计算加速度
        speed = sqrt(vx0^2 + vy0^2);
        a_x = -c * vx0 * speed;
        a_y = -g - c * vy0 * speed;
        
        % 计算新的速度
        vx0 = vx0 + a_x * tstep;
        vy0 = vy0 + a_y * tstep;
        
        % 计算新的位置
        pos_x = pos_x + vx0 * tstep;
        pos_y = pos_y + vy0 * tstep;
    end
    
    disX = pos_x;
end
