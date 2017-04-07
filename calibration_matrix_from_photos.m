image1 = imread(fullfile('blocks_photos', 'blocks1.jpg'));
provide_new_points = 0;

figure(1);
imshow(image1);

% Get (or load) 2D points.
if provide_new_points
    % Pick 2D points on the image.
    points2D = ginput;
    points2D = points2D';
else
    load('points.mat');
end;
hold on;
x = points2D(1, :)'; y = points2D(2, :)';
n = size(x, 1);
plot(x, y, 'g.');
a = [1:n]'; b = num2str(a); c = cellstr(b);
dx = 0.1; dy = 0.1;
text(x+dx, y+dy, c, 'Color', 'green');

% Get (or load) 3D points.
if provide_new_points
    % Ask user for coordinates of each point.
    points3D = zeros(n, 3);
    disp('Now, give the 3D coordinates for each of the marked points');
    for i=1:n
        prompt = sprintf('Point %d, X = ', i);
        x = input(prompt);
        prompt = sprintf('Point %d, Y = ', i);
        y = input(prompt);
        prompt = sprintf('Point %d, Z = ', i);
        z = input(prompt);
        points3D(i, :) = [x y z];
    end
    points3D = points3D';
    save('points.mat', 'points2D', 'points3D');
end
% Calculate calibration matrix (with normalization).
M = calibrate_norm(points2D, points3D);
save('calibrated.mat', 'M');

p3 = [points3D; ones(1, n)];
p2 = M * p3;
p2 = [p2(1, :) ./ p2(3, :); p2(2, :) ./ p2(3, :)];
hold on;
x = p2(1, :)'; y = p2(2, :)';
n = size(x, 1);
plot(x, y, 'r.');
a = [1:n]'; b = num2str(a); c = cellstr(b);
dx = 0.1; dy = 0.1;
text(x+dx, y+dy, c, 'Color', 'red');