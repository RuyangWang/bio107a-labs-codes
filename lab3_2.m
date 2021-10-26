t = 0:0.01:10;
f = 2;
y2s = sin(2*pi*f*t);
y2c = cos(2*pi*f*t);
f = 5;
y5s = sin(2*pi*f*t);
y5c = cos(2*pi*f*t);
%{
figure;
subplot(2,1,1);
plot(t,y2s,'b');
hold on;
plot(t,y2c,'r');
ylabel('Y');
subplot(2,1,2);
plot(t,0.5*y5s,'b');
hold on
plot(t,0.5*y5c,'r');
xlabel('Time(s)');
ylabel('Y');
%}

t=0:0.01:10;
S = 0*t; % start off with all 0's
ind1 = find(t==3);
ind2 = find(t==5);
S(ind1:ind2) = 1;
[an,bn,fn] = fourier_coefficients(t,S);
%{
figure(100);
plot(t,S);
xlabel('Time(s)');
ylabel('Signal');
box off;

sc = [ 0 0.1107 -0.1444 0.0955 -0.0267 0.0000 -0.0191 0.0416 -0.0355];
cc = [0.2008 -0.1516 0.0461 0.0318 -0.0376 -0.0008 0.0255 -0.0127 -0.0123];
freqs = [ 0 0.0999 0.1998 0.2997 0.3996 0.4995 0.5994 0.6993 0.7992];
f1 = sc(1)*sin(2*pi*freqs(1)*t) + cc(1)*cos(2*pi*freqs(1)*t);
f2 = 2*sc(2)*sin(2*pi*freqs(2)*t) + 2*cc(2)*cos(2*pi*freqs(2)*t);
f3 = 2*sc(3)*sin(2*pi*freqs(3)*t) + 2*cc(3)*cos(2*pi*freqs(3)*t);
f4 = 2*sc(4)*sin(2*pi*freqs(4)*t) + 2*cc(4)*cos(2*pi*freqs(4)*t);
f5 = 2*sc(5)*sin(2*pi*freqs(5)*t) + 2*cc(5)*cos(2*pi*freqs(5)*t);
f6 = 2*sc(6)*sin(2*pi*freqs(6)*t) + 2*cc(6)*cos(2*pi*freqs(6)*t);
f7 = 2*sc(7)*sin(2*pi*freqs(7)*t) + 2*cc(7)*cos(2*pi*freqs(7)*t);
f8 = 2*sc(8)*sin(2*pi*freqs(8)*t) + 2*cc(8)*cos(2*pi*freqs(8)*t);
f9 = 2*sc(9)*sin(2*pi*freqs(9)*t) + 2*cc(9)*cos(2*pi*freqs(9)*t);
figure(100);
hold on
plot(t,f1+f2,'r-');
plot(t,f1+f2+f3+f4,'g-');
plot(t,f1+f2+f3+f4+f5+f6,'m-');
plot(t,f1+f2+f3+f4+f5+f6+f7+f8+f9,'k-');
%}

%{
sample_interval = t(2) - t(1);
sample_rate = 1/sample_interval;
N = length(t);
f1 = sample_rate * 1/N
figure;
plot(t,S);
hold on;
plot(t,cos(2*pi*f1*t),'r');
xlabel('Time(s)'); ylabel('Signal');
a1 = mean(S.*cos(2*pi*f1*t))

%display_fourier_coeffs(t)
[an,bn,fn] = fourier_coefficients(t,S);

S_reconstructed = an*cos(2*pi*fn'*t)+bn*sin(2*pi*fn'*t);
figure(100);
plot(t,S_reconstructed,'r--');
%}

%{
P = an.^2 + bn.^2;
figure;
plot(fn,P,'o');
xlabel('Frequency (Hz)');
ylabel('Power');
%}

%{
ecg = load('normalecg.txt');
SR = 128;
te = [0:1/SR:(length(ecg)-1)/SR];
figure(102);
plot(te,ecg)
xlabel('Time (s)');
ylabel('Voltage (mV)');
%}

%
load temperatures.mat
BlueHillsc = BlueHills(1:500,:);
[an_t, bn_t, fn_t] = fourier_coefficients(BlueHillsc(:,1), BlueHillsc(:,2));
%{
figure;
subplot(2,1,1);
plot(BlueHillsc(:,1),BlueHillsc(:,2),'b');
xlabel('Time(years)');
ylabel('Temperature');
subplot(2,1,2);
plot(fn_t,an_t.^2+bn_t.^2)
ylabel('Power (C^2)');
xlabel('Frequency (cycles/year)');
%}

%{
BHp = an_t.^2+bn_t.^2;
inds = find(BHp>10);
fn_t(inds)
figure;
plot(BlueHillsc(:,1),cos(2*pi*fn_t(inds(2))*BlueHillsc(:,1)),'r');
hold on
plot(BlueHillsc(:,1),cos(2*pi*fn_t(inds(3))*BlueHillsc(:,1)),'b');
xlabel('Time(s)');
ylabel('Cos at 2 frequencies');

t_ = [ 0 1/12 2/12];
cos_input1 = 2*pi*fn_t(inds(2))*t_;
cos_input2 = 2*pi*fn_t(inds(3))*t_;
figure;
t__ = -2*pi:0.01:6*pi;
plot(t__,cos(t__),'b');
for i=1:length(t_)
    text(cos_input1(i),cos(cos_input1(i)),int2str(i),'color',[0 0 1]);
    text(cos_input2(i),cos(cos_input2(i)),int2str(i),'color',[1 0 0]);
end
SR=12;
N = 500;
m = 208;
SR*(N/2+m)/N;
SR*(N/2-m)/N;
%}

%
[wave,fs] = audioread('song.wav');
t_w = 0:1/fs:(length(wave)-1)/fs;
[an_w, bn_w, fn_w] = fourier_coefficients(t_w,wave);
p_w = an_w.^2 + bn_w.^2;
figure
plot(fn_w,p_w)
box off;
ylabel('Power');
xlabel('Frequency');
figure;
%{
spectrogram(wave,256,[],[],fs,'yaxis');
%}