clc;
clear;
disp(diff_x());
disp(div_F());
disp(lambda_f());
disp(int1());
disp(int2());
disp(iiint_f);
%%
function out = diff_x()
syms x y 
out = diff(cos(x)*sin(y)+y^3*log(x),x);

end
%%
function out = div_F()
syms x y z
F_x = 2*cos(x)^2;
F_y = sin(y)^3;
F_z = 2*x^2 +y^2+4*z^2;

out = divergence([F_x,F_y,F_z],[x,y,z]);

end
%%
function out = lambda_f()
syms x y z
f = x^2 + 2*y^2+4*z^2;
out = laplacian(f,[x,y z]);
end
%%
function out = int1()
syms x
out = int(x^2+5*x,x);
end
%% 
function out = int2()
syms x n
out = int(x^(2-n)-5*x,x);
end
%%
function out = iiint_f()
syms x y z
out = int(int(int(sin(x)*cos(y)*tan(z),y),x),z);
end