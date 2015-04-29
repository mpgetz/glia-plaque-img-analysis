img1 = cleanImgs(img1);
img2 = cleanImg2(img2);
plaqueStats = getRegionProps(img2);

centers = [];
[rmax, cmax] = size(img1);
theta = (0 : 0.1 : 2*pi);
rad = 50;

%determine valid centroids
centers = findCenters(rmax, cmax, rad, plaqueStats);

%resample centroids using random values for each x,y to generate random
%distribution of points = size(centers)
sizeCenters = size(centers);
centers = zeros(sizeCenters);

for r =1:sizeCenters(1)
    x = rand*(cmax-102);
    y = rand*(rmax-102);
    i = 1;
    while i <= r
        if pdist2([x+51, y+51], [centers(i, 1), centers(i, 2)]) < (rad*1.5)
            x = rand*(cmax-102);
            y = rand*(rmax-102);
            i = 1;
        elseif i < r
            i = i+1;
        elseif i == r
            centers(r,:) = [x+51, y+51];
            break
        end
    end
end

%plot boundaries on first image
B = bwboundaries(img2);
imshow(img1); hold on;
for k = 1:length(B(:,1))
   b = B{k};
   plot(b(:,2),b(:,1),'r','LineWidth',3);
end

%outline circles of rad 50 from center of plaque
for k =1:sizeCenters(1)
    x = round(50*cos(theta)+centers(k,1))';
    y = round(50*sin(theta)+centers(k,2))';
    plot(x, y, 'g');
end