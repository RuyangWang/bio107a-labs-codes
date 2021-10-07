% chicken_weights = load('chickenweights_control_experimental.txt','-ascii');
% chicken_control = chicken_weights(:,1); % grab the first column
% chicken_exper = chicken_weights(:,2); % grab the 2nd column
% mn1 = mean(chicken_control);
% mn2 = mean(chicken_exper);
% 
% figure;
% bar(1,mn1,'w');
% hold on;
% bar(2,mn2,'w');
% plot(1,chicken_control,'go');
% plot(2,chicken_exper,'rs');
% xlabel('Groups');
% ylabel('Weight');
% title('Chicken weights after normal feed (left) or enriched feed (right)');
% 
% figure;
% se_control = std(chicken_control)/sqrt(length(chicken_control));
% se_enriched = std(chicken_exper)/sqrt(length(chicken_exper));
% bar(1,mn1,'w');
% hold on;
% bar(2,mn2,'w');
% plot([1 1],[mn1-se_control mn1+se_control],'k-');
% plot([2 2],[mn2-se_enriched mn2+se_enriched],'k-');
% xlabel('Groups');
% ylabel('Weight');
% title('Chicken weights after normal feed (left) or enriched feed (right)');
% 
% chicken_exper2 = chicken_exper + 50*randn(size(chicken_exper));
% chicken_control2 = chicken_control + 50*randn(size(chicken_control));
% mn1_2 = mean(chicken_control2);
% mn2_2 = mean(chicken_exper2);
% figure;
% bar(1,mn1_2,'w');
% hold on;
% bar(2,mn2_2,'w');
% plot(1,chicken_control2,'go');
% plot(2,chicken_exper2,'rs');
% xlabel('Groups');
% ylabel('Weight');
% title('Noisy weights after normal feed (left) or enriched feed (right)');
% figure;
% se_control2 = std(chicken_control2)/sqrt(length(chicken_control2));
% se_enriched2 = std(chicken_exper2)/sqrt(length(chicken_exper2));
% bar(1,mn1_2,'w');
% hold on;
% bar(2,mn2_2,'w');
% plot([1 1],[mn1_2-se_control2 mn1_2+se_control2],'k-');
% plot([2 2],[mn2_2-se_enriched2 mn2_2+se_enriched2],'k-');
% xlabel('Groups');
% ylabel('Weight');
% title('Noisy weights after normal feed (left) or enriched feed (right)');

mydata1 = 100*generate_random_data(100,'normal',1,1);
[N,bin_centers] = histbins(mydata1,[-500:100:500]);
f = figure;
bar(bin_centers,N);
xlabel('X'); 
ylabel('Y');
% ch = get(f,'children');
% set(f,'Color',[1 1 1]); % changes the background color to red
% set(f,'MenuBar','none'); % turns off the menu bar
% ax = gca;
% axis([-500 500 0 50]);
% set(ax,'YTick', [0 50]);
% set(ax,'YDir','reverse');
% set(ax,'YDir','normal');

%{
mydata1 = 100*generate_random_data(100,'normal',1,1);
mydata2 = 100*generate_random_data(100,'normal',1,1);
[X1,Y1] = cumhist(mydata1);
[X2,Y2] = cumhist(mydata2);
f = figure;
[N1,bin_centers] = histbins(mydata1,[-600:100:600]);
[N2,bin_centers] = histbins(mydata2,[-600:100:600]);
ax1=subplot(2,2,1);
plot(X1,Y1,'k-');
axis([-600 600 0 100]);
xlabel('Value');
ylabel('Fraction of data 1');
ax2=subplot(2,2,2);
plot(X2,Y2,'k-');
axis([-600 600 0 100]);
xlabel('Value');
ylabel('Fraction of data 2');
ax3=subplot(2,2,3);
bar(bin_centers,N1,'k');
xlabel('Value');
ylabel('Number of data 1 points');
ax4=subplot(2,2,4);
bar(bin_centers,N2,'k');
xlabel('Value');
ylabel('Number of data 2 points');
ch = get(f,'children');
%}