clc;
clear;
% 定义函数
f = @(x) sin(x)+cos(x.^2-pi/7).^2;

plot_func(f, -5*pi, 5*pi);
test_tragz(f, -5*pi, 5*pi);
test_intergral(f, -5*pi, 5*pi);

%%
function plot_func(func, x_0, x_1)
    out = ezplot(func, [x_0, x_1]);
    set(gca, 'FontSize', 12); % 设置坐标轴字体大小
    xlabel('x', 'FontSize', 14);
    xlim([x_0 x_1]);
    grid on
end

%%
function test_tragz(func, x_0, x_1)
    area_div = 5:1:500;
    intergrate_area = zeros(size(area_div));
    
    for i = 1:length(area_div)
        n = area_div(i);
        x = linspace(x_0, x_1, n);
        y = func(x);
        intergrate_area(i) = trapz(x, y);
    end
    
    figure;
    plot(area_div, intergrate_area); 
    xlim([min(area_div) max(area_div)]);
    xlabel('Number of Divisions', 'FontSize', 14);
    ylabel('Approximated Integral', 'FontSize', 14);
    title('Trapezoidal Rule Convergence', 'FontSize', 16);
    grid on;
end

%%
function test_intergral(func, x_0, x_1)

    exact_ans = integral(func, x_0, x_1);
    i = 0;
    numerical_ans = 0;
    % 设置迭代条件 比较精度和迭代次数
    while abs(exact_ans - numerical_ans) > 1E-3&& i <20 
        x = linspace(x_0, x_1, 2^(i+1));
        y = func(x);
        numerical_ans = trapz(x, y);
        i = i + 1;
    end
    %输出迭代结果
    disp(['Iterations until convergence: ', num2str(2^(i))]);
end