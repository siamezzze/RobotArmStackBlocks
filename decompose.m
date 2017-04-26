function [ K, R, C ] = decompose(M)
    xc = det([M(:,2), M(:,3), M(:,4)]);
    yc = -det([M(:,1), M(:,3), M(:,4)]);
    zc = det([M(:,1), M(:,2), M(:,4)]);
    wc = -det([M(:,1), M(:,2), M(:,3)]);
    C = [xc; yc; zc; wc];
    
    I = ones(4, 3);
    KR = M * pinv([I -C]);
    
    [Q, R] = qr(flipud(KR)');
    R = flipud(R');
    R = fliplr(R);
    Q = Q';
    Q = flipud(Q);
    
    K = R;
    R = Q;
end


