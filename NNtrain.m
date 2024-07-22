%% Import data
clc;clear;close all;
% Import data base
data = importdata('x-h.txt'); 
%% Set input and output
input=[]; output=[];
input=[input; data(1:end-1,1:2)];
% input=[input; data(:,1)];
output=[output; data(2:end,1:2)];
% output=[output; data(:,2)];
%% Training network
% Set the number of neurons
net = feedforwardnet([10 10 10]);
% Set activation function
% Input layer
net.layers{1}.transferFcn = 'logsig';
% 将隐藏层的转移函数设置为径向基函数（Radial basis function，简称RBF）
net.layers{2}.transferFcn = 'radbas'; 
% Output layer
net.layers{3}.transferFcn = 'purelin';

%-------------
%--- input. 'and output.' indicates that input and output data should be column vectors
%--- In MATLAB, the dot ('.) represents the transpose operation of an array or matrix
%--- This means that input and output should be matrices, where each column is a sample and each row is a feature or response variable.
%--- During the training process, the network will learn to predict output data from input data
%-------------
% Set the number of iterations
net.trainParam.epochs = 2000; 
% net.performParam.regularization = 0.01;
% [loss, gradients] = dlfeval(@modelLoss, net, X, T);

% Improved mean squared error L2loss
net.performFcn = 'mse';
net = train(net,input.',output.');

% Save the trained network
save('net(x-h).mat','net');
% Load trained network
load('net(x-h).mat');     


