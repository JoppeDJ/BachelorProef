function netbp2

%NETBP Uses backpropagation to train a network
x1 = [0.1,0.3,0.1,0.6,0.4,0.6,0.5,0.9,0.4,0.7];
x2 = [0.1,0.4,0.5,0.9,0.2,0.3,0.6,0.2,0.4,0.6];
y = [ones(1,5) zeros(1,5); zeros(1,5) ones(1,5)];

% Initialize weights and biases
rng(5000);
W2 = 0.5*randn(2,2); W3 = 0.5*randn(3,2); W4 = 0.5*randn(2,3);
b2 = 0.5*randn(2,1); b3 = 0.5*randn(3,1); b4 = 0.5*randn(2,1);

% Forward and Back propagate
eta = 0.025; % learning rate
Niter = 1e6; % number of SG iterations
savecost = zeros(Niter,1); % value of cost function at each iteration
usedArr = [];

for counter = 1:Niter
    
   deltaArr1 = 1:6;
   deltaArr2 = 1:6;
   
    for counter = 1:2
        if ismember(10, usedArr) && ismember(1, usedArr) && ismember(2, usedArr) && ismember(3, usedArr) && ismember(4, usedArr) && ismember(5, usedArr) && ismember(6, usedArr) && ismember(7, usedArr) && ismember(8, usedArr) && ismember(9, usedArr)
            usedArr = [];
        end
        k = randi(10); % choose a training point at random
        while ismember(k, usedArr)
            k = randi(10);
        end
        if counter <= 20
            usedArr
        end
        usedArr(end + 1) = k;

        x = [x1(k); x2(k)];
        % Forward pass
        a2 = activate(x,W2,b2);
        a3 = activate(a2,W3,b3);
        a4 = activate(a3,W4,b4);
        % Backward pass
        delta4 = (a4.*(1-a4).*(a4-y(:,k)))*a3';
        delta3 = (a3.*(1-a3).*(W4'*delta4))*a2';
        delta2 = (a2.*(1-a2).*(W3'*delta3))*x';
        
        deltaArr1((counter - 1) * 3 + 1) = delta4;
        deltaArr1((counter - 1) * 3 + 2) = delta3;
        deltaArr1((counter - 1) * 3 + 3) = delta2;
        
        delta4 = a4.*(1-a4).*(a4-y(:,k));
        delta3 = a3.*(1-a3).*(W4'*delta4);
        delta2 = a2.*(1-a2).*(W3'*delta3);
        
        deltaArr2((counter - 1) * 3 + 1) = delta4;
        deltaArr2((counter - 1) * 3 + 2) = delta3;
        deltaArr2((counter - 1) * 3 + 3) = delta2;
        
    end
    
    sumW2 = deltaArr1(3) + deltaArr1(6);
    sumW3 = deltaArr1(2) + deltaArr1(5);
    sumW4 = deltaArr1(1) + deltaArr1(4);
    
    sumB2 = deltaArr2(3) + deltaArr2(6);
    sumB3 = deltaArr2(2) + deltaArr2(5);
    sumB4 = deltaArr2(1) + deltaArr2(4);
    
    % Gradient step
    W2 = W2 - eta*sumW2;
    W3 = W3 - eta*sumW3;
    W4 = W4 - eta*sumW4;
    b2 = b2 - eta*sumB2;
    b3 = b3 - eta*sumB3;
    b4 = b4 - eta*sumB4;
    % Monitor progress
    newcost = cost(W2,W3,W4,b2,b3,b4);  % semicolon toegevoegd voor efficientie, 
                                            % printen duur 
                                            % display cost to screen
    savecost(counter) = newcost;
end

% Show decay of cost function
save costvec

semilogy([1:1e4:Niter],savecost(1:1e4:Niter))

function costval = cost(W2,W3,W4,b2,b3,b4)
    costvec = zeros(10,1);

    for i = 1:10
        x =[x1(i);x2(i)];
        a2 = activate(x,W2,b2);
        a3 = activate(a2,W3,b3);
        a4 = activate(a3,W4,b4);
        costvec(i) = norm(y(:,i) - a4,2);
    end

    costval = norm(costvec,2)^2;

end % of nested function

end