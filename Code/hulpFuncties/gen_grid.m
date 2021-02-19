function roster = gen_grid()

xVal = 0:0.02:1;
yVal = 0:0.02:1;

roster = [];
for i = 1: length(xVal)
    for j = 1: length(yVal)
      roster(1, end + 1) = xVal(i);
      roster(2, end) = yVal(j);
    end
end

