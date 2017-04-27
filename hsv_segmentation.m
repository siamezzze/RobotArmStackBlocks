function [red_cube, blue_cube, green_cube] = hsv_segmentation(im,upper_thresh, lower_thresh)

hsv_image = rgb2hsv(im);
hue = hsv_image(:,:,1); 
saturation = hsv_image(:,:,2);

BW = im2bw(hue,upper_thresh);
%tmp = saturation - BW;
%tmp1 = saturation - (1 - BW);


blue_cube = BW;

BW2 = meanthresh(hue,[600 600], 0.005);
BW2 = saturation - (1 - (BW2 - blue_cube));
green_cube = im2bw(BW2,lower_thresh);

red_cube = saturation - blue_cube - green_cube;
red_cube = im2bw(red_cube,graythresh(red_cube));
end
