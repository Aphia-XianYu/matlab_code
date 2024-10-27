clc;
clear;
data = load('poly.mat');

x = data.X;
y = data.Y;

[R2out,pOrder,pCoeff] = discoverDegree(x,y,0.95);
% 展示拟合系数
disp(pCoeff);
% 计算拟合多项式
y_fit = polyval(pCoeff,x);
figure;
scatter(x,y,15);
hold on;
plot(x,y_fit,'r','LineWidth',3);
axis tight;

xlabel('x', 'FontSize', 12); 
ylabel('y', 'FontSize', 12);
title(sprintf('Polynomial Fit with R^2 = 0.85'), 'FontSize', 14); % 图形标题，展示R^2值

hold off;


%%
function [R2out,pOrder,pCoeff] = discoverDegree(x,y,R2cirt)
    % 多项式阶数 常数为0阶
    i = 0;
    R2out = 0;

    while R2out < R2cirt
        % 计算拟合多项式
        i = i+1;
        pCoeff = polyfit(x,y,i);
        y_fit = polyval(pCoeff,x);
        
        % 计算R^2
        y_mean = mean(y);
        SS_up = sum((y-y_fit).^2);
        SS_down = sum((y-y_mean).^2);
        R2out = 1 -SS_up/SS_down;

    end

    pOrder = i;


end