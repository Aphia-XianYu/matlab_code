clc;
clear;
spirograph(5,1,0.4);
figure
spirograph(12,-1,1.5);
figure
spirograph(7,-1,1);

%%
function spirograph(R,r,d)
theta = linspace(0,10*pi,(10*pi)/0.001);
x = (R+r)*cosd(theta)+d*cosd(((R+r)/r)*theta);
y = (R+r)*sind(theta)-d*sind(((R+r)/r)*theta);
plot(x,y);
end