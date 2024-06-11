classdef Rocket

    properties
        width = 40;
        length = 40;

        x = 0;
        y = 0;
        vx = 0;
        vy = 0;
        g = - 5;
        theta = 0; % 角度制
        % 设定反向加速度
        up = 100;
        % 判断左转、右转、加速
        left = false;
        right = false;
        speed = false;
        changeSpeed = false;
        fuel = 200;
    end

    methods
        %%
        % 初始化
        function obj = Rocket(x, y, vx, vy)
            obj.x = x;
            obj.y = y;
            obj.vx = vx;
            obj.vy = vy;
        end

        %%
        % 状态更新
        function obj = UpdateRocketState(obj, t)
            % 更新位置前先基于当前速度和时间计算新位置
            obj.x = obj.x + obj.vx * t;
            obj.y = obj.y + obj.vy * t;
        
            % 转向逻辑
            if obj.left
                if obj.theta>-90
                    obj.theta = obj.theta - 15;
                    obj.changeSpeed = true;
                end
                obj.left = false;
            elseif obj.right
                if obj.theta <= 90
                    obj.theta = obj.theta + 15;
                    obj.changeSpeed = true;
                end
                obj.right = false;
            end

            % 转向后速度更新一次就够了，不然有bug
            if obj.changeSpeed 
                v = sqrt(obj.vx^2+obj.vy^2);
                obj.vx = v* sind(obj.theta);
                obj.vy = - v* cosd(obj.theta);
                obj.changeSpeed = false;
            end
            
            % 更新速度
            obj.vy = obj.vy + obj.g * t; % 重力加速度影响
            if obj.speed
                obj.vy = obj.vy + obj.up * t; % 减少vy以模拟向上推力的效果
                obj.speed = false; % 重置加速标志
            end
        end
        %%
        % 取得火箭位置
        function [x, y] = getPosition(obj)
            x = obj.x;
            y = obj.y;
        end
        %%
        % 判断左转
        function obj = turnLeft(obj)
            if obj.fuel >= 5
                obj.left = true;
                obj.fuel = obj.fuel - 5;
            end
        end
        %%
        % 判断右转
        function obj = turnRight(obj)
            if obj.fuel >= 5
                obj.right = true;
                obj.fuel = obj.fuel - 5;
            end
        end
        %%
        % 判读加速
        function obj = accelerate(obj)
            if obj.fuel >= 10
                obj.speed = true;
                obj.fuel = obj.fuel - 10;
            end
        end
    end
end