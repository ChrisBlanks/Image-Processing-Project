%{
    ENGE 370 Project
    Image Processing on the Gardenl Image
    Team Members:
        - Chris Blanks
        - Josh Orebiyi
        - Adric Turner
        - Ryan Valente
    Dependencies: Image Processing Toolbox
%}


img = imread('Gardenl.jpg');
hsv_img = rgb2hsv(img); %convert rgb image to hsv img

hue_chan = hsv_img(:,:,1)*255; %matrix of hue components; scale by 255
saturation_chan = hsv_img(:,:,2); %matrix of saturation components
value_chan = hsv_img(:,:,3);  %matrix of green components

%Used later for displaying original image info
hue_chan_copy = hue_chan;
hue_chan_size = size(hue_chan);

purple_pix_indx =(hue_chan<240)&(hue_chan>180); %indices of purple pixels

GREEN_HUE = 90; %Green Color
hue_chan(purple_pix_indx)=GREEN_HUE; %change purple pixels to new hue value
hue_chan = double(hue_chan/255); %scale back to 0-255 range
%concatenate channels along the 3rd dimension
hsv_filtered_img1 = cat(3,hue_chan,saturation_chan,value_chan);
rgb_filtered_img1 = hsv2rgb(hsv_filtered_img1); %convert back to rgb

RED_HUE = 0; %Red color
hue_chan(purple_pix_indx) = RED_HUE; %change purple pixels to red value
hsv_filtered_img2 = cat(3,hue_chan,saturation_chan,value_chan);
rgb_filtered_img2 = hsv2rgb(hsv_filtered_img2);

%plots of hue distributions

subplot(3,2,1) %3 by 2 subplot with original image info taking 1st row
orig_hist = histogram(double(reshape(...
    hue_chan_copy,hue_chan_size(1)*hue_chan_size(2),1)),10);
title('Hue Histogram of Original Image')
%axis([0 255 0 15*10^4])
subplot(3,2,2)
imshow(img)
title('Original Image')

subplot(3,2,3) %3 by 2 subplot with first altered image info taking 2nd row
%hue values needed scaling
green_hist = histogram(double(reshape(...
    hsv_filtered_img1(:,:,1)*255,hue_chan_size(1)*hue_chan_size(2),1)),10);
%axis([0 255 0 10^6])
title('Hue Histogram of Altered Image: Green Petals')
subplot(3,2,4)
imshow(rgb_filtered_img1)
title('Altered Image: Green Petals')

subplot(3,2,5) %3 by 2 subplot with original image info taking 3rd row
%hue values needed scaling
red_hist = histogram(double(reshape(...
    hsv_filtered_img2(:,:,1)*255,hue_chan_size(1)*hue_chan_size(2),1)),10);
%axis([0 255 0 15*10^5])
title('Hue Histogram of Altered Image: Red Petals')
subplot(3,2,6)
imshow(rgb_filtered_img2)
title('Altered Image: Red Petals')

set(gcf,'Position',get(groot,'Screensize')) %full screen figure
