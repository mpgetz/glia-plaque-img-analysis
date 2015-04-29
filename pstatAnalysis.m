%random sampling paradigm to determine a significance interval for each
%image
%switch to appropriate directory to import photos/confirm analysis group
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
gpDistribution = zeros(numfiles/2, 20);

for g=1:(numfiles/2)
    img1 = allImgs{g};
    img2 = allImgs{g+(numfiles/2)};
    pRandResample;
    gpDistribution(g,:) = RandNormIm1Int;
    disp(g)
end

grossAvg = mean(mean(gpDistribution));
grossSD = std(std(gpDistribution));
