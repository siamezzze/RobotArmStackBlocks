im = imread('blocks-col.png');
[red_cube, blue_cube, green_cube] = hsv_segmentation(im);

%figure
%subplot(1,3,1);
%imshow(red_cube);
%title('red');

%subplot(1,3,2);
%imshow(blue_cube);
%title('blue');

%subplot(1,3,3);
%imshow(green_cube);
%title('green');


% Edge detection
img = rgb2gray(im);
img = medfilt2(img, [4 4]);
img = imbinarize(img,graythresh(img));
img = ~img; 

figure 
imshow(img);

stats=regionprops(img, 'ConvexHull','Centroid','Area','Solidity');

cube_idx=find([stats.Area] > 8000 & [stats.Area] < 11000 & [stats.Solidity] > 0.9 );
cube_centroids = cat(1, stats.Centroid);
cube_centroids = cube_centroids(cube_idx,:);

%cube_ConvexHull = cat(1, stats.ConvexHull);
%cube_ConvexHull = cube_ConvexHull(cube_idx,:);


%determine red cube
if (red_cube(round(cube_centroids(1,2)),round(cube_centroids(1,1))))
    red_idx = 1;
elseif (red_cube(round(cube_centroids(2,2)),round(cube_centroids(2,1))))
    red_idx = 2;
elseif (red_cube(round(cube_centroids(3,2)),round(cube_centroids(3,1))))
    red_idx = 3;
else
    red_idx = -1;
end

if (red_idx == -1)
   display('Red cube is not found!'); 
end


%show red cube
figure 
imshow(im);
title('Red cube')
hold on 
plot(cube_centroids(red_idx,1),cube_centroids(red_idx,2), 'b*');

convHull = cat(1, stats(cube_idx(red_idx)).ConvexHull);
plot(convHull(:,1),convHull(:,2), 'g*');


%determine blue cube
if (blue_cube(round(cube_centroids(1,2)),round(cube_centroids(1,1))))
    blue_idx = 1;
elseif (blue_cube(round(cube_centroids(2,2)),round(cube_centroids(2,1))))
    blue_idx = 2;
elseif (blue_cube(round(cube_centroids(3,2)),round(cube_centroids(3,1))))
    blue_idx = 3;
else
    blue_idx = -1;
end

if (blue_idx == -1)
   display('Blue cube is not found!'); 
end


%show blue cube
figure 
imshow(im);
title('Blue cube')
hold on 
plot(cube_centroids(blue_idx,1),cube_centroids(blue_idx,2), 'r*');

convHull = cat(1, stats(cube_idx(blue_idx)).ConvexHull);
plot(convHull(:,1),convHull(:,2), 'g*');


%determine green cube
if (green_cube(round(cube_centroids(1,2)),round(cube_centroids(1,1))))
    green_idx = 1;
elseif (green_cube(round(cube_centroids(2,2)),round(cube_centroids(2,1))))
    green_idx = 2;
elseif (green_cube(round(cube_centroids(3,2)),round(cube_centroids(3,1))))
    green_idx = 3;
else
    green_idx = -1;
end

if (green_idx == -1)
   display('Green cube is not found!'); 
end


%show green cube
figure 
imshow(im);
title('Green cube')
hold on 
plot(cube_centroids(green_idx,1),cube_centroids(green_idx,2), 'r*');

convHull = cat(1, stats(cube_idx(green_idx)).ConvexHull);
plot(convHull(:,1),convHull(:,2), 'b*');