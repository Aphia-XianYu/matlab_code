clc;
clear;
rank = Scores_ranking;
disp(rank);
%%
function rank = Scores_ranking(n)
    fileID = fopen('score.txt', 'r'); 
    
    data = textscan(fileID, '%f %f'); % 按格式读取每行数据
    
    fclose(fileID);
    
    student_number = data{1};%获取学生学号
    score = data{2};%获取学生分数

    rank = zeros(10,5);%分数表
    rank(:,1)=student_number;%第一行为学号
    rank(:,2)=score;%第二行为分数
    %手动分配考场号（
    rank(1:5,3) = 1;
    rank(6:10,3) = 2;
    %计算考场排名
    for i = 1:2
        temp = rank(5*(i-1)+1:5*i,:);
        [temp, ~] =sortrows(temp,2,'descend');%按分数由降序排列
        % 算排名
        k = 1;
        temp(1,4) = 1;
        for j = 2:5
            k = k+1;
            if(temp(j,2)==temp(j-1,2))%前后分数一样
                temp(j,4) = temp(j-1,4);
            else
                temp(j,4) = k;
            end
        end
        rank(5*(i-1)+1:5*i,:) = temp;
    end
    % 计算总排名
    % 按总排名排序
    [rank,~] = sortrows(rank,2,"descend");
    k = 1;
    rank(1,5) = 1;
    % 给排名
    for i=2:10
        k = k+1;
        if rank(i,2)==rank(i-1,2)
            rank(i,5) = rank(i-1,5);
        else
            rank(i,5) = k;
        end
    end

end