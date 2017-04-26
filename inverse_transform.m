function [ p3 ] = inverse_transform( M, points2D, x, y, z, h )
    n = size(points2D, 2);
    % Inverse transform.
    p2 = [points2D; ones(1, n)];
    % Need to find Minv that satisfies:
    % p2 * Minv = p3;
    [K, R, C] = decompose(M);
    C = [C(1) / C(4); C(2) / C(4); C(3) / C(4)];
    M_inv = pinv(M);

    %M_inv = inv(M' * M) * M';
    p3_hat = M_inv * p2;
    p3_hat = [p3_hat(1, :) ./ p3_hat(4, :); p3_hat(2, :) ./ p3_hat(4, :); p3_hat(3, :) ./ p3_hat(4, :)];
    p3 = zeros(3, 0);
    for i=1:n
        P = p3_hat(:, i);
        d = P - C;
        % P = (x0, y0, z0); d = (l, m, n);
        % (x - x0) / l = (y - y0) / m = (z - z0) / n;
        % z is fixed
        zk = (z - P(3)) / d(3);
        yt = zk * d(2) + P(2);
        xt = zk * d(1) + P(1);
        p3(:, i) = [xt, yt, z];
    end
        
    for i=1:n
        p3(1, i) = x + round((p3(1, i) - x) / h) * h;
        p3(2, i) = y + round((p3(2, i) - y) / h) * h;
    end
end

