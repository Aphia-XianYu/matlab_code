clc;
clear;
ans1 = my_gcd(0,2);
disp(ans1);
ans2 = my_gcd(0,0);
disp(ans2);
ans3 = my_gcd(12,4);
disp(ans3);
ans4 = my_lcm(12,90);
disp(ans4);


%%
function out = my_gcd(a,b)
    
    big_num = max(a,b);
    small_num = min(a,b);

    if(small_num==0&&big_num==0)% a,b都为0，返回0
        out = 0;  
        return;
    elseif(small_num==0&&big_num~=0)%b为0，返回最大值的绝对值
        out = abs(big_num);
        return;
    else
        if(rem(big_num,small_num)==0)
            out = abs(small_num); %base case
        else
            out = my_gcd(small_num,rem(big_num,small_num));
        end
    end
end
%%
function out=my_lcm(a,b)
    gcd = my_gcd(a,b);% 计算两数的最大公倍数
    out = (a/gcd)*b;
end
