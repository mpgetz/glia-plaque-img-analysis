function [centers] = findCenters(rmax, cmax, rad, plaqueStats)
    centers = [0, 0];
    for k =1:numel(plaqueStats)
        x = plaqueStats(k).Centroid(1);
        y = plaqueStats(k).Centroid(2);
        if x+rad>cmax
           continue
        elseif x-rad<1
            continue
        elseif y+rad>rmax
            continue
        elseif y-rad<1
            continue
        else
            if centers(1,:) == [0, 0]
                centers = [x, y];
            else
                for i =1:length(centers(:,1))
                    if pdist2([x, y], [centers(i,1),centers(i,2)]) < (rad*1.5)
                        break
                    elseif i == length(centers(:,1))
                        centers = [centers; [x, y]];
                    end
                end
            end
        end
    end
end
