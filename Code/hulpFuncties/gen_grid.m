function roster = gen_roster()

xVal = 0:0.1:1;
yVal = 0:0.1:1;

roster = [];
for i = 1: 11
    for j = 1:11
      roster(1, end + 1) = xVal(i);
      roster(2, end) = yVal(j);
    end
end

