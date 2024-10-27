clc;
clear;
state = lotkaVolterra([1,1],1,2.5,1,2.5,0.001,20000);
plot_VL(state,0.001,20000);
%%
function state = lotkaVolterra (initial_state, alpha, beta, gamma, delta, ...
    dt, ntimesteps)
    state = zeros(2,ntimesteps+1);
    state(:,1)=initial_state;
    for i = 1:ntimesteps
        prey = state(1,i);
        predator = state(2,i);
        % 更新被捕食者种群
        state(1, i + 1) = prey + (alpha * prey - beta * prey * predator) * dt;
        % 更新捕食者种群
        state(2, i + 1) = predator + (-gamma * predator + delta * prey * predator) * dt;
    end
    
end
%% 
function plot_VL(state,dt,ntimesteps)
    time = 0:dt:(ntimesteps)*dt;
    figure;

    yyaxis left;
    plot(time,state(1,:));
    
    yyaxis right;
    plot(time,state(2,:));

    legend('Prey', 'Predator','FontSize',6,'Position',[0.82 0.85 0.02 0.025]);
end