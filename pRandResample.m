%Random sampling analog to pAnalysis to determine significance interval
%if below is commented, must pre-assign img1 and img2
%img1 = input('First img ');
%img2 = input('Second img ');

img1 = cleanImgs(img1);

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

%determine valid centroids (clean this code up)
centers = findCenters(rmax, cmax, rad, plaqueStats);

%resample centroids using random values for each x,y to generate random
%distribution of points = size(centers)
sizeCenters = size(centers);
RandNormIm1Int = zeros(1, 20);

for itt =1:20
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

    %{
    compute average img1 expression from boundaries defined by img2
    object centroids and a circle of radius = (rad)px
    %}

    img1avgs = zeros(1, (sizeCenters(1)));
    %img2avgs = zeros(1, (sizeCenters(1)));

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
        %avg2 = regionprops(A, img2, 'MeanIntensity');
        img1avgs(c) = avg1.MeanIntensity;
        %img2avgs(c) = avg2.MeanIntensity;
    end

    %Img1 object expression per plaque area within a circular region (rad=50)
    normImg1Avgs = img1avgs./(mean(mean(img1)));
    RandNormIm1Int(itt) = mean(normImg1Avgs);
end


