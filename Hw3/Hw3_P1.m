clc;
clear;
Halley_Comet();
%%
function Halley_Comet()
    % 设定哈雷彗星参数
    a_halley = 17.9; 
    e_halley = 0.967276; 
    % 设定地球参数
    a_earth = 1; 
    e_earth = 0; 
    % 获取轴长度
    theta = (0:0.01*pi:2*pi);
    r_halley = a_halley * (1 - e_halley^2) ./ (1 - e_halley * cos(theta));
    r_earth = a_earth * (1 - e_earth^2) ./ (1 - e_earth * cos(theta));
    
    % 转成直角坐标系
    [x_halley, y_halley] = pol2cart(theta, r_halley);
    [x_earth, y_earth] = pol2cart(theta, r_earth);

    %画图
    figure;
    hold on;
    plot(x_halley, y_halley, 'r', 'LineWidth', 2); % 哈雷彗星
    plot(x_earth, y_earth, 'b', 'LineWidth', 2); % 地球
    plot(0, 0, 'yo', 'MarkerSize', 5, 'MarkerFaceColor', 'r'); % 太阳

    % 贴标签
    title('Orbits of Halley''s Comet and Earth');
    xlabel('X (A.U.)');
    ylabel('Y (A.U.)');
    legend('Halley''s Comet', 'Earth', 'Sun', 'Location', 'northeast');
    axis equal;
    grid on;
    hold off;
    

end
