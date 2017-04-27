function [c1,c2,c3] = cubes_segment(im)

%im_name = '0022.bmp';

%im = imread(im_name);

[red_cube, blue_cube, green_cube] = hsv_segmentation(im,0.7,0.2);

c1 = get_center(red_cube,10000,21000);

%figure 
%imshow(im);
%title('Red cube')
%hold on 
%plot(c(1),c(2), 'r*');


c2 = get_center(green_cube,10000,21000);

%figure 
%imshow(im);
%title('Green cube')
%hold on 
%plot(c(1),c(2), 'r*');

c3 = get_center(blue_cube,10000,21000);

%figure 
%imshow(im);
%title('Blue cube')
%hold on 
%plot(c(1),c(2), 'r*');