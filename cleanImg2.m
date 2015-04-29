function [imgT2] = cleanImg2(img2, gamma)
    imgT2 = rgb2gray(img2);
    imgT2 = imadjust(imgT2, [], [], gamma);
    imgT2 = im2bw(imgT2, graythresh(imgT2));
    imgT2 = bwareaopen(imgT2, 50);
    imgT2 = imfill(imgT2, 'holes');
end