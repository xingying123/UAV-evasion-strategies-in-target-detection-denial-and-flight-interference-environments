function [gBestScore,gBest,cg_curve]=BITCN_BIGRU_AAM(N,iter,lb,ub,dim,y)

% Infotmation
Vmax=ones(1,dim).*(ub-lb).*0.1;           %速度最大值0.15
noP=N;
w=0.7;%w=0.7;
c1=1.5;%c1=1.5;
c2=1.5;%c2=1.5;

% Initializations
vel=zeros(noP,dim);
bBestScore=zeros(noP);
pBest=zeros(noP,dim);
gBest=zeros(1,dim);
cg_curve=zeros(1,iter);

% Random initialization for agents.

lb=ones(1,dim).*(lb);                              % Lower limit for variables
ub=ones(1,dim).*(ub);                              % Upper limit for variables

%% Initialization
for i=1:dim
    bba(:,i) = lb(i)+rand(N,1).*(ub(i) - lb(i));                          % Initial population
end


for i=1:noP
    bBestScore(i)=inf;
end

% Initialize gBestScore for a minimization problem
gBestScore=inf;


for l=1:iter
    
    % Return back the particles that go beyond the boundaries of the search space
    for i=1:size(bba,1)
        Flag4ub=bba(i,:)>ub;
        Flag4lb=bba(i,:)<lb;
        bba(i,:)=(bba(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
    end
    
    for i=1:size(bba,1)
        %Calculate objective function for each particle
        fitness= y(bba(i,:) );
        if(bBestScore(i)>fitness)
            bBestScore(i)=fitness;
            pBest(i,:)=bba(i,:);
        end
        if(gBestScore>fitness)
            gBestScore=fitness;
            gBest=bba(i,:);
        end
    end
    
    %Update the W of BITCN-BIGRU-AAM
  
    %Update the Velocity and Position of particles
    for i=1:size(bba,1)
        for j=1:size(bba,2)
            vel(i,j)=w*vel(i,j)+c1*rand()*(pBest(i,j)-bba(i,j))+c2*rand()*(gBest(j)-bba(i,j));
            
            if(vel(i,j)>Vmax(j))
                vel(i,j)=Vmax(j);
            end
            if(vel(i,j)<-Vmax(j))
                vel(i,j)=-Vmax(j);
            end
            bba(i,j)=bba(i,j)+vel(i,j);
        end
    end
    cg_curve(l)=gBestScore;
end

end