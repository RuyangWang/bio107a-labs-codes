heights = load('children_heights.txt','-ascii');
boys = find(heights(:,2)==1);
girls = find(heights(:,2)==0);

%{
mn_total = mean(heights(:,1)); % compute the mean of whole data set
mn_girls = mean(heights(girls,1)); % compute mean of girls
mn_boys = mean(heights(boys,1)); % compute mean of boys
bar([1 2 3],[mn_total mn_girls mn_boys],'w');
hold on
plot(1,heights(:,1),'go'); % plot all heights
plot(2,heights(girls,1),'rd'); % plot girl heights
plot(3,heights(boys,1),'bs'); % plot boy heights
[h,p_t] = ttest2(heights(girls,1),heights(boys,1));


variance_per_point=var(heights(:,1),1); 
number_points = length(heights(:,1));
total_variance = number_points * var(heights(:,1),1)
girl_variance = length(girls) * var(heights(girls,1),1)
boy_variance = length(boys) * var(heights(boys,1),1)
within_variance = boy_variance + girl_variance
between_variance=length(boys)*(mn_boys-mn_total)^2+length(girls)*(mn_girls-mn_total)^2
total_variance - (within_variance + between_variance) %should==0, up to rounding
explained_variance = 100 * between_variance/total_variance
unexplained_variance = 100 * within_variance/total_variance

[p_a,table]=anova1(heights(:,1),heights(:,2))

outcomes = [];
i = 1;
while i<10000,
A = randn(5,1); % 5 normally-distributed points, mean 0 std dev 1
B = randn(5,1); % 5 points from same distribution
[h,outcomes(i)] = ttest2(A,B);
i = i + 1;
end;
num_sig = length(find(outcomes<0.05));
100*num_sig/10000 % should be about 5%
p1 = 0.04;
p2 = 0.5; 
outcome1 = p1<0.05 | p2<0.05; % returns 1 for true since p1<0.05 OR p2<0.05
outcome2 = p1<0.01 | p2<0.01; % returns 0 for false since neither expression is true
outcomes_dumb = [];
outcomes_anova = [];
G = [1;1;1;1;1;2;2;2;2;2;3;3;3;3;3;4;4;4;4;4];
i=1;
while i<10000,
A = randn(5,1); % 5 normally-distributed points, mean 0 std dev 1
B = randn(5,1); % 5 points from same distribution
C = randn(5,1); % 5 points from same distribution
D = randn(5,1); % 5 points from same distribution
[h,p1] = ttest2(A,B);
[h,p2] = ttest2(A,C);
[h,p3] = ttest2(A,D);
[h,p4] = ttest2(B,C);
[h,p5] = ttest2(B,D);
[h,p6] = ttest2(C,D);
outcomes_dumb(i) = p1<0.05|p2<0.05|p3<0.05|p4<0.05|p5<0.05|p6<0.05;
outcomes_anova(i) = anova1([A;B;C;D;],G,'off'); % turn table off
i = i + 1;
end;
num_sig_dumb = length(find(outcomes_dumb>0));
100*num_sig_dumb/10000 % should be about 5%
num_sig_anova = length(find(outcomes_anova<0.05));
100*num_sig_anova/10000 % should be about 5%
%}

[X1,Y1] = cumhist(heights(boys,1));
[X2,Y2] = cumhist(heights(girls,1));
% figure;
% plot(X1,Y1,'b');
% hold on;
% plot(X2,Y2,'r');
% axis([40 75 0 100]);
% ylabel('Percent of data');
% xlabel('Heights (inches)');
% legend('Boys','Girls');

[discrim,pta,pfa,Xvalues] = roc_analysis(heights(girls,1),heights(boys,1));
figure;
plot(pfa,pta,'b'); % p of wrong guesses vs. correct guesses
hold on
plot([0 1],[0 1],'k--'); % line y=x
xlabel('Prob of incorrectly calling a girl a boy');
ylabel('Prob of correctly declaring a boy a boy');
figure;
plot(Xvalues(:),discrim(:));