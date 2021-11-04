%{
load sun.mat % load the file included with this lab
figure(10); % let's use a specific figure number
subplot(3,2,1);
plot(sun_wavelength,sun,'k-o');
title('Sun irradiance');
axis([380 750 0 1.1]);

myblueobject = zeros(size(sun_wavelength));
myblueindexvalues = find(sun_wavelength>440&sun_wavelength<490);
myblueobject(myblueindexvalues) = 1;
figure(10); % make sure we are on figure 10
subplot(3,2,3);
plot(sun_wavelength,myblueobject,'b-o');
axis([380 750 0 1]);
title('Reflectance of blue object');
[dummy,index450] = min(abs(sun_wavelength-450)); % find the correct wavelength in sun_wavelength
objectintensityat450 = sun(index450) * myblueobject(index450)
intensityatdetector = sun .* myblueobject;
figure(10);
subplot(3,2,5);
plot(sun_wavelength,intensityatdetector,'k-o');
axis([380 750 0 1]);
title('Radiation arriving at detector');
load cones.mat
figure(10);
subplot(3,2,2);
plot(sun_wavelength,scone,'b-');
hold on;
plot(sun_wavelength,mcone,'g-');
plot(sun_wavelength,lcone,'r-');
axis([380 750 0 1]);
title(['Response profiles of detectors']);
scone_overlap = intensityatdetector .* scone;
mcone_overlap = intensityatdetector .* mcone;
lcone_overlap = intensityatdetector .* lcone;
figure(10);
subplot(3,2,4);
plot(sun_wavelength,scone_overlap,'b-');
hold on;
plot(sun_wavelength,mcone_overlap,'g-');
plot(sun_wavelength,lcone_overlap,'r-');
axis([380 750 0 1]);
title(['Spectral overlap of arriving light and detector response profiles']);
scone_response = sum(scone_overlap) * 1;
mcone_response = sum(mcone_overlap) * 1;
lcone_response = sum(lcone_overlap) * 1;
figure(10);
subplot(3,2,6);
bar([1 2 3],[scone_response mcone_response lcone_response]);
axis([0 4 0 4]);
title(['Response of cone photoreceptors']);
set(gca,'xticklabel',{'S','M','L'});
%}

%{
load monitor_phosphors.mat
figure(11);
subplot(2,2,1);
plot(sun_wavelength,blue_phosphor,'b-');
hold on;
plot(sun_wavelength,green_phosphor,'g-');
plot(sun_wavelength,red_phosphor,'r-');
axis([380 750 0 1]);
title('Monitor phosphors');
b = 0.83; r = 0; g = 0;
mypixel_spectrum = r * red_phosphor + g * green_phosphor + b * blue_phosphor;
figure(11);
subplot(2,2,3);
plot(sun_wavelength,mypixel_spectrum,'k-');
axis([380 750 0 1]);
title('Spectrum generated at this pixel');
scone_overlap = mypixel_spectrum .* scone;
mcone_overlap = mypixel_spectrum .* mcone;
lcone_overlap = mypixel_spectrum .* lcone;
figure(11);
subplot(2,2,2);
plot(sun_wavelength,scone_overlap,'b-');
hold on;
plot(sun_wavelength,mcone_overlap,'g-');
plot(sun_wavelength,lcone_overlap,'r-');
axis([380 750 0 1]);
title(['Spectral overlap of arriving light and detector response profiles']);
scone_response = sum(scone_overlap) * 1;
mcone_response = sum(mcone_overlap) * 1;
lcone_response = sum(lcone_overlap) * 1;
figure(11);
subplot(2,2,4);
bar([1 2 3],[scone_response mcone_response lcone_response]);
axis([0 4 0 4]);
title(['Response of cone photoreceptors']);
set(gca,'xticklabel',{'S','M','L'});
%}

im = imread('brainimage.tiff');
figure(12);
colormap(gray(256));
imagesc(im);
axis square off; % force the axes to be square and disappear
bins = -0.5:1:4095.5;
N = histc(im(:),bins); % the (:) lets us pass the NxM matrix as a 1xN*M vector
figure;
bar(bins+0.5,N);
title('Intensity distribution');

figure(12);
map = colormap; % get the current color map, gray(256)
map(256,:) = [ 1 0 0 ]; % set the peak colormap value to red
map(240:255,:) = repmat([1 1 0 ],255-240+1,1); % set values near peak to yellow
colormap(map); % set the color map
figure(12);
map = colormap;
map(1,:) = [ 0 0 1]; % make the lowest value blue
colormap(map); % set the map
a = uint16([1024 512 100]) % now we have 'a' defined as an integer
a/max(a), % look at the result!
255 * a/max(a),
255 * double(a)/max(double(a)), % now we get what we want

figure(13);
im2 = double(im);
im2 = 255*im2/max(im2(:));
image(im2);
colormap(gray(256));

cell_image = double(imread('cell_image.tiff'));
figure;
subplot(2,2,1);
colormap(gray(256));
% rescale to fit into the range
mn = min(cell_image(:));
mx = max(cell_image(:));
cell_image_whole_range = rescale(cell_image, [mn mx],[0 255]);
image(cell_image_whole_range);
bins = -0.5+[0:256];
N2 = histc(cell_image_whole_range(:),bins);
subplot(2,2,2);
bar(bins+0.5,N2);
title('Intensity distribution of cell_image');
subplot(2,2,3);
cell_image_focused = rescale(cell_image,[0 1000],[0 255]);
image(cell_image_focused);
N3 = histc(cell_image_focused(:),bins);
subplot(2,2,4);
bar(bins+0.5,N3);
title('Intensity distribution of focused image');

