% sample1 = generate_random_data(20,'normal',0,1); 
% sample2 = generate_random_data(20,'normal',2,1);
% [X1,Y1] = cumhist(sample1);
% [X2,Y2] = cumhist(sample2);
% figure;
% plot(X1,Y1,'r-');
% hold on
% plot(X2,Y2,'b-');
% axis([-10 10 0 100]);
% xlabel('values of 2 samples of size 20');
% ylabel('Percent of data');
% [h,pvalue] = kstest2(sample1,sample2)

% squirrel_births = load('squirrel_births.txt','-ascii');
% simulate_random_sampling(squirrel_births, 30, 1000);
% title('The sample mean of squirrel birth days for 1000 sampling experiments');
% 
% [samplemean_ten,X] = simulate_random_sampling(squirrel_births, 10, 1000);
% title('Sample means of squirrel birth days for 1000 experiments, 10 samples');
% [samplemean_thirty,X] = simulate_random_sampling(squirrel_births, 30, 1000);
% title('Sample means of squirrel birth days for 1000 experiments, 30 samples');
% [samplemean_sixty,X] = simulate_random_sampling(squirrel_births, 60, 1000);
% title('Sample means of squirrel birth days for 1000 experiments, 60 samples');

% human_births = load('human_births.txt','-ascii');
% simulate_random_sampling(human_births, 30, 1000);
% title('Sample means of birth days for 1000 sampling experiments, 30 samples');
% heads_coinflips = load('heads_coinflips.txt','-ascii');
% simulate_random_sampling(heads_coinflips, 30, 1000);
% title('Sample means of number of heads for 1000 sampling experiments, 30 samples');

squirrel_births = load('squirrel_births.txt','-ascii');
simulate_random_sampling(squirrel_births, 30, 1000);
title('Sample means of squirrel birth days for 1000 experiments, 30 samples');
R = randperm(length(squirrel_births));
S_30 = squirrel_births(R(1:30));
Sm = mean(S_30);
S_standarddeviation = std(S_30); % std calculates the standard deviation
Std_error = S_standarddeviation/sqrt(30);
figure;
X = 1:200;
dX = 1;
Nus = dX*exp(-(power(X-Sm,2)/(2*power(Std_error,2))))/sqrt(2*pi*power(Std_error,2));
cumulative = cumsum(Nus);
hold on
plot(X,Nus,'g-');
plot(X,cumulative,'g--');
