% % generates "bell curve" data with mean 1 and standard deviation 1
% mydata1 = 100*generate_random_data(10,'normal',1,1); 
% % generates "bell curve" data with mean 0 and standard deviation 1
% mydata2 = 100*generate_random_data(10,'normal',0,1); 
% mn1 = mean(mydata1);
% mn2 = mean(mydata2);
% figure;
% bar(1,mn1,'w');
% hold on; % leave the current plot on the figure
% bar(2,mn2,'w');
% plot(1,mydata1,'og')
% plot(2,mydata2,'sb')
% axis([0 3 -300 500])
% xlabel('Class number');
% ylabel('Change in student happiness');
% title('Change in student happiness in Class 1 vs. Class 2, bar');
% 
% figure;
% hist(mydata1,10); % creates a histogram with 10 bins
% xlabel('Change in happiness after Class 1');
% ylabel('Number of occurrences');
% title('Change in student happiness in Class 1 vs. Class 2, hist');
% 
mydata1000 = 100*generate_random_data(1000,'normal',1,1);
% figure;
% hist(mydata1000,100); % creates a histogram with 100 bins
% xlabel('Change in happiness after Class 1');
% ylabel('Number of occurrences');
% title('Change in student happiness in Class 1 vs. Class 2, 1000 data, hist 100 bins');
% 
% figure;
% hist(mydata1,100); % creates a histogram with 100 bins
% xlabel('Change in happiness after Class 1');
% ylabel('Number of occurrences');
% title('Change in student happiness in Class 1 vs. Class 2, hist 100 bins');

% bin_edges = [ 0 1 2 3 4 5 ];
% data = [ 0.5 0.5 1.5 1.5 3 3.5 3.5 3.7 4 4 ];
% % figure;
% % hist(data,6);
% N = histc(data, bin_edges); % get the counts for each bin
% N,  % look at the counts
% bin_centers = bin_edges + 0.5; 
% figure;
% bar(bin_centers,N);
% xlabel('Value');
% ylabel('Number of occurrences');
% title('Change in student happiness in Class 1 vs. Class 2, bar example');

% bin_edges = [ -1000:100:1000 ];
% 
% N = histc(mydata1000, bin_edges); % get the counts for each bin
% 
% bin_centers = (bin_edges(1:end-1)+bin_edges(2:end))/2; 
% 
%   % histc actually returns an extra bin in N containing values that
% 
%   % are exactly bin_edges(end); we don't want this so let's drop this bin
% N = N(1:end-1);
% 
% figure;
% 
% bar(bin_centers,N);
% 
% xlabel('Change in happiness after Class 1');
% 
% ylabel('Number of occurrences');
% 
% figure;
hist(mydata1000,20);