clc;
clear;
data = load('poly.mat');
disp(data)
x = data.X;
y = data.Y;
[R2out,pOrder,pCoeff] = discoverDegree(x,y,0.95);
disp(pCoeff);
y_fit = polyval(pCoeff,x);
figure;
scatter(x,y);
hold on;
plot(x,y_fit,'r','LineWidth',3);
axis tight;


%%
function [R2out,pOrder,pCoeff] = discoverDegree(x,y,R2cirt)
    i = 0;
    R2out = 0;
    while R2out <R2cirt

        i = i+1;
        pCoeff = polyfit(x,y,i);
        y_fit = polyval(pCoeff,x);
        
        y_mean = mean(y);
        SS_up = sum((y-y_fit).^2);
        SS_down = sum((y-y_mean).^2);

        R2out = 1 -SS_up/SS_down;

    end
    pOrder = i;


end