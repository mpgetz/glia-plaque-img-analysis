function [plaqueStats] = getRegionProps(img2)
    [B, L] = bwboundaries(img2);
    plaqueStats = regionprops(L, 'Area', 'Centroid');
end