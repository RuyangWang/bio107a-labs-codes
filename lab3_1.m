load temperatures

%{
figure(100);
plot(BlueHills(:,1),BlueHills(:,2),'b-');
xlabel('Time (years AD)');
ylabel('Temperature (degrees C)')
legend('Blue Hills');

remainders = BlueHills(:,1)-fix(BlueHills(:,1));
july_indexes = find(abs(remainders-0.5) < 0.0001);
july_indexes(1:10) % the index values
BlueHills(july_indexes(1:10),2) % the temperatures at those index values
figure(100);
hold on
plot(BlueHills(july_indexes,1),BlueHills(july_indexes,2),'bo'); 

july_temps = BlueHills(july_indexes,2);
figure(101);
[xbh,ybh]=cumhist(july_temps);
plot(xbh,ybh,'b-');
axis([10 40 0 100]);
xlabel('Mean temperature in July (C)');
ylabel('Fraction of years');


all_t = BlueHills(:,1);  
first_t = all_t(1);
% inds = find(all_t == first_t + 1/12);
% figure;
% plot(abs(all_t-(first_t+1/12)),'-o');
% xlabel('Sample index number');
% ylabel('Difference from the first time point + 1/12')

inds = find( abs(all_t-(first_t+1/12))< 0.0001);
BlueHills(1,2);
BlueHills(inds,2);
x = []; % start with an empty matrix
y = [];
for i=1:length(all_t)
    target_time = all_t(i) + 1/12;
    inds = find( abs(all_t-(target_time))< 0.0001);
    if length(inds)>0, % if we have a match (because we might not)
        x(end+1) = BlueHills(i,2);
        y(end+1) = BlueHills(inds,2);
    end;
end;
R = corrcoef(x,y);
R(1,2)
%

lags = [-1:1/12:1]; % look over an entire year in 1 month steps
tolerance = 0.0001;
alpha = 0.05;
[R,S]=correlogram(BlueHills(:,1),BlueHills(:,2),BlueHills(:,1),BlueHills(:,2),...
lags,tolerance,alpha);
figure;
plot(lags,R);
hold on;
plot(lags,-S,'--');
plot(lags,S,'--');
xlabel('Time lag (years)');
ylabel('Correlation coefficient');
title('Correlogram: Blue Hills Reservation');

figure(100);
hold on;
plot(McMurdo(:,1),McMurdo(:,2),'r-');
legend('Blue Hills','Blue Hills July','McMurdo');
[R2,S2]=correlogram(BlueHills(:,1),BlueHills(:,2),McMurdo(:,1),McMurdo(:,2),...
lags,tolerance,alpha);
figure;
plot(lags,R2);
hold on;
plot(lags,-S2,'--');
plot(lags,S2,'--');
xlabel('Time lag (years)');
ylabel('Correlation coefficient');
title('Correlogram: Blue Hills * McMurdo');
%}

%{
ecg = load('normalecg.txt');
figure;
plot(ecg)
xlabel('Sample number');
ylabel('Voltage (mV)');

SR = 128;
t = 0:1/SR:(length(ecg)-1)/SR;

figure(102);
plot(t,ecg)
xlabel('Time (s)');
ylabel('Voltage (mV)');

threshold = 2;
spike_samples = threshold_crossings(ecg, threshold); 
figure(102);
hold on;
plot(t(spike_samples),ecg(spike_samples),'bo');

avg_heart_rate = 60 * length(spike_samples)/(t(end)-t(1));
text(40,3,['Rate = ' num2str(avg_heart_rate,2)]);

spike_times = t(spike_samples);
spike_diffs = spike_times(2:end) - spike_times(1:end-1); % beat-by-beat time diffs
spike_instantaneous_rates = 1./spike_diffs;
figure;
plot(spike_times(2:end),60*spike_instantaneous_rates);
ylabel('Instantaneous heart rate');
xlabel('Time(s)');
}
