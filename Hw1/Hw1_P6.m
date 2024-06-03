clc;
clear;
nums = fib(20);
disp(nums);
%%
function nums = fib(N)
    ans_arr = zeros(1,N+1);
    nums = zeros(1,N+1);
    for n = 1:N+1
        nums(n) = fibhelper(n,ans_arr);
    end
end

function nums = fibhelper(N,memo)%memo用来记录已存在的斐波那契数列
    if memo(N)> 0%查找数列
        nums = memo(N);
        return;
    end

    if N<=2
        nums = N-1;
    else 
        nums = fibhelper(N-1,memo) + fibhelper(N-2,memo);
    end
    memo(N)  = nums;
    
end

