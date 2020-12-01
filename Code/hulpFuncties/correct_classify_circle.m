function classList = correct_classify_circle(grid)

classList = {};

for index = 1:length(grid)
    distance = sqrt((grid(1,index) - 0.5)^2 + (grid(2,index) - 0.5)^2);
    if distance <= 0.4
        classList = [classList, "A"];
    else
        classList = [classList, "B"];
    end
end
end

