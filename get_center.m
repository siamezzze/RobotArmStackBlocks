function centroid = get_center(img,min_area,max_area)
stats=regionprops(img, 'ConvexHull','Centroid','Area','Solidity');

cube_idx=find( [stats.Area] < max_area & [stats.Area] > min_area);

max_sol = 0;
centroid = [0 0];
for i = 1:size(cube_idx,2);
    if stats(cube_idx(i)).Solidity> max_sol
        max_sol = stats(cube_idx(i)).Solidity;
        centroid = stats(cube_idx(i)).Centroid;
    end
end
