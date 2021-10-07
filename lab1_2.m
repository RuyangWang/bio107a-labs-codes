mydata1 = 100*generate_random_data(10,'normal',1,1); 
mydata2 = 100*generate_random_data(10,'normal',0,1); 
f = figure;
plot(1,mydata1,'og');
hold on
plot(2,mydata2,'sb');
myax = axis;
axis([0 3 -300 500])
xlabel('Class number');
ylabel('Change in student happiness');
mydata3 = 100*generate_random_data(10,'normal',10,1); 
mydata4 = 100*generate_random_data(10,'normal',0,1); 
f2 = figure;
plot(1,mydata3,'og')
hold on
plot(2,mydata4,'sb');
axis([0 3 -300 1500])
xlabel('Class number');
ylabel('Change in student happiness');
figure(f) % brings the 1st figure to the front; any drawing would now happen here
title(['Change in student happiness in Class 1 vs. Class 2, dataset 1 and dateset 2']);
figure(f2); % brings the second figure to the front
title(['Change in student happiness in Class 1 vs. Class 2, dataset 3 and dateset 4']);