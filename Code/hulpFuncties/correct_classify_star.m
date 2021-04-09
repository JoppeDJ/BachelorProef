function classList = correct_classify_star(grid)

classList = {};

for index = 1:length(grid)
    bool = false;
    if grid(1,index) < 0.1625 || grid(1,index) > 0.8375 || grid(2,index) > 0.95 || grid(2,index) < 0.275
        bool = false;
    elseif grid(1,index) < 0.5
        if grid(2,index) <= 2*grid(1,index) - 0.05
            bool = true;
        else
            bool = false;
        end
    elseif grid(1,index) >= 0.5
        if grid(2,index) <= -2*grid(1,index) + 1.95
            bool = true;
        else
            bool = false;
        end
    end
    
    if bool
        classList = [classList, "A"];
    elseif grid(1,index) < 0.1625 || grid(1,index) > 0.8375 || grid(2,index) > 0.725 || grid(2,index) < 0.05
        classList = [classList, "B"];
    elseif grid(1,index) < 0.5
        if grid(2,index) >= -2*grid(1,index) + 1.05
           classList = [classList, "A"];
        else
           classList = [classList, "B"];
        end
    elseif grid(1,index) >= 0.5
        if grid(2,index) >= 2*grid(1,index) - 0.95
            classList = [classList, "A"];
        else
            classList = [classList, "B"];
        end
    end 
end

end