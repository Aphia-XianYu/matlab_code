clc;
clear;
t = [0, 1, 2.5, 5.0, 10.5, 12.5, 16, 20.5, 26.5, 30.5, 32];
x = [0, 0.3, 1.2, 1.3, 1.6, 2.2, 2.4, 3.0, 3.6, 4.5, 4.6];
info_Speedy = test_Speedy(x,t);
figure;
scatter(t,x,3);
hold on
plot(info_Speedy(1,:),info_Speedy(2,:),'g');
hold on
plot(info_Speedy(1,:),info_Speedy(3,:),'r');
hold on 
plot(info_Speedy(1,:),info_Speedy(4,:),'b');
axis tight
%%
function out = test_Speedy(x,t)
    time = linspace(min(t),max(t),100);
    Speedy_x = interp1(t,x,time,'pchip');
    Speedy_v = gradient(Speedy_x,time);
    Speedy_a = gradient(Speedy_v,time);
    out(1,:) = time;
    out(2,:) = Speedy_x;
    out(3,:) = Speedy_v;
    out(4,:) = Speedy_a;
end




