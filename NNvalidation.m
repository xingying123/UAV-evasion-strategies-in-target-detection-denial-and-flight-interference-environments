%% Validation network performance
clc;clear;close all;
% Performance comparison between input nominal value and training results
% Load the nominal value
datay = importdata('y.txt'); 
% Load the trained network
load('net(x-h).mat');
% Set initial values for online planning
x0 = [-0.009157;19.996221]; 

%% Validation network
datann(1,:)=x0;
for jj=2:length(datay(:,1))
y0=net(x0);
datann(jj,:)=y0.'; x0=y0;
end

% Draw a comparison chart with the nominal value
figure(1)
plot(datamm(1,:),datann(1,:),':','Linewidth',2),hold on
plot(datay(1,:),datay(2,:),'-','Linewidth',2),hold off
figure(1), xlabel('\it\fontname{Times New Roman}x \rm\fontname{Times New Roman}(km)','FontSize',18)
figure(1), ylabel('\it\fontname{Times New Roman}h \rm\fontname{Times New Roman}(km)','FontSize',18)
legend('Online optimization trajectory','Nominal trajectory'),set(gca,'FontName','Time New Roman')

% Draw error comparison chart
figure(2)
loss = (datann(2,:)-datay(2,:));
plot(D(1,:),loss.*1000,'-','Linewidth',2)
figure(2), xlabel('\it\fontname{Times New Roman}X/\rm\fontname{Times New Roman}m','FontSize',18)
figure(2), ylabel('\it\fontname{Times New Roman}\Deltah/\rm\fontname{Times New Roman}m','FontSize',18)






