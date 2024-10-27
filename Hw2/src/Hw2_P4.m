clc;
clear;
[x,y] = basketball(9.8,0.2,0,0,2.5,5.4,0.01,1.5);
plot(x,y);


%%
function [x,y]=basketball(g,c,x0,y0,vx0,vy0,tstep,tmax)

    x = zeros(1,round(tmax/tstep));
    y = zeros(1,round(tmax/tstep));
    
    x(1) = x0;
    y(1) = y0;

    for i = 2:(tmax/tstep)

        % 计算加速度
        a_x = - c* vx0*sqrt(vx0^2+vy0^2);
        a_y = - g - c*vy0*sqrt(vx0^2+vy0^2);
        % 计算位置
        x(i) = x(i-1) + vx0*tstep;
        y(i) = y(i-1) + vy0*tstep;
        % 替换初始变量
        vx0 = vx0 + a_x*tstep;
        vy0 = vy0 + a_y*tstep;
        
    end

end