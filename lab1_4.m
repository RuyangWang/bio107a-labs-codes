sample1 = load('change_mineral_breastfeeding.txt','-ascii'); 
sample2 = load('change_mineral_other.txt','-ascii');

[X1,Y1] = cumhist(sample1);
[X2,Y2] = cumhist(sample2);

%
figure(114514);
plot(X1,Y1,'bo-');
hold on;
plot(X2,Y2,'ro-');
axis([-10 10 0 100]);
xlabel('Change in mineral content');
ylabel('Percent of samples');
title('Blue=breastfeeding women, Red=other women');
%}


% sort(sample1)
%  % now let's sort sample1 and sample2 together;
%  % [sample1; sample2] makes a big list of the samples
% sort([sample1; sample2])
% unique(sample1)
% unique([sample1; sample2])
bin_edges = unique([sample1; sample2]);
bin_counts1 = histc(sample1, bin_edges);
bin_counts2 = histc(sample2, bin_edges);
%
figure;
bar(bin_edges, bin_counts1);
title('Histogram 1');
figure;
bar(bin_edges, bin_counts2);
title('Histogram 2');
%}

%
A = [ 1 2 3 4 5];
cumsum(A)
cumsum1 = cumsum(bin_counts1) / sum(bin_counts1);
cumsum2 = cumsum(bin_counts2) / sum(bin_counts2);
figure;
plot(bin_edges,cumsum1,'b-');
hold on;
plot(bin_edges,cumsum2,'r-');
xlabel('Sample values');
ylabel('Cumulative sum of samples');
%}

%
[maxdiff, maxdiff_location, Xvalues, sample1CDF, sample2CDF] = cumulative_hist_diff(sample1,sample2);
figure;
plot(Xvalues,sample1CDF,'b-');
hold on;
plot(Xvalues,sample2CDF,'r-');
xlabel('Change in mineral content');
ylabel('Percent of samples');
title('Blue=breastfeeding women, Red=other women');
X_loc = [ Xvalues(maxdiff_location) Xvalues(maxdiff_location) ]
Y_loc = [ sample1CDF(maxdiff_location) sample2CDF(maxdiff_location)]
plot(X_loc, Y_loc,'k-','linewidth',2);
%}

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