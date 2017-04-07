function [red_cube, blue_cube, green_cube] = hsv_segmentation(im)

hsv_image = rgb2hsv(im);
hue = hsv_image(:,:,1); 
saturation = hsv_image(:,:,2); 

BW = im2bw(hue,graythresh(hue));
tmp = saturation - BW;
tmp1 = saturation - (1 - BW);


blue_cube = imgaussfilt(tmp1,4);
blue_cube = medfilt2(blue_cube, [15 15]);
blue_cube = im2bw(blue_cube,graythresh(blue_cube));

green_cube = imgaussfilt(tmp,4);
green_cube = medfilt2(green_cube, [30 30]);
green_cube = im2bw(green_cube,graythresh(green_cube));

red_cube = saturation - blue_cube - green_cube;
red_cube = medfilt2(red_cube, [17 17]);
red_cube = im2bw(red_cube,graythresh(red_cube));

end
