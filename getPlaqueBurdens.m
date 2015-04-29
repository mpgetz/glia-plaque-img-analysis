%Compute plaque burdens for serial images grouped by brain 
whichDir = input('Enter full location of photos to analyze, as a string ');
cd(whichDir);

jpegFiles = dir('*.jpg');
numfiles = length(jpegFiles);
allImgs = cell(1, numfiles);

for k = 1:numfiles 
  allImgs{k} = imread(jpegFiles(k).name); 
end
cd('H:\apps\xp\desktop\Sadowski Lab\Matlab Files');

%Assuming imgs of interest lie in the second half of an ordered list:
imgAvgs = zeros(1, numfiles/2);
for g=(numfiles/2)+1:numfiles
    %Compute optimum threshold for img2
    img2 = allImgs{g};
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
    imgAvgs(g-(numfiles/2)) = mean(mean(img2));
end

%{
imgsPerBrain = input('Enter number of images per brain to average');
imgsPerBrain = 4;
burdens = zeros(1, ((numfiles/2)/imgsPerBrain));

m = 1;
for i=1:imgsPerBrain:(numfiles/2)
    burdens(m) = mean(imgAvgs(i:(i+(imgsPerBrain-1))));
    m = m + 1;
end

disp(burdens);
disp(mean(burdens));
%}    