function [imgT] = cleanImgs(img1)
    imgT = rgb2gray(img1);
    imgT = imtophat(imgT, strel('disk', 10));
    imgT = im2bw(imgT, graythresh(imgT));
    imgT = bwareaopen(imgT, 50);
    
    %imshow(ins(1).img)
end




    

