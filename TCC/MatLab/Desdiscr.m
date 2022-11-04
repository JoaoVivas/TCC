clc;
clear all;
close all;

global Np

[filename,PathName] = uigetfile('*.gcode','Select the G-CODE file');

CommandArray = InputGcode(filename,PathName);

MX = 200; % (g)
KX = 20; % (N/m)
BX = 1; % (N.s/m)
MaxAccelX = 10000;

MY = 200; % (g)
KY = 2000; % (N/m)
BY = 1; % (N.s/m)
MaxAccelY = 10000;

omegaX=(KX/(MX/1000))^0.5;
omegaY=(KY/(MY/1000))^0.5;

FreqX = omegaX*2*pi
FreqY = omegaY*2*pi

PerdX = 1/FreqX
PerdY = 1/FreqY

if PerdX > PerdY
    PerdT = PerdY;
else
    PerdT = PerdX;
end

%dv = ds/dt
%ds = dv*dt/100

gX = CommandArray(1,:)';
gY = CommandArray(2,:)';
FeedRate = CommandArray(5,:);

basepoints = [gX'; gY'];

%step = 1;
ctr = 1;

LastPos = [0;0];
LastVel = [0;0];
LastVelMod = 0;
LastFeed = 0;
points = [];
for i=1:size(gX)
    NextPos = [gX(i);gY(i)];
    NextFeed = FeedRate(i)/60;
    DelPos = NextPos-LastPos;
    DesMod = norm(NextPos-LastPos);
    if DesMod == 0
        DesDir = [0;0];
    else
        DesDir = DelPos/DesMod;
    end
    NextVel = NextFeed*DesDir;
    %step = NextFeed*PerdT;
    step = 2;
    Nsteps = round(DesMod/step)-1;
    if Nsteps > 0
        for steps=1:Nsteps
            NewPoint = (LastPos+DesDir*steps*step);
            
            points(1,ctr) = NewPoint(1);
            points(2,ctr) = NextVel(1);
            
            points(3,ctr) = NewPoint(2);
            points(4,ctr) = NextVel(2);
            
            deltat = step/NextFeed;
            points(5,ctr) = deltat;
            
            ctr=ctr+1;
            %%LastPos = NewPoint;
        end
    end
    points(1,ctr) = NextPos(1);
    points(3,ctr) = NextPos(2);
    DesMod = norm(NextPos-LastPos);
    deltat = DesMod/NextFeed;
    points(5,ctr) = deltat;
    if i == size(gX)
        points(2,ctr)= 0;
        points(4,ctr)= 0;
    else
        points(2,ctr) = NextVel(1);
        points(4,ctr) = NextVel(2);
    end    
    ctr=ctr+1;
    LastPos = NextPos;
end

Mp = size(points');
Np = Mp(1);

figure

plot(points(1,:), points(3,:),'*')

figure
plot(basepoints(1,:), basepoints(2,:), '*')