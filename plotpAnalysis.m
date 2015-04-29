%if below is commented, must pre-assign img1 and img2
%img1 = input('First img ');
%img2 = input('Second img ');

img1 = cleanImgs(img1);
%img2 = cleanImg2(img2);

%find optimum threshold for img2
gamma = 1.2;
while gamma <= 1.5
    testBound = mean(mean(cleanImg2(img2, gamma)))/mean(mean(cleanImg2(img2, gamma+0.1)));
    if testBound > 5
        img2 = cleanImg2(img2, gamma+0.1);
        break
    elseif gamma > 1.4
        gamma = 1.2;
        img2 = cleanImg2(img2, gamma);
        break
    else
        gamma = gamma + 0.1;
    end
end  

plaqueStats = getRegionProps(img2);

%nullImg = zeros(size(img2));
[rmax, cmax] = size(img1);
rad = 50;

%{
for k =1:numel(plaqueStats)
    x = plaqueStats(k).Centroid(1);
    y = plaqueStats(k).Centroid(2);
    if x+rad>cmax
       continue
    elseif x-rad<1
        continue
    elseif y+rad>rmax
        continue
    elseif y-rad<1
        continue
    else
        if k == 1
            centers = [centers; [x, y]];
        else
            for i =1:k-1
                if pdist2([x, y], [plaqueStats(i).Centroid(1), plaqueStats(i).Centroid(2)]) < (rad*1.5)
                    break
                elseif i == k-1
                    centers = [centers; [x, y]];
                end
            end
        end
    end
end
%}

%plot boundaries on first image
B = bwboundaries(img2);
imshow(img1); hold on;
for k = 1:length(B(:,1))
   b = B{k};
   plot(b(:,2),b(:,1),'r','LineWidth',3);
end

%outline circles of rad 50 from center of plaque
%
centers = findCenters(rmax, cmax, rad, plaqueStats);
sizeCenters = size(centers);
theta = (0 : 0.1 : 2*pi);

for k =1:sizeCenters(1)
    x = round(50*cos(theta)+centers(k,1))';
    y = round(50*sin(theta)+centers(k,2))';
    plot(x, y, 'g');
end
%}
