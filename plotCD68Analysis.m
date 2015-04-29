whichDir = input('Enter full location of photos to analyze as a string ');
cd(whichDir);

jpegFiles = dir('*.jpg');
numfiles = length(jpegFiles);
allImgs = cell(1, numfiles);

for k = 1:numfiles 
  allImgs{k} = imread(jpegFiles(k).name); 
end

%switch back to script directory and run analysis
cd('H:\apps\xp\desktop\Sadowski Lab\Matlab Files');

for file = 1:(numfiles/2)
    img1 = allImgs{file};
    img2 = allImgs{file+(numfiles/2)};

    img = rgb2gray(img1);

    i = 0.05;
    while i <= 0.15
        if (i < 0.15) && (mean(mean(im2bw(img, i)))/mean(mean(im2bw(img, i+0.02))) > 2)
            i = i+0.02;
            disp(i)
            if mean(mean(im2bw(img, i))) < 0.0005
                img1 = im2bw(img, i-0.02);
                disp(2)
                break
            elseif mean(mean(im2bw(img, i)))/mean(mean(im2bw(img, i+0.02))) < 2
                img1 = im2bw(img, i);
                disp(5)
                break
            else
                continue
            end
        elseif (i<0.15) && (mean(mean(im2bw(img, i))) < 0.05)
            img1 = im2bw(img, i);
            disp(4)
            break
        elseif i == 0.15
            img1 = im2bw(img, i);
            disp(3)
            break
        else
            i = i+0.02;
            disp(1)
        end
    end

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
    
    input('Enter to cont');
end
        
        
        