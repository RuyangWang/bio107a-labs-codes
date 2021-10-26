chem = load('chemical_reaction.txt');
boxcar3 = [1 1 1]/3;
boxcar5 = [1 1 1 1 1]/5;
boxcar5 = ones(1,5)/5; % does the same thing as above
boxcar25 = ones(1,25)/25; % a longer-range boxcar
boxcar101 = ones(1,101)/101;

%{
figure;
plot(chem(:,1),chem(:,2));
ylabel('Reaction product (photocurrent uA/0.01 seconds)');
xlabel('Time(s)');
t = chem(:,1); % so we don't have to type chem(:,1) over and over
y3 = conv(chem(:,2),boxcar3,'same');
y5 = conv(chem(:,2),boxcar5,'same');
y25 = conv(chem(:,2),boxcar25,'same');
y101 = conv(chem(:,2),boxcar101,'same');
figure;
subplot(2,2,1);
plot(t,y3);
ylabel('Product');
xlabel('Time(s)');
title('Boxcar 3');
box off;
subplot(2,2,2);
plot(t,y5);
ylabel('Product');
xlabel('Time(s)');
title('Boxcar 5');
box off;
subplot(2,2,3);
plot(t,y25);
ylabel('Product');
xlabel('Time(s)');
title('Boxcar 25');
box off;
subplot(2,2,4);
plot(t,y101);
ylabel('Product');
xlabel('Time(s)');
title('Boxcar 101');
box off;
%}

%{
y3_ = conv(chem(:,2),boxcar3,'valid');
y5_ = conv(chem(:,2),boxcar5,'valid');
y25_ = conv(chem(:,2),boxcar25,'valid');
y101_ = conv(chem(:,2),boxcar101,'valid');
T_validindexes_101 = (1+(101-1)/2:length(t)-(101-1)/2);
size(T_validindexes_101)
T_validindexes_25 = (1+(25-1)/2:length(t)-(25-1)/2);
T_validindexes_5 = (1+(5-1)/2:length(t)-(5-1)/2);
T_validindexes_3 = (1+(3-1)/2:length(t)-(3-1)/2);
figure;
subplot(2,2,1);
plot(t(T_validindexes_3),y3_);
ylabel('Product');
xlabel('Time(s)');
title('Valid boxcar 3');
box off;
subplot(2,2,2);
plot(t(T_validindexes_5),y5_);
ylabel('Product');
xlabel('Time(s)');
title('Valid boxcar 5');
box off;
subplot(2,2,3);
plot(t(T_validindexes_25),y25_);
ylabel('Product');
xlabel('Time(s)');
title('Valid boxcar 25');
box off;
subplot(2,2,4);
plot(t(T_validindexes_101),y101_);
ylabel('Product');
xlabel('Time(s)');
title('Valid boxcar 101');
box off;
%}

%{
[Yw,Tw] = slidingwindowfunc(chem(:,1),chem(:,2),0,1,300,2,'mean',0);
figure;
plot(Tw,Yw);
xlabel('Time(s)');
ylabel('Product');
[Ywe,Tw] = slidingwindowfunc(chem(:,1),chem(:,2),0,1,300,2,'stderr',0);
%}

%{
load treeshrew_data.mat
figure;
plot(OVs,Depths,'ko');
ylabel('Standardized depth(mm)');
xlabel('Orientation vector index (OVI)');
set(gca,'ydir','reverse');
box off;
hold on;
plot([0 1],[0.950 0.950],'k--'); % boundary L2/3,4
plot([0 1],[1.350 1.350],'k--'); % boundary L4,L5/6
[On,Dn] = slidingwindowfunc(Depths, OVs, 0, 0.01, 1.8, 0.2,'median',0);
plot(On,Dn,'k','linewidth',2)
%}

[v,sr] = audioread('Vuvuzela.wav'); % this file is attached below
[b,a] = butter(4,[200 500]/(0.5 * sr));
%{
figure;
spectrogram(v,1024,[],[],sr,'yaxis');
title('Vuvuzelas original');
%
v2 = filtfilt(b,a,v);
figure;
spectrogram(v-v2,1024,[],[],sr,'yaxis');
title('Vuvuzelas removed');
[b_l,a_l] = butter(4,[500]/(0.5 * sr),'low'); % 500Hz and below
v_l = filtfilt(b_l,a_l,v);
figure;
spectrogram(v_l,1024,[],[],sr,'yaxis');
title('Vuvuzelas below 500Hz');
[b_h,a_h] = butter(4,[2000]/(0.5 * sr),'high'); % 2000Hz and above
v_h = filtfilt(b_h,a_h,v);
figure;
spectrogram(v_h,1024,[],[],sr,'yaxis');
title('Vuvuzelas above 2kHz');
%}

%{
freq = 200; % 200 Hz
t = 0:1/sr:(length(v)-1)/sr; % time of each sample
y = cos(2*pi*freq*t);
y2 = filter(b,a,y);
figure;
plot(t,y);
hold on;
plot(t,y2,'r');
xlabel('Time(s)');
ylabel('Signal');
%}

%{
y3 = filtfilt(b,a,y);
figure;
plot(t,y);
hold on;
plot(t,y3,'r');
xlabel('Time(s)');
ylabel('Signal');
%}

%
[b_bw,a_bw] = butter(4,[200 500]/(0.5 * sr));
[b_cb,a_cb] = cheby1(4,0.5,[200 500]/(0.5 * sr));
[f_bw,o_bw,p_bw]=filtertransfer(b_bw,a_bw,sr,length(v),'filtfilt');%might take time
[f_cb,o_cb,p_cb]=filtertransfer(b_cb,a_cb,sr,length(v),'filtfilt');%might take time
figure(100);
subplot(2,1,1);
hold on;
plot(f_bw,100*o_bw,'b');
plot(f_cb,100*o_cb,'r');
ylabel('Signal amplitude (%)');
legend('Butterworth','Chebychev');
subplot(2,1,2);
hold on;
plot(f_bw,p_bw,'b');
plot(f_cb,p_cb,'r');
ylabel('Signal phase');
legend('Butterworth','Chebychev');
%}
