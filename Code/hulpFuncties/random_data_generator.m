function [XA, YA, XB, YB] = random_data_generator(nbPoints, seed, shapeStr)

rng(seed)

X = round(rand(1,nbPoints),3);
Y = round(rand(1,nbPoints),3);

XA = {};
XB = {};
YA = {};
YB = {};

if shapeStr == "Cirkel"
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
elseif shapeStr == "Driehoek"
    for index = 1:nbPoints
        if X(index) < 0.1 || X(index) > 0.9 || Y(index) > 0.9 || Y(index) < 0.1
            XB = [XB, X(index)];
            YB = [YB, Y(index)];
        elseif X(index) < 0.5
            if Y(index) <= 2*X(index) - 0.1
                XA = [XA, X(index)];
                YA = [YA, Y(index)];
            else
                XB = [XB, X(index)];
                YB = [YB, Y(index)];
            end
        elseif X(index) >= 0.5
            if Y(index) <= -2*X(index) + 1.9
                XA = [XA, X(index)];
                YA = [YA, Y(index)];
            else
                XB = [XB, X(index)];
                YB = [YB, Y(index)];
            end
        end
    end
elseif shapeStr == "Ster"
    for index = 1:nbPoints
        bool = false;
        if X(index) < 0.1625 || X(index) > 0.8375 || Y(index) > 0.95 || Y(index) < 0.275
            bool = false;
        elseif X(index) < 0.5
            if Y(index) <= 2*X(index) - 0.05
                bool = true;
            else
                bool = false;
            end
        elseif X(index) >= 0.5
            if Y(index) <= -2*X(index) + 1.95
                bool = true;
            else
                bool = false;
            end
        end
        
        if bool
           XA = [XA, X(index)];
           YA = [YA, Y(index)]; 
        elseif X(index) < 0.1625 || X(index) > 0.8375 || Y(index) > 0.725 || Y(index) < 0.05
            XB = [XB, X(index)];
            YB = [YB, Y(index)];
        elseif X(index) < 0.5
            if Y(index) >= -2*X(index) + 1.05
                XA = [XA, X(index)];
                YA = [YA, Y(index)];
            else
                XB = [XB, X(index)];
                YB = [YB, Y(index)];
            end
        elseif X(index) >= 0.5
            if Y(index) >= 2*X(index) - 0.95
                XA = [XA, X(index)];
                YA = [YA, Y(index)];
            else
                XB = [XB, X(index)];
                YB = [YB, Y(index)];
            end
        end
    end
end    

XA = cell2mat(XA);
YA = cell2mat(YA);
XB = cell2mat(XB);
YB = cell2mat(YB);

