clc;
clear;
% an = The_date_difference(20200101,20200102);
% an = The_date_difference(20210101,20210105);
% an = The_date_difference(20200109,20200105);
% an = The_date_difference(20200209,20200301);
an = The_date_difference(20200101,20210101);
disp(an);
%%
function difference = The_date_difference(time1,time2)
    %分配最大最小日期
    bigger_date = max(time1,time2);
    smaller_date = min(time1,time2);
    %拆分日期，分为年月日
    [year1,month1,day1] = transDate(num2str(smaller_date));
    [year2,month2,day2] = transDate(num2str(bigger_date));
    % 计算日期差
    difference = date_difference_Helper(year1,month1,day1, ...
                                        year2,month2,day2);
    
end

%%
function [year,month,day] = transDate(time)
    year = str2double(time(1:4));
    month = str2double(time(5:6));
    day = str2double(time(7:8));
end

%%
function days = date_difference_Helper(year1,month1,day1, ...
                                       year2,month2,day2)
    days = 0;

    %日期不同
    %年相同
    if(year1 == year2)
        days1 = getdayHelper(year1,month1,day1);
        days2 = getdayHelper(year2,month2,day2);
        days = days2 - days1 + 1;
    else%年不同
        for i = 1:year2-year1%算每年天数
            if(isleap(year1+i))
                days = days + 366;
            else
                days = days + 365;
            end
            days1 = getdayHelper(year2,month1,day1);
            days2 = getdayHelper(year2,month2,day2);
            days = days + days2 - days1 + 1;
        end
    end
end
%%
%判断闰年
function flag = isleap(year)
    flag = false;
    if(mod(year,4)==0&&mod(year,100)~=0) ...
            ||mod(year,400)==0
        flag = true;
    end
end
%%
%计算给定日期到1月1日的天数
function days = getdayHelper(year,month,day)
    days = 0;
    for i = 1:month-1
        days = days+getdayInMonth(year,month);
    end
    days = days+day;
end

%%
function days = getdayInMonth(year,month)
    if(month == 2)
        if(isleap(year))
            days = 29;
        else
            days = 28;
        end
    elseif any(month ==[4,6,9,11])
        days = 30;
    else
        days = 31;
    end
end