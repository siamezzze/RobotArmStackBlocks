x0 = 87;
y0 = 129;
z0 = 0;
h = 50;
% Take photo
img = CMD_GRAB_IMAGE();
%img = imread(fullfile('kinekt', '0021.bmp'));
% Calibrate
%run manual_calibration.m
M = calibrate_from_image(img, 0, 'points.mat', x0, y0, z0, h);
% Locate blocks
[red, green, blue] = locate_blocks(img);
red_3D = inverse_transform(M, red, x0, y0, z0, h);
green_3D = inverse_transform(M, green, x0, y0, z0, h);
blue_3D = inverse_transform(M, blue, x0, y0, z0, h);

% 4. What is the target location?
target = [x0 + h / 2, y0 + h / 2, z0];

% 5. Move the red block to the target location
move_block(red_3D, target, z0 + 4 * h, z0 + h / 2);
% 6. Move the green block to the target location.
move_block(blue_3D, target, z0 + 4 * h, z0 + h + h / 2);
% 7. Move the blue block to the target location
move_block(green_3D, target, z0 + 4 * h, z0 + 2 * h + h / 2);