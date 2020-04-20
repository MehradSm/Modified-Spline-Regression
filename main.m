% Script to generate and fit simulated data arcording to a conditional intensity
% with spline based history dependence

close all;clear;clc; 
%% Basis Functions

% 1. Cadinal Spline
% Define spline parameters
lastknot = 200;lag=200;
c_pt_c = [-10 0 10 20 40 100 201 210]; % Define control points
s = 0.5;  % Define Tension Parameter

% Construct Spline Matrix
HistSpl_c = CardinalSpline(lastknot,c_pt_c,s);
% Simulate spiking activity
nsteps = 25000; % Define number of time steps 
theta = [-5 4 -2 .1 .5 .1 0.1 0.2 3];
[spiketrain,ytrue] = SimulateSpike(HistSpl_c,theta,lastknot,nsteps);

% Build design matrix for multiplicative history model
Hist = Hist(lastknot,spiketrain);
mtx_hist_c = Hist*HistSpl_c;
y = spiketrain(lag+1:end);
% Fit point process GLM
[b_hist_c ,dev_hist_c, stat_hist_c] = glmfit(mtx_hist_c,y,'poisson');
[yhat_hist_c,ylo_hist_c,yhi_hist_c] =glmval(b_hist_c,HistSpl_c,'log',stat_hist_c);

% 2. Modified Cardial Spline
% Define spline parameters
c_pt_mc = [0 10 20 40 100 201];
s = 0.5; 
% Construct Spline Matrix
HistSpl_mc = ModifiedCardinalSpline(lag,c_pt_mc,s);
% Build design matrix for multiplicative history model
mtx_hist_mc = Hist*HistSpl_mc;
% Fit point process GLM
[b_hist_mc ,dev_hist_mc, stat_hist_mc] = glmfit(mtx_hist_mc,y,'poisson');
[yhat_hist_mc,ylo_hist_mc,yhi_hist_mc] =glmval(b_hist_mc,HistSpl_mc,'log',stat_hist_mc);

% 3. RaisedCosine 
% Define spline parameters
b = 15;a =4;nbases = 6;cntrspace = pi/2;
t=1:lag;
% Construct Raised Cosine Matrix
[bases_hist,phi] = RaisedCos(t,a,b,nbases,cntrspace);
% Build design matrix for multiplicative history model
mtx_hist_rc = Hist*bases_hist;
% Fit point process GLM
[b_hist_rc ,dev_hist_rc, stat_hist_rc] = glmfit(mtx_hist_rc,y,'poisson');
[yhat_hist_rc,ylo_hist_rc,yhi_hist_rc] = glmval(b_hist_rc,bases_hist,'log',stat_hist_rc);

% 4. Indicator Function 
% Define Indicator parameters
NumInd=50;eps=0.01;
% Construct Indicator Matrix
ind_lag = Indicator(t',NumInd,eps);
% Build design matrix for multiplicative history model
mtx_hist_i = Hist*ind_lag;
% Fit point process GLM
[b_hist_i ,dev_hist_i, stat_hist_i] = glmfit(mtx_hist_i,y,'poisson');
[yhat_hist_i,ylo_hist_i,yhi_hist_i] = glmval(b_hist_i,ind_lag,'log',stat_hist_i);

%% Visualization
figure;
subplot(2,2,1);plot(1:lastknot,ytrue,1:lastknot,yhat_hist_i,1:lastknot,yhat_hist_i+yhi_hist_i,'r.',1:lastknot,yhat_hist_i-ylo_hist_i,'r.');
xlabel('Lag (ms)');grid
ylabel('Intensity');title('indicator function')
legend('True','Model fit','Error bounds');
subplot(2,2,2);plot(1:lastknot,ytrue,1:lastknot,yhat_hist_c,1:lastknot,yhat_hist_c+yhi_hist_c,'r--',1:lastknot,yhat_hist_c-ylo_hist_c,'r--');
xlabel('Lag (ms)');grid
ylabel('Intensity');title('cardinal spline')
legend('True','Model fit','Error bounds');
subplot(2,2,3);plot(1:lastknot,ytrue,1:lastknot,yhat_hist_rc,1:lastknot,yhat_hist_rc+yhi_hist_rc,'r--',1:lastknot,yhat_hist_rc-ylo_hist_rc,'r--');
xlabel('Lag (ms)');grid
ylabel('Intensity');title('raised cosine')
legend('True','Model fit','Error bounds');
subplot(2,2,4);plot(1:lastknot,ytrue,1:lastknot,yhat_hist_mc,1:lastknot,yhat_hist_mc+yhi_hist_mc,'r--',1:lastknot,yhat_hist_mc-ylo_hist_mc,'r--');
xlabel('Lag (ms)');grid
ylabel('Intensity');title('modified spline')
legend('True','Model fit','Error bounds');

%% Goodness-of-Fit

%Confidence Bound
% Compute SRR which is square root ratio of the confidence
% interval width at the end point over the average of 
% confidence interval width in the interior regions.
avg_midl_c = mean(yhi_hist_c(10:190)+ylo_hist_c(10:190));
avg_midl_rc = mean(yhi_hist_rc(10:190)+ylo_hist_rc(10:190));
avg_midl_mc = mean(yhi_hist_mc(10:190)+ylo_hist_mc(10:190));
srr_hist_rc =  sqrt([(yhi_hist_rc(1) + ylo_hist_rc(1))/avg_midl_rc  (yhi_hist_rc(end) + ylo_hist_rc(end))/avg_midl_rc]);
srr_hist_c = sqrt([(yhi_hist_c(1) + ylo_hist_c(1))/avg_midl_c  (yhi_hist_c(end) + ylo_hist_c(end))/avg_midl_c]);
srr_hist_mc =  sqrt([(yhi_hist_mc(1) + ylo_hist_mc(1))/avg_midl_mc  (yhi_hist_mc(end) + ylo_hist_mc(end))/avg_midl_mc]);
srr_hist_i =  [yhi_hist_i(1) + ylo_hist_i(1)  yhi_hist_i(end) + ylo_hist_i(end)];
