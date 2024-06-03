clc;
clear;
msd_posVel(0.2, 0.1, 2, 10, 5, 0, 100);
msd_water(0.2, 0.1, 20, 10, 5, 0, 300);

%%
function msd_posVel(c, k, m, yi, vi, t_beg, t_end)
    % 求解微分方程
    [t, y] = ode45(@(t, y) msd(t, y, c, k, m), [t_beg, t_end], [yi, vi]);

    figure;

    % 绘制位置曲线
    yyaxis left;
    plot(t, y(:, 1), 'b', 'LineWidth', 2);
    ylabel('Position (m)', 'Color', 'b', 'FontSize', 12, 'FontName', 'Arial');
    ylim([-20 30]);
    % 绘制速度曲线
    yyaxis right;
    plot(t, y(:, 2), 'r', 'LineWidth', 2);
    ylabel('Velocity (m/s)', 'Color', 'r', 'FontSize', 12, 'FontName', 'Arial');
    ylim([-4 6]);
    xlabel('Time (sec)', 'FontSize', 12);
    title('Position and Velocity over Time', 'FontSize', 14, 'FontName', 'Arial');

end

%%
function dy = msd(t, y, c, k, m)
    % 定义微分方程
    dy = [y(2); -(c * y(2) + k * y(1)) / m];
end

%%
function msd_water(c, k, m, yi, vi, t_beg, t_end)
    masses = 0:0.1:m;  % 创建质量范围
    times = t_beg:0.1:t_end;  % 创建时间范围
    num_masses = length(masses);
    num_times = length(times);
    
    figure;
    hold on;

    
    % 计算每个质量下的位置随时间的变化
    for i = 1:num_masses
        mass = masses(i);
        [t, y] = ode45(@(t, y) msd(t, y, c, k, mass), times, [yi vi]);
        plot3(t, mass * ones(size(t)), y(:,1),'Color','k'); % 绘制三维图
    end
    
    % 设置轴标签和标题
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Mass (kg)', 'FontSize', 12);
    zlabel('Position (m)', 'FontSize', 12);
    title('Position over Time for Different Masses', 'FontSize', 14);
    view(-15, 45); % 调整视角
    hold off;
end
