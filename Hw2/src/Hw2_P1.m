clc;
clear;
%times means The fixed payment amount made in a year. That is 12
fprintf("method1: \n");
method1(12,1000)
fprintf("method2: \n");
method2(12,1000)
%%
% loop
function method1(n,loan)
    % 利息计算公式
    payment = @(times,loan,year,rate)...
        (rate*loan*(1+rate/times)^(times*year))/(times*((1+rate/times)^(times*year)-1));
    inter_rate = 0.1:0.01:0.2;
    years =[15,20,25];
    repayment_table = zeros(11,3);
    for i = 1:length(inter_rate)
        % 每年的利息
        for j = 1:length(years)
        % pay in 15,20,25 years
            repayment_table(i,j)=payment(n,loan,years(j),inter_rate(i));
        end
    end
    disp(repayment_table);
end
%%
% vectorize
function method2(n,loan)

    years = [15,20,25];
    inter_rate = 0.1:0.01:0.2;
    repaymat_table = zeros(11,3);
    %计算不同偿还年份对应得利息表
    for i = 1:length(years)
    P = inter_rate.*(loan*(1+inter_rate/n).^(n*years(i))./...
    (n*((1+inter_rate/n).^(n*years(i))-1)));
    repaymat_table(:,i) = P;
    end
    disp(repaymat_table);

end

