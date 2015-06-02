%Analyzes total CD68 expression in a vicinity of plaques
whichDir = input('Enter full location of photos to analyze as a string ');
cd(whichDir);

jpegFiles = dir('*.jpg');
numfiles = length(jpegFiles);
allImgs = cell(1, numfiles);

for k = 1:numfiles 
  allImgs{k} = imread(jpegFiles(k).name); 
end

%switch back to script directory
cd('H:\apps\xp\desktop\Sadowski Lab\Matlab Files');

pAreaVsCDTotal = [];
TSAreaVsCDTotal = [];

for file = 1:(numfiles/2)
    img1 = allImgs{file};
    img2 = allImgs{file+(numfiles/2)};

    img1 = cleanCD68Img(img1);

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

    centers = [];
    [rmax, cmax] = size(img1);
    theta = (0 : 0.1 : 2*pi);
    rad = 50;

    %determine valid centroids
    centers = findCenters(rmax, cmax, rad, plaqueStats);

    sizeCenters = size(centers);
    img2areas = zeros(1, (sizeCenters(1)));

    %create vector of plaque boundary areas for included plaques only
    for k =1:numel(plaqueStats)
        for c =1:(sizeCenters(1))
            if (plaqueStats(k).Centroid(1) == centers(c, 1)) && (plaqueStats(k).Centroid(2) == centers(c, 2))
                img2areas(c) = plaqueStats(k).Area;
            else
                continue
            end
        end
    end
    
    img1Totals = zeros(1, sizeCenters(1));
    img2Totals = zeros(1, sizeCenters(1));
    %compute sum of all pixels within disk of radius = rad
    for c =1:sizeCenters(1)
        total1 = 0;
        total2 = 0;
        for x=round((centers(c, 1)-rad)):round((centers(c, 1)+rad))
            for y=round((centers(c, 2)-rad)):round((centers(c, 2)+rad))
                if sqrt((x-centers(c, 1))^2 + (y-centers(c, 2))^2) < rad
                    total1 = total1 + img1(y, x);
                    total2 = total2 + img2(y, x);
                end
            end
        end
        img1Totals(c) = total1;
        img2Totals(c) = total2;
    end
    pAreaVsCDTotal = [pAreaVsCDTotal; img2areas', img1Totals'];
    TSAreaVsCDTotal = [TSAreaVsCDTotal; img2Totals', img1Totals'];
    disp(file);
end

treatgp = input('If group to analyze is 10D5, type "y" ');

if treatgp == 'y'
    TreatTSAreaVsCD = TSAreaVsCDTotal;
    pT = polyfit(TSAreaVsCDTotal(:,1), TSAreaVsCDTotal(:,2), 1);
else
    CtrlTSAreaVsCD = TSAreaVsCDTotal;
    pC = polyfit(TSAreaVsCDTotal(:,1), TSAreaVsCDTotal(:,2), 1);
end


