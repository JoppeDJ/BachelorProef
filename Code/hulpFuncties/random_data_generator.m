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
        if X(index) < 0.2 || X(index) > 0.8 || Y(index) > 0.8 || Y(index) < 0.2
            XB = [XB, X(index)];
            YB = [YB, Y(index)];
        elseif X(index) < 0.5
            if Y(index) < 2*X(index) - 0.2
                XA = [XA, X(index)];
                YA = [YA, Y(index)];
            else
                XB = [XB, X(index)];
                YB = [YB, Y(index)];
            end
        elseif X(index) > 0.5
            if Y(index) < -2*X(index) + 1.8
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
        if X(index) < 0.2 || X(index) > 0.8 || Y(index) > 0.9 || Y(index) < 0.3
            bool = false;
        elseif X(index) < 0.5
            if Y(index) < 2*X(index) - 0.1
                bool = true;
            else
                bool = false;
            end
        elseif X(index) > 0.5
            if Y(index) < -2*X(index) + 1.9
                bool = true;
            else
                bool = false;
            end
        end
        
        if bool
           XA = [XA, X(index)];
           YA = [YA, Y(index)]; 
        elseif X(index) < 0.2 || X(index) > 0.8 || Y(index) > 0.7 || Y(index) < 0.1
            XB = [XB, X(index)];
            YB = [YB, Y(index)];
        elseif X(index) < 0.5
            if Y(index) > -2*X(index) + 1.1
                XA = [XA, X(index)];
                YA = [YA, Y(index)];
            else
                XB = [XB, X(index)];
                YB = [YB, Y(index)];
            end
        elseif X(index) > 0.5
            if Y(index) > 2*X(index) - 0.9
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

