%switch to appropriate directory to import photos/confirm analysis group
whichDir = input('Enter full location of photos to analyze as a string ');
cd(whichDir);
treatgp = input('If group to analyze is 10D5, type "y" ');

jpegFiles = dir('*.jpg');
numfiles = length(jpegFiles);
allImgs = cell(1, numfiles);

for k = 1:numfiles 
  allImgs{k} = imread(jpegFiles(k).name); 
end

%switch back to script directory and run analysis
cd('H:\apps\xp\desktop\Sadowski Lab\Matlab Files');

%Assumes order of files is split evenly into halves
%If not, iteration may need adjustment
if treatgp == 'y'
    %10D5
    perPlaqueTreatAvgs = zeros(1, numfiles/2);
    normTreatAvgs = zeros(1, numfiles/2);
    normIm1TreatAvgs = zeros(1, numfiles/2);
    nPareaVsImg1AvgsTreat = [];
    allImg1Avgs = [];
    allImg2Avgs = [];
    
    for g=1:(numfiles/2)
        img1 = allImgs{g};
        img2 = allImgs{g+(numfiles/2)};
        pAnalysis;
        perPlaqueTreatAvgs(g) = normIm1PerPlaque;
        %normTreatAvgs(g) = normpp;
        normIm1TreatAvgs(g) = normIm1Int;
        nPareaVsImg1AvgsTreat = [nPareaVsImg1AvgsTreat; nPareaVsImg1Avgs];
        allImg1Avgs = [allImg1Avgs, img1avgs];
        allImg2Avgs = [allImg2Avgs, img2avgs];
        disp(g)
    end
else
    %TY11
    perPlaqueCtrlAvgs = zeros(1, numfiles/2);
    normCtrlAvgs = zeros(1, numfiles/2);
    normIm1CtrlAvgs = zeros(1, numfiles/2);
    nPareaVsImg1AvgsCtrl = [];
    allImg1Avgs = [];
    allImg2Avgs = [];

    for g=1:(numfiles/2)
        img1 = allImgs{g};
        img2 = allImgs{g+(numfiles/2)};
        pAnalysis;
        perPlaqueCtrlAvgs(g) = normIm1PerPlaque;
        %normCtrlAvgs(g) = normpp;
        normIm1CtrlAvgs(g) = normIm1Int;
        nPareaVsImg1AvgsCtrl = [nPareaVsImg1AvgsCtrl; nPareaVsImg1Avgs];
        allImg1Avgs = [allImg1Avgs, img1avgs];
        allImg2Avgs = [allImg2Avgs, img2avgs];
        disp(g)
    end
end
