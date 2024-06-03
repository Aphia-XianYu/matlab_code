clc;
clear;
%%
% billiardScript : Sets up and runs a billiard simulation
% 
% initialState: 
%      the initial state of the ball (position and velocity) expressed as a row vector [x y vx vy] 
%      (x and y in meters, vx and vy in meters/second) 
% walls : 
%      The walls in the simulation this is provided as an array with
%      one row for every wall - each row encodes the endpoints of the wall in the following format [x1 y1 x2 y2]
%      so the array [1 3 1 5; 7 5 10 5] would represent two walls one with end
%      points (1,3) and (1,5) and the other with endpoints (7,5) and (10,5).
%      Note that the walls will either be purely horizontal or purely vertical
%      and you can tell which by checking whether the x or y coordinates of
%      the endpoints are constant
% timestep : 
%      the simulation timestep in seconds
% iterations : 
%      number of timesteps to run the simulation
% coefficient_of_restitution : 
%      after the ball collides with a wall it's speed after the collision is related to its speed 
%      before the collision the coefficient of restitution. This is a
%      unitless quantity between 0 and 1.


% Initial State of ball
%                 x    y   vx vy
initialState = [1.2 0.88 10.1 10];

%         x1  y1  x2  y2
walls = [  0   0  10   0; ...
           0  10  10  10; ...
           0   0   0  10; ...
          10   0  10  10; ...
           0   5   5   5; ...
           4   0   4   3; ...
           7   6   7   9 ];

coefficient_of_restitution = 0.8;
timestep = 0.04;
iterations = 1000;


% Run the simulation
%

ballState = initialState;

% Initialize the display

% Draw the ball
h = plot (ballState(1), ballState(2), 'bo', 'MarkerSize', 10);

% Set the axis to correspond to a 10 meter by 10 meter field
axis ([0 10 0 10]);

% Draw the walls using the line function
line (walls(:,[1 3])',walls(:,[2 4])')

% For each timestep
for i = 1:iterations
    
    % Update the ball state
    ballState = updateBallState (ballState, timestep, walls, coefficient_of_restitution);
    
    % Redraw the ball
    set (h, 'XData', ballState(1));
    set (h, 'YData', ballState(2));
    
    % pause so that we can see the drawing
    pause (0.2);

end
%%
function [t,collisionState] = findCollision(ballState,wall,coefficient_of_restitution)
    t = Inf;
    collisionState = [];
    % 墙是竖直的
    if(wall(1)==wall(3))
        up_wall = max(wall(2),wall(4));% 墙的上端
        down_wall = min(wall(2),wall(4));% 墙的下端
        coll_t = (wall(1)-ballState(1))/ballState(3);%获取时间
        if coll_t > 0 % 不走回头路
           % 获取假定碰撞时y的大小
           pos_y = ballState(2)+ballState(4)*coll_t;
           % 如果会撞到
           if(down_wall<pos_y&&pos_y<up_wall)
              t =coll_t;
              collisionState = [wall(1),pos_y,...
                  -coefficient_of_restitution*ballState(3),coefficient_of_restitution*ballState(4)];
           end
        end
    end
    % 墙时水平的
    if(wall(2)==wall(4))
        up_wall = max(wall(1),wall(3));% 墙的上端
        down_wall = min(wall(1),wall(3));% 墙的下端
        coll_t = (wall(2)-ballState(2))/ballState(4);%获取时间
        if coll_t > 0 % 不走回头路
           % 获取假定碰撞时y的大小
           pos_x = ballState(1)+ballState(3)*coll_t;
           % 如果会撞到
           if(down_wall<pos_x&&pos_x<up_wall)
              t =coll_t;
              collisionState = [pos_x,wall(2),...
                  coefficient_of_restitution*ballState(3),-coefficient_of_restitution*ballState(4)];
           end
        end
    end
end
%%
function newBallState = updateBallState(ballState, dt, walls, coefficient_of_restitution)
    %basic case
    if dt<=0
        newBallState = ballState;
        return ;
    end


    min_time = Inf;
    collisionState = [];

    % 寻找下一次撞击
    for i = 1:size(walls,1)
        [t,coll_ball] = findCollision(ballState,walls(i,:),coefficient_of_restitution);
        if t<min_time
            min_time = t;
            collisionState = coll_ball;
        end    
    end
    % 如果撞不了
    if min_time > dt
        newBallState = ballState;
        newBallState(1) = ballState(1) + ballState(3)*dt;
        newBallState(2) = ballState(2) + ballState(4)*dt;
    else
        newBallState = collisionState;
        newBallState = updateBallState(newBallState,dt-min_time,walls,coefficient_of_restitution);
    end

end
