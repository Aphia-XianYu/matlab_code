clc;
clear;

%%
function vxOpt = goldCornhole(g,c,x0,y0,vxa,vxb,vy,tstep,dis,tol)

    v_max = max(vxa,vxb);
    v_min = min(vxa,vxb);
    phi = 0.618;


    while abs(disX-dis)>tol
        v_1 = v_min + (1-phi)*(v_max-v_min);
        v_2 = v_min +     phi*(v_max-v_min);
        disX1 = projectileSim(g,c,x0,y0,v_1,vy,tstep);
        disX2 = projectileSim(g,c,x0,y0,v_2,vy,tstep);
        disX  = (disX2 + disX1)/2;
        v_max = max(v_1,v_2);
        v_min = min(v_1,v_2);
    end
    vxOpt = (v_max+v_min)/2;
end
%%
function disX = projectileSim(g, c, x0, y0, vx0, vy0, tstep)
    
    pos_x = x0;
    pos_y = y0;

    while pos_y >= 0

        % 计算加速度
        a_x = - c* vx0*sqrt(vx0^2+vy0^2);
        a_y = - g - c*vy0*sqrt(vx0^2+vy0^2);
        % 计算位置
        pos_x = pos_x + vx0*tstep;
        pos_y = pos_y + vy0*tstep;
        % 替换初始变量
        vx0 = vx0 + a_x*tstep;
        vy0 = vy0 + a_y*tstep;
        
    end
    disX = pos_x;
end