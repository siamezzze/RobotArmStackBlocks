function M = calibrate( p2, p3 )
    n = size(p2, 2);
    A = zeros(n * 2, 12);
    for i = 1:n
        px2 = p2(:, i);
        px3 = p3(:, i);
        A(2 * i, :) = [p3(1,i) p3(2,i) p3(3,i) 1 0 0 0 0 -p2(1,i)*p3(1,i) -p2(1,i)*p3(2,i) -p2(1,i)*p3(3,i) -p2(1,i)];
        A(2 * i + 1, :) = [0 0 0 0 p3(1,i) p3(2,i) p3(3,i) 1 -p2(2,i)*p3(1,i) -p2(2,i)*p3(2,i) -p2(2,i)*p3(3,i) -p2(2,i)];
    end
    [U, D, V] = svd(A);
    m = V(:, 12);
    M = reshape(m, [4, 3])';
end

