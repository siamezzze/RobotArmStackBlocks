function [ M ] = calibrate_from_image(image, provide_new_points, points_path, x0, y0, z0, h)
    figure(1);
    imshow(image);

    % Get (or load) 2D points.
    if provide_new_points
        % Pick 2D points on the image.
        points2D = ginput;
        points2D = points2D';
    else
        load(points_path);
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
            x = x0 + h * input(prompt);
            prompt = sprintf('Point %d, Y = ', i);
            y = y0 + h * input(prompt);
            prompt = sprintf('Point %d, Z = ', i);
            z = z0 + h * input(prompt);
            points3D(i, :) = [x y z];
        end
        points3D = points3D';
        save('points.mat', 'points2D', 'points3D');
    end
    % Calculate calibration matrix (with normalization).
    used_points = n - 4; % Leave some for testing.
    M = calibrate_norm(points2D(:, 1:used_points), points3D(:, 1:used_points));
    % save('calibrated.mat', 'M');

    % Test it:
    % Translate 2D -> 3D using calibration matrix.
    p3 = [points3D; ones(1, n)];
    p2_hat = M * p3;
    p2_hat = [p2_hat(1, :) ./ p2_hat(3, :); p2_hat(2, :) ./ p2_hat(3, :)];
    hold on;
    x = p2_hat(1, :)'; y = p2_hat(2, :)';
    n = size(x, 1);
    plot(x, y, 'r.');
    a = [1:n]'; b = num2str(a); c = cellstr(b);
    dx = 0.1; dy = 0.1;
    text(x+dx, y+dy, c, 'Color', 'red');

    err1 = mean(mean((p2_hat(:, used_points:n) - points2D(:, used_points:n)) .^ 2, 2));


    p3_hat = inverse_transform(M, points2D, x0, y0, 25, h);


    err2 = mean(mean((p3_hat(:, used_points:n) - points3D(:, used_points:n)) .^ 2, 2));

    fprintf('MSE for direct transform (3D -> 2D): %f\n', err1);
    fprintf('MSE for inverse transform (2D -> 3D): %f\n', err2);

end

