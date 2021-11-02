% myimage = imread('black-and-white-cow-2-3.tif');
% image(myimage);
% X = [0 : 1 : 20 ]; % a 21 column vector with 1 row
% X = [X; X; X; X; X;]; % copy this row 5 times
% figure;
% sinewaveimage = 127.5 + 127.5 * sin(X);
% image(sinewaveimage);
% colormap(gray(256));
% sinewaveimage2 = sin(X);
% image(sinewaveimage2);
% figure;
% imagesc(sinewaveimage2);
% colormap(gray(256));
% gray(4) % this asks for a gray color table with 4 entries
% jet(4) % this asks for a blue-to-red (cold-to-warm) color table with 4 entries

myrgbimage = imread('Griffins_toys.jpg');
% figure;
% image(myrgbimage);
figure(1);
subplot(2,2,1);
image(myrgbimage);
title('full image');
subplot(2,2,2);
image(myrgbimage(:,:,1));
colormap(gray(256));
title('red channel');
subplot(2,2,3);
image(myrgbimage(:,:,2));
title('green channel');
subplot(2,2,4);
image(myrgbimage(:,:,3));
title('blue channel');
redmap = [ linspace( 0, 1, 256)' zeros(256,1) zeros(256,1)];
greenmap = [ zeros(256,1) linspace( 0, 1, 256)' zeros(256,1) ];
bluemap = [ zeros(256,2) linspace( 0, 1, 256)' ];
figure(2);
subplot(2,2,1);
image(myrgbimage);
title('full image');
subplot(2,2,2);
colormap(redmap);
image(myrgbimage(:,:,1));

title('red channel');
subplot(2,2,3);
colormap(greenmap);
image(myrgbimage(:,:,2));
title('green channel');

subplot(2,2,4);
colormap(bluemap);
image(myrgbimage(:,:,3));
title('blue channel');

figure(3);
subplot(2,2,1);
image(myrgbimage);
title('full image');
subplot(2,2,2);
image(ind2rgb(myrgbimage(:,:,1),redmap));
title('red channel');
subplot(2,2,3);
image(ind2rgb(myrgbimage(:,:,2),greenmap));
subplot(2,2,4);
image(ind2rgb(myrgbimage(:,:,3),bluemap));
