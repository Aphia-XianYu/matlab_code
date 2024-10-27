clc;
clear;

t = [0, 1, 2.5, 5.0, 10.5, 12.5, 16, 20.5, 26.5, 30.5, 32];
x = [0, 0.3, 1.2, 1.3, 1.6, 2.2, 2.4, 3.0, 3.6, 4.5, 4.6];

data.t.raw = t;
data.x.raw = x;
data.t.interp = linspace(min(t), max(t), 100);
% 获取样条和线性数据
data = test_spline_Speedy(data);
data = test_linear_Speedy(data);

figure;
tiledlayout(3,1);

% 绘制位置图
nexttile;
hold on;
plot(data.t.raw, data.x.raw, 'ko', 'MarkerFaceColor', 'k', 'DisplayName', '原始数据');
plot(data.t.interp, data.interp.linear.x, 'b', 'DisplayName', '线性插值 - 位置');
plot(data.t.interp, data.interp.spline.x, 'r', 'DisplayName', '样条插值 - 位置');
xlabel('时间 (秒)');
ylabel('位置 (米)');
title('位置');
legend show;
grid on;
hold off;

% 绘制速度图
nexttile;
hold on;
plot(data.t.interp, data.interp.linear.v, 'b', 'DisplayName', '线性插值 - 速度');
plot(data.t.interp, data.interp.spline.v, 'r', 'DisplayName', '样条插值 - 速度');
xlabel('时间 (秒)');
ylabel('速度 (米/秒)');
title('速度');
legend show;
grid on;
hold off;

% 绘制加速度图
nexttile;
hold on;
plot(data.t.interp, data.interp.linear.a, 'b', 'DisplayName', '线性插值 - 加速度');
plot(data.t.interp, data.interp.spline.a, 'r', 'DisplayName', '样条插值 - 加速度');
xlabel('时间 (秒)');
ylabel('加速度 (米/秒^2)');
title('加速度');
legend show;
grid on;
hold off;

%%
function data = test_spline_Speedy(data)
    t = data.t.raw;
    x = data.x.raw;
    time = data.t.interp;

    % 计算位置
    Speedy_x = interp1(t, x, time, 'spline');
    % 计算速度
    Speedy_v = gradient(Speedy_x, time);
    % 计算加速度
    Speedy_a = gradient(Speedy_v, time);

    data.interp.spline.x = Speedy_x;
    data.interp.spline.v = Speedy_v;
    data.interp.spline.a = Speedy_a;
end

%%
function data = test_linear_Speedy(data)
    t = data.t.raw;
    x = data.x.raw;
    time = data.t.interp;

    % 计算位置
    Speedy_x = interp1(t, x, time, 'linear');
    % 计算速度
    Speedy_v = gradient(Speedy_x, time);
    % 计算加速度
    Speedy_a = gradient(Speedy_v, time);

    data.interp.linear.x = Speedy_x;
    data.interp.linear.v = Speedy_v;
    data.interp.linear.a = Speedy_a;
end
