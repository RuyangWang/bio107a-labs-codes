% sample1 = generate_random_data(20,'normal',0,1); 
% sample2 = generate_random_data(20,'normal',0,1);
% [X1,Y1] = cumhist(sample1);
% [X2,Y2] = cumhist(sample2);
% figure(90);
% plot(X1,Y1,'bo-');
% hold on;
% plot(X2,Y2,'ro-');
% axis([-10 10 0 100]);
% xlabel('Value');
% ylabel('Percent of samples');
% 
% [maxdiff,maxdiff_loc,Xval,sample1CDF,sample2CDF] = cumulative_hist_diff(sample1,sample2);
% figure(90);
% Xvalues = [ Xval(maxdiff_loc) Xval(maxdiff_loc) ];
% Yvalues = 100 * [ sample1CDF(maxdiff_loc) sample2CDF(maxdiff_loc) ];
% plot(Xvalues,Yvalues,'k-','linewidth',2);

md = [];
i = 1;

while (i<1001),
    sample1 = generate_random_data(20,'normal',0,1);
    sample2 = generate_random_data(20,'normal',0,1);
    maxdiff = cumulative_hist_diff(sample1,sample2);
    md(i) = maxdiff;
    i = i + 1;
end;

[Xmd,Ymd] = cumhist(md);
figure(100);
axis([0 1 0 100]);
plot(Xmd,Ymd,'k-');
xlabel('Max diff b/w 2 samples of size 20');
ylabel('Percent of data');

md_median = median(md);
md_95 = prctile(md,95);
md_99 = prctile(md,99);

sample1 = generate_random_data(20,'normal',0,1); 
sample2 = generate_random_data(20,'normal',2,1);
[X1,Y1] = cumhist(sample1);
[X2,Y2] = cumhist(sample2);
maxdiff = cumulative_hist_diff(sample1,sample2);
% figure(101);
% plot(X1,Y1,'r-');
% hold on
% plot(X2,Y2,'b-');
% axis([-10 10 0 100]);
% xlabel('values of 2 samples of size 20');
% ylabel('Percent of data');
figure(100);
hold on;
plot([maxdiff maxdiff],[0 100],'g-'); % we'll plot a green vertical bar

x = 0:0.01:1; % create the X points
n1 = 20;
n2 = 20;
math_cdf = ks2_cdf(n1, n2, x);
math_cdf_percent = 100*math_cdf; % convert to percent rather than fraction
figure(100);
hold on;
plot(x,math_cdf_percent,'k--'); % black dashed line

function [maxdiff, maxdiff_location, Xvalues, sample1CDF, sample2CDF] = cumulative_hist_diff(sample1,sample2)
% CUMULATIVE_HIST_DIFF - Calculates the maximum difference b/w 2 samples
%    [MAXDIFF,MAXDIFF_LOCATION, XVALUES, SAMPLE1CDF, SAMPLE2CDF] = ...
%          dasw.stats.cumulative_hist_diff(SAMPLE1, SAMPLE2)
%
%   Inputs:  SAMPLE1 - an array of sample data
%            SAMPLE2 - an array of sample data
%   Outputs: MAXDIFF - The maximum (absolute) difference between the samples
%            MAXDIFF_LOCATION - The x-axis location of the maximum difference
%            XVALUES - The X-axis values for the cumulative density functions
%            SAMPLE1CDF - The cumulative density function of SAMPLE1
%            SAMPLE2CDF - The cumulative density function of SAMPLE2
bin_edges = [unique([sample1; sample2])];
bin_counts1 = histc(sample1, bin_edges);
bin_counts2 = histc(sample2, bin_edges);
Xvalues = bin_edges;
sample1CDF = cumsum(bin_counts1) / sum(bin_counts1);
sample2CDF = cumsum(bin_counts2) / sum(bin_counts2);
[maxdiff, maxdiff_location] = max( abs(sample1CDF-sample2CDF) );
end