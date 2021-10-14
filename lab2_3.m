flies1 = load('flies1.txt','-ascii');
flies2 = load('flies2.txt','-ascii');
flies3 = load('flies3.txt','-ascii');

%{
pearappleratio1 = flies1(:,1)./flies1(:,2) % perform element-by-element division
pearappleratio2 = flies2(:,1)./flies2(:,2); 
pearappleratio3 = flies3(:,1)./flies3(:,2);
mn1 = mean(pearappleratio1),
mn2 = mean(pearappleratio2),
mn3 = mean(pearappleratio3),
figure('name','Pear/Apple Ratio'); % new trick, we'll give this figure a name
bar([1 2 3],[mn1 mn2 mn3],'w');
hold on
x_scatter = randn(size(pearappleratio1))/10;
plot(1+x_scatter, pearappleratio1,'go');
plot(2+x_scatter, pearappleratio2,'ro');
plot(3+x_scatter, pearappleratio3,'bo');
xlabel('Strain number');
ylabel('Pear/apple ratio');
set(gca,'xtick',[1 2 3]);
%}

%{
pearindex1 = flies1(:,1)./(flies1(:,1)+flies1(:,2)); % do el-by-el sum,division
pearindex2 = flies2(:,1)./(flies2(:,1)+flies2(:,2)); % do el-by-el sum,division
pearindex3 = flies3(:,1)./(flies3(:,1)+flies3(:,2)); % do el-by-el sum,division
mn1 = mean(pearindex1);
mn2 = mean(pearindex2);
mn3 = mean(pearindex3);
figure('name','Pear Index');
bar([1 2 3],[mn1 mn2 mn3],'w');
hold on
x_scatter = randn(size(pearindex1))/10;
plot(1+x_scatter, pearindex1,'go');
plot(2+x_scatter, pearindex2,'ro');
plot(3+x_scatter, pearindex3,'bo');
xlabel('Strain number');
ylabel('Pear Index');
set(gca,'xtick',[1 2 3]);
%}

%{
x1 = rand(10,1);
x2 = rand(10,1);
x_12 = [x1;x2];
[x_sort,index] = sort(x_12);
inds_x1 = find(index<=10);
inds_x2 = find(index>10);
index(inds_x1) = 1;
index(inds_x2) = 2;
mean(inds_x1)
mean(inds_x2)
%}

%{
x3 = rand(10,1);
x4 = rand(10,1) + 0.5; % we'll artificially shift this data set over
x_34 = [x3;x4];
[x34_sort,index34] = sort(x_34);
inds_x3 = find(index34<=10);
inds_x4 = find(index34>10);
index(inds_x3) = 1;
index(inds_x4) = 2;
index; 
mean(inds_x3)
mean(inds_x4)
%}

%{
G = [1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 ]; 
p12 = kruskalwallis([x1;x2],G)
p34 = kruskalwallis([x3;x4],G)
G = [repmat(1,1,length(x1)) repmat(2,1,length(x2))]
Gf = [ repmat(1,1,length(pearindex1)) repmat(2,1,length(pearindex2)) ...
repmat(3,1,length(pearindex3))]
p = kruskalwallis([pearindex1;pearindex2;pearindex3],Gf);
%}

a = 20; % peak responses, in spikes/sec
b = 90; % location
c = 20; % width
d = 0; % offset
e = 2; % amount of noise
angles = 0:10:180
ori_nonoise = a*exp(-((b-angles).^2)/(2*c^2))+d+0*randn(size(angles));
ori = a*exp(-((b-angles).^2)/(2*c^2))+d+e*randn(size(angles));
figure;
plot(angles,ori); xlabel('Angle'); ylabel('Response (spikes/sec)');
hold on;
plot(angles,ori_nonoise,'k-');
osi = orientation_selectivity_index(angles,ori)
ovi = orientation_vector_index(angles,ori)

true_osi = [];
measured_osi = [];
measured_ovi = [];
a = 20; d = 0;
while d<=10,
i = 1;
while i<=5,
ori = a*exp(-((b-angles).^2)/(2*c^2))+d+e*randn(size(angles));
true_osi(end+1) = (a+d-d)/(a+d);
measured_osi(end+1) = orientation_selectivity_index(angles,ori);
measured_ovi(end+1) = orientation_vector_index(angles,ori);
i = i + 1;
end;
d = d + 1; % increase baseline
a = a - 2; % decrease peak rate
end;

figure;
plot(true_osi,measured_osi,'gs'); % green squares
hold on;
plot(true_osi,measured_ovi,'bo'); % blue circles
xlabel('True osi');
ylabel('Measured osi (green) ovi (blue)');
