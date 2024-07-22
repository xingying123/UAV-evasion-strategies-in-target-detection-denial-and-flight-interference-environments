clc;clear;close all
%% Test network performance
% Load the trained network
load('net(x-h).mat')
% Load the nominal value
datay = importdata('y.txt');
% Set the initial value of the current flight state to generate the trajectory online
x0 = [0.05; 19.95];
% Online generation testing
datann(1,:)=x0;
for jj=2:length(datay(:,1))
y0=net(x0);
datann(jj,:)=y0.'; x0=y0;
end

% Plot
plot(datann(1,:),datann(2,:).','--','Linewidth',2),hold on
clear net;

%% Testing  improved network performance
% Load the improved network
load('net(x-h2).mat')
datay = importdata('y.txt');
x0 = [0.5;19.95];
% Online generation testing
datann(1,:)=x0;
for jj=2:length(datay(:,1))
y0=net(x0);
datann(jj,:)=y0.'; x0=y0;
end

% Plot
plot(datann(1,:),datann(2,:).','--','Linewidth',2),hold on
plot(datay(1,:),datay(2,:).',':','Linewidth',2),hold off
xlabel('\it\fontname{Times New Roman}X/\rm\fontname{Times New Roman}km','FontSize',18)
ylabel('\it\fontname{Times New Roman}h/\rm\fontname{Times New Roman}(km)','FontSize',18)
legend('Traditional RBF NN','Improved RBF NN','Nominal Trajectory'),set(gca,'FontName','Time New Roman')












