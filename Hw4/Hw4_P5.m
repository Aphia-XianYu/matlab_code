clc;
clear;
solve_AD(0.5, 2*pi, 0.05, 1);
%%
function solve_AD(A, k, D, U)
    % 精确解函数
    exact_func = @(x, t) exp(-D*k^2*t) * A * sin(k * (x - U * t));
    
    % 参数设置
    L = 2;
    n = 21;  
    h = L / (n - 1);
    dt = 0.05;
    timesteps = 10;
    
    % 初始化数值解和精确解
    numerical_solution = zeros(n+1, timesteps + 1);
    exact_solution = zeros(n, timesteps + 1);
    
    % 初始条件
    x = linspace(0, L, n);
    numerical_solution(1:21, 1) = A * sin(k * x);
    numerical_solution(22,1) = numerical_solution(2,1);
    
    % 计算精确解
    for t = 0:timesteps
        exact_solution(:, t + 1) = exact_func(x, t * dt);
    end

    figure;
    hold on;

    for t = 1:timesteps
        % 先绘制数值解和精确解
        yyaxis left;
        plot(x, numerical_solution(1:21, t), 'b');
        ylabel('Numerical Solution');
        ylim([-2 2])
        
        yyaxis right;
        plot(x, exact_solution(:, t), 'r');
        ylabel('Exact Solution');
        ylim([-2 2]);
        
        title(sprintf('Time step: %d', t));
        xlabel('x');
        legend('Numerical', 'Exact');
        txt = ['nstep = ' num2str(t) ' time = ' num2str(dt*(t-1))];
        text(1,-1,txt);
        hold off;

        numerical_solution(22,t) = numerical_solution(2,t);
        fn = numerical_solution(:, t);  % 当前时间步的值
        
        % 内部点更新
        for j = 2:n
            numerical_solution(j, t + 1) = fn(j) ...
                - (U * dt / (2 * h)) * (fn(j + 1) - fn(j - 1)) ...
                + (D * dt / h^2) * (fn(j + 1) - 2 * fn(j) + fn(j - 1));
        end
        
        % 应用周期边界条件更新边界点
        numerical_solution(1,t+1)=numerical_solution(21,t+1);  

    end

    hold off;
end

