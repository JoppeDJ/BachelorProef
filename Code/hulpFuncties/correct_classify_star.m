function classList = correct_classify_star(grid)

classList = {};

for index = 1:length(grid)
    bool = false;
    if grid(1,index) < 0.2 || grid(1,index) > 0.8 || grid(2,index) > 0.9 || grid(2,index) < 0.3
        bool = false;
    elseif grid(1,index) < 0.5
        if grid(2,index) <= 2*grid(1,index) - 0.1
            bool = true;
        else
            bool = false;
        end
    elseif grid(1,index) >= 0.5
        if grid(2,index) <= -2*grid(1,index) + 1.9
            bool = true;
        else
            bool = false;
        end
    end
    
    if bool
        classList = [classList, "A"];
    elseif grid(1,index) < 0.2 || grid(1,index) > 0.8 || grid(2,index) > 0.7 || grid(2,index) < 0.1
        classList = [classList, "B"];
    elseif grid(1,index) < 0.5
        if grid(2,index) >= -2*grid(1,index) + 1.1
           classList = [classList, "A"];
        else
           classList = [classList, "B"];
        end
    elseif grid(1,index) >= 0.5
        if grid(2,index) >= 2*grid(1,index) - 0.9
            classList = [classList, "A"];
        else
            classList = [classList, "B"];
        end
    end 
end

end