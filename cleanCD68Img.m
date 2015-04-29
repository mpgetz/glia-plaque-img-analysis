function [img1] = cleanCD68Img(img1)
    img = rgb2gray(img1);

    i = 0.05;
    while i <= 0.15
        if (i < 0.15) && (mean(mean(im2bw(img, i)))/mean(mean(im2bw(img, i+0.02))) > 2)
            i = i+0.02;
            if mean(mean(im2bw(img, i)))< 0.0005
                img1 = im2bw(img, i-0.02);
                break
            else
                continue
            end
        elseif (i<0.15) && (mean(mean(im2bw(img, i))) < 0.005)
            img1 = im2bw(img, i);
        elseif i == 0.15
            img1 = im2bw(img, i);
            break
        else
            i = i+0.02;
        end
    end
end