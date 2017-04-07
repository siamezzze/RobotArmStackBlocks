function M = calibrate_norm( p2, p3 )
    n = size(p2, 2);
    A = zeros(n * 2, 12);
    
    % normalization
    % 1. image points
    x = p2(1, :);
    y = p2(2, :);
    d = mean(sqrt((x - mean(x)) .* (x - mean(x)) + (y - mean(y)) .* (y - mean(y))));
    T = [sqrt(2) / d  0            -sqrt(2) * mean(x) / d;
         0            sqrt(2) / d  -sqrt(2) * mean(y) / d;
         0            0            1];
    p2 = [x; y; ones(1, n)];
    p2 = T * p2;
    
    % 2. Model points
    X = p3(1, :);
    Y = p3(2, :);
    Z = p3(3, :);
    D = mean(sqrt((X - mean(X)) .* (X - mean(X)) + (Y - mean(Y)) .* (Y - mean(Y)) + (Z - mean(Z)) .* (Z - mean(Z))));
    Un = [sqrt(3) / D 0 0 -sqrt(3) * mean(X) / D;
          0 sqrt(3) / D 0 -sqrt(3) * mean(Y) / D;
          0 0 sqrt(3) / D -sqrt(3) * mean(Z) / D;
          0 0 0 1];
    p3 = [X; Y; Z; ones(1, n)];
    p3 = Un * p3;
    
    for i = 1:n
        px2 = p2(:, i);
        px3 = p3(:, i);
        A(2 * i, :) = [p3(1,i) p3(2,i) p3(3,i) 1 0 0 0 0 -p2(1,i)*p3(1,i) -p2(1,i)*p3(2,i) -p2(1,i)*p3(3,i) -p2(1,i)];
        A(2 * i + 1, :) = [0 0 0 0 p3(1,i) p3(2,i) p3(3,i) 1 -p2(2,i)*p3(1,i) -p2(2,i)*p3(2,i) -p2(2,i)*p3(3,i) -p2(2,i)];
    end
    [U, D, V] = svd(A);
    m = V(:, 12);
    Mt = reshape(m, [4, 3])';
    M = T \ Mt * Un;
    %M = M';
end

