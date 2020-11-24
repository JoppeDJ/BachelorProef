function [XA, YA, XB, YB] = random_data_generator(nbPoints, seed)

rng(seed)

X = round(rand(1,nbPoints),3);
Y = round(rand(1,nbPoints),3);

XA = {};
XB = {};
YA = {};
YB = {};

for index = 1:nbPoints
    distance = sqrt((X(index) - 0.5)^2 + (Y(index) - 0.5)^2);
    if distance <= 0.4
        XA = [XA, X(index)];
        YA = [YA, Y(index)];
    else
        XB = [XB, X(index)];
        YB = [YB, Y(index)];
    end
end

XA = cell2mat(XA);
YA = cell2mat(YA);
XB = cell2mat(XB);
YB = cell2mat(YB);

