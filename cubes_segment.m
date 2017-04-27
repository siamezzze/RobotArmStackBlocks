function [c1,c2,c3] = cubes_segment(im)

%im_name = '0029.bmp';
im = imread(im_name);
min_area = 3000;
max_area = 21000;

[red_cube, blue_cube, green_cube] = hsv_segmentation(im,0.7,0.2);

c1 = get_center(red_cube,min_area,max_area);
c2 = get_center(green_cube,min_area,max_area);
c3 = get_center(blue_cube,min_area,max_area);


%figure 
%imshow(im);
%title('Blue cube')
%hold on 
%plot([c1(1) c2(1) c3(1)],[c1(2) c2(2) c3(2)] , 'r*');