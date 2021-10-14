tumor_data = load('tumor_example.txt','-ascii');
[change, rate,a,b,c,d] = tumorfit(tumor_data,5);
% figure;
% tumorplot(tumor_data,a,b,c,d);
% [change_d,rate_d,a_d,b_d,c_d,d_d] = analyze_tumors('tumor_study/drug');
% [change_p,rate_p,a_p,b_p,c_p,d_p] = analyze_tumors('tumor_study/placebo');
% figure;
% plot(cumhist(change_d));
% hold on;
% plot(cumhist(change_p));
[change_d,rate_d,a_d,b_d,c_d,d_d]=analyze_tumors_plot('tumor_study/drug',1);
[change_p,rate_p,a_p,b_p,c_p,d_p]=analyze_tumors_plot('tumor_study/placebo',1);