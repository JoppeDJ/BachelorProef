function new_data = perturbate_star_data(data, low, high, seed)
    % Code inspired by https://www.geeksforgeeks.org/minimum-distance-from-a-point-to-the-line-segment-using-vectors/
    % And https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_line
    
    closest_X = {};
    closest_Y = {};
    bottom_left_1  = [0.1625 0.275];
    bottom_right_1  = [0.8375 0.275];
    top_1  = [0.5 0.95];
    bottom_left_2  = [0.1625 0.725];
    bottom_right_2  = [0.8375 0.725];
    top_2  = [0.5 0.05];
    
    [r1,c1] = size(data);
    for i = 1:c1
        point = [data(1,i) data(2,i)];
        distance1 = distanceToSegment(bottom_left_1, bottom_right_1, point);
        distance2 = distanceToSegment(bottom_right_1, top_1, point);
        distance3 = distanceToSegment(top_1, bottom_left_1, point);
        distance4 = distanceToSegment(bottom_left_2, bottom_right_2, point);
        distance5 = distanceToSegment(bottom_right_2, top_2, point);
        distance6 = distanceToSegment(top_2, bottom_left_2, point);
        minimum = min([distance1 distance2 distance3 distance4 distance5 distance6]);
        
        if (low <= minimum) && (minimum <= high)
            closest_X = [closest_X, data(1,i)];
            closest_Y = [closest_Y, data(2,i)];
        end
    end
    
    rng(seed);
    [r2,c2] = size(closest_X);
    randIndex = randi([0,c2]);
    
    for i = 1:c1
        if (data(1,i) == closest_X{1,randIndex}) && (data(2,i) == closest_Y{1,randIndex})
            if (data(3,i) == 0) && (data(4,i) == 1)
                data(3,i) = 1;
                data(4,i) = 0;
            else
                data(3,i) = 0;
                data(4,i) = 1;
            end
            
            break
        end
    end
    
    new_data = data;
    
    function distance = distanceToSegment(A,B,E)
        AB = [(B(1,1) - A(1,1)) (B(1,2) - A(1,2))];
        BE = [(E(1,1) - B(1,1)) (E(1,2) - B(1,2))];
        AE = [(E(1,1) - A(1,1)) (E(1,2) - A(1,2))];
        
        dot1 = dot(AB,BE);
        dot2 = dot(AB,AE);
        
        prod = dot1 * dot2;
        if prod > 0
            distance_to_A = sqrt((E(1,2) - A(1,2))^2 + (E(1,1) - A(1,1))^2);
            distance_to_B = sqrt((E(1,2) - B(1,2))^2 + (E(1,1) - B(1,1))^2);            
            distance = min([distance_to_A distance_to_B]);
        elseif prod <= 0
            numerator = abs((B(1,1)-A(1,1))*(A(1,2)-E(1,2))-(A(1,1)-E(1,1))*(B(1,2)-A(1,2)));
            denominator = sqrt((B(1,1)-A(1,1))^2 + (B(1,2)-A(1,2))^2);
            distance = numerator / denominator;
        end
    end
end

