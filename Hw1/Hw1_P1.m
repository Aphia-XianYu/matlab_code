clc;
clear;
Cel_temp()
Cel_temp_vec()
%%
function Cel_temp()
% 将摄氏温度转换为华氏温度
%   celcius: 输入的摄氏温度
%   Farh_temp: 对应的华氏温度

    celcius = input("Please input celcius temperature: ");
    Fhar_temp = 9 * celcius / 5 + 32;
    fprintf('The Fahrenheit temperature is: %.2f\n', Fhar_temp);

end

%%
function Cel_temp_vec()
    celcius_temp = 20:30;%创建摄氏温度向量
    fahr_temp = 9 * celcius_temp / 5 + 32;

    fprintf('Celsius  Fahrenheit\n');
    for i = 1:numel(celcius_temp)
        fprintf('%.2f    %.2f\n',celcius_temp(i),fahr_temp(i))
    end
end


