% Random Walk generator and creates a gif
n = 100000; % number of steps taken
rng(12345)
x=zeros(n, 1); % cumulative x and y coordinates
y=zeros(n,1);
for i=2:n
    a=rand(); % random number generated for x and y
    b=rand();
    if(a>0.5) % decision between North/South and East/West
        if(b>0.5) % decision between North and South
            y(i)= y(i-1)+1;
        else
            y(i)= y(i-1)-1;
        end
        x(i)=x(i-1);
    else
        if(b>0.5) % decision between East and West
            x(i)= x(i-1)-1;
        else
            x(i)= x(i-1)+1;
        end
        y(i)=y(i-1);
    end
    
end

% creates gif in increments of 1000
for i=1:1000:100000
    
    h=plot(x(1:i), y(1:i)) % plot the path taken
    axis([-150, 200, -100, 200])
    set(h,'LineWidth',0.01, 'color', 'b')
    hold on;
    plot(0, 0, 'ro') % plots the starting point
    % gif creation
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'walk.gif';
    
    % creates the file if its the first loop, otherwise appends
    if i==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
end