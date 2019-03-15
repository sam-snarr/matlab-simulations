% Approximating pi and creating a gif
close all; clear all; clc

format long
n=50000; % number of 'darts'
count=0;

x = rand(1, n); % 2 arrays of random numbers
y = rand(1, n);

xR = [];
yR = [];
xB = [];
yB = [];

error = [];
area = [];

for i=1:n % loops through all the iterations
    x(i) = -1 + x(i)*2; % determines point (x, y)
    y(i) = -1 + 2*y(i);
    r = sqrt(x(i)^2 + y(i)^2);
    if r<=1
        xR = horzcat(xR, x(i));
        yR = horzcat(yR, y(i));
        count = count+1;
    else
        xB = horzcat(xB, x(i));
        yB = horzcat(yB, y(i));
    end
    p = count/i; % proportion
    area = horzcat(area, p*4); % approximating the area
    error = horzcat(error, abs(pi-area(i))/pi);
    if mod(i, 200) ==0
        plot(xR, yR, '.r')
        title(['n: ', num2str(i, '%d') ' \pi \approx', num2str(area(i), '%5.8f') ' error = ' num2str(error(i)*100, '%2.3f') '%'])
        hold on;
        plot(xB, yB, '.b')
        
        % gif creation
        set(gcf,'color','w'); % set figure background to white
        drawnow;
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        outfile = 'pi_darts.gif';
        
        % creates the file if its the first loop, otherwise appends
        if i==200
            imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
        else
            imwrite(imind,cm,outfile,'gif','DelayTime',0, 'writemode','append');
        end
    end
end