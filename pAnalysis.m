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

nullImg = zeros(size(img2));
centers = [];
[rmax, cmax] = size(img1);
theta = (0 : 0.1 : 2*pi);
rad = 50;

%determine valid centroids
centers = findCenters(rmax, cmax, rad, plaqueStats);

sizeCenters = size(centers);
img2areas = zeros(1, (sizeCenters(1)));

%create vector of plaque sizes for included plaques only
for k =1:numel(plaqueStats)
    for c =1:(sizeCenters(1))
        if (plaqueStats(k).Centroid(1) == centers(c, 1)) && (plaqueStats(k).Centroid(2) == centers(c, 2))
            img2areas(c) = plaqueStats(k).Area;
        else
            continue
        end
    end
end

%{
compute average img1 expression from boundaries defined by img2
object centroids and a circle of radius = (rad)px
%}

img1avgs = zeros(1, (sizeCenters(1)));
img2avgs = zeros(1, (sizeCenters(1)));

%compute mean Img1 expression within circles centered on plaques
for c =1:sizeCenters(1)
    A = nullImg;
    for x=round((centers(c, 1)-rad)):round((centers(c, 1)+rad))
        for y=round((centers(c, 2)-rad)):round((centers(c, 2)+rad))
            if sqrt((x-centers(c, 1))^2 + (y-centers(c, 2))^2) < rad
                A(y, x) = 1;
            end
        end
    end
    avg1 = regionprops(A, img1, 'MeanIntensity');
    avg2 = regionprops(A, img2, 'MeanIntensity');
    img1avgs(c) = avg1.MeanIntensity;
    img2avgs(c) = avg2.MeanIntensity;
end

%Img1 object expression per plaque area within a circular region (rad=50)
normImg1Avgs = img1avgs./(mean(mean(img1)));
nPareaVsImg1Avgs = [img2areas', normImg1Avgs'];


%meanPerP = mean(img1avgs./img2avgs);
%normPerP = mean(normImg1Avgs./normImg2Avgs);
normIm1Int = mean(normImg1Avgs);
normIm1PerPlaque = mean(normImg1Avgs./img2avgs);




