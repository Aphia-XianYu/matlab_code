clc;
clear;

data = load('AFMdata0001.mat');

H = data.height;
F = data.friction;
I = data.current;

plotAFMdata(H, F, I, 200, 'Hw_P6.jpg')

%%
function plotAFMdata(H, F, I, ss, saveName)
    % 创建指定背景的图
    f = figure('Position', [100, 100, 1000, 460], 'PaperPositionMode', 'auto', 'Color', 'w');
    movegui(f, 'center');%确保图像移动到中间
    
    % Figure1
    subplot(2, 2, 1);
    surf(H, 'CData', F, "FaceColor", "interp", 'EdgeColor', 'none');
    view(-45, 30);
    colorbar;
    my_bar = colorbar;
    title(my_bar,sprintf('Friction\n(mV)'),'FontSize',10);
    colormap jet;
    axis tight;
    title('Friction overlaid height');
    xlabel('nm', 'FontSize', 10, 'FontName', 'Arial');
    ylabel('nm', 'FontSize', 10, 'FontName', 'Arial');
    zlabel('Height (nm)', 'FontSize', 10, 'FontName', 'Arial');
    set(gca, 'FontSize', 10, 'FontName', 'Arial');
    grid off;
    box on; % 添加边界框

    % Figure2
    subplot(2, 2, 2);
    surf(H, 'CData', I, "FaceColor", "interp", "EdgeColor", "none");
    view(-45, 30);
    colorbar;
    my_bar = colorbar;
    title(my_bar,sprintf('Current\nResponse (V)'));
    my_bar.Title.FontSize = 10;
    colormap jet;
    axis tight;
    grid off;
    title('Current overlaid height');
    xlabel('nm', 'FontSize', 10, 'FontName', 'Arial');
    ylabel('nm', 'FontSize', 10, 'FontName', 'Arial');
    zlabel('Height (nm)', 'FontSize', 10, 'FontName', 'Arial');
    set(gca, 'FontSize', 10, 'FontName', 'Arial');
    grid off;
    box on; % 添加边界框

    % Figure3
    subplot(2, 2, 3);
    plot(F(:), I(:), 'k.');% 将一切托付给Matlab（不是
    title('Current vs Friction', 'FontSize', 10, 'FontName', 'Arial');
    xlabel('Friction (mV)', 'FontSize', 10, 'FontName', 'Arial');
    ylabel('Current (V)', 'FontSize', 10, 'FontName', 'Arial');
    set(gca, 'FontSize', 10, 'FontName', 'Arial');

    % Figure4
    subplot(2, 2, 4);
    histogram(I(:), 'BinLimits', [-1, 7], 'FaceColor', 'b');
    title('Current histogram', 'FontSize', 10, 'FontName', 'Arial');
    xlabel('Current response (V)', 'FontSize', 10, 'FontName', 'Arial');
    ylabel('Counts', 'FontSize', 10, 'FontName', 'Arial');
    set(gca, 'FontSize', 10, 'FontName', 'Arial');

    % 将图保存为 JPEG 文件
    saveas(gcf, saveName, 'jpeg');

    % 关闭图形窗口
    close(gcf);
end
