function classList = correct_classify_triangle(grid)

classList = {};

for index = 1:length(grid)
    if grid(1,index) < 0.2 || grid(1,index) > 0.8 || grid(2,index) > 0.8 || grid(2,index) < 0.2
        classList = [classList, "B"];
    elseif grid(1,index) < 0.5
        if grid(2,index) <= 2*grid(1,index) - 0.2
            classList = [classList, "A"];
        else
            classList = [classList, "B"];
        end
    elseif grid(1,index) >= 0.5
        if grid(2,index) <= -2*grid(1,index) + 1.8
            classList = [classList, "A"];
        else
            classList = [classList, "B"];
        end
    end
end
end