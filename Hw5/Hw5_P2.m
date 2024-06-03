clc;
clear;
f = @(x) sin(x)+cos(x.^2-pi/7).^2;
plot_func(f,-5*pi,5*pi)
test_tragz(f,-5*pi,5*pi);
test_intergral(f,-5*pi,5*pi)
%%
function plot_func(func,x_0,x_1)
    ezplot(func,[x_0,x_1]);
    xlim([x_0 x_1]);
end
%%
function out = test_tragz(func,x_0,x_1)
    area_div = 5:1:500;
    intergrate_area = zeros(size(area_div));
    for i = 1:length(area_div)
        n = area_div(i);
        x = linspace(x_0,x_1,n);
        y = func(x);
        intergrate_area(i) = trapz(x,y);
    end
    figure;
    plot(area_div,intergrate_area);
end
%%
function test_intergral (func, x_0,x_1)
    exact_ans = integral(func,x_0,x_1);
    i = 0;
    numerical_ans = 0;
    while abs(exact_ans-numerical_ans)>1E-2||i<10
        x = linspace(x_0,x_1,2^(i+1));
        y = func(x);
        numerical_ans = trapz(x,y);
        i = i+1;
    end
    disp(2^(i+1));
    
end