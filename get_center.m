function centroid = get_center(img,min_area,max_area)
stats=regionprops(img, 'ConvexHull','Centroid','Area','Solidity');

cube_idx=find( [stats.Area] < max_area & [stats.Area] > min_area & [stats.Solidity] > 0.5);

min_dist = 100000;
center = size(img) / 2;
centroid = [0 0];

for i = 1:size(cube_idx,2);
    dist = sqrt((center(2) - stats(cube_idx(i)).Centroid(1))^2 +  (center(1) - stats(cube_idx(i)).Centroid(2))^2);
    if dist < min_dist
        min_dist = dist;
        centroid = stats(cube_idx(i)).Centroid;
    end
end
