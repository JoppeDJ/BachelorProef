function netbp_b
% Verdeling model parameter: N(0, sigma1)
sigma1 = 10;

% Verdeling ruis : N(0, sigma2)
sigma2 = 1;

% Generate 'random' data
[xA, yA, xB, yB] = random_data_generator(100, 100);

%NETBP Uses backpropagation to train a network
x1 = [xA xB];
x2 = [yA yB];
y = [ones(1,length(xA)) zeros(1,length(xB)); zeros(1,length(xA)) ones(1,length(xB))];
N = length(x1);

% Initialize weights and biases
rng(5000);
W2 = normrnd(0, sigma1, 2, 2); W3 = normrnd(0, sigma1, 3, 2); W4 = normrnd(0, sigma1, 2, 3);
b2 = normrnd(0, sigma1, 2, 1); b3 = normrnd(0, sigma1, 3, 1); b4 = normrnd(0, sigma1, 2, 1);

% Forward and Back propagate
eta = 0.05; % learning rate
Niter = 1e5; % number of SG iterations
savecost = zeros(Niter,1); % value of cost function at each iteration

for counter = 1:Niter
    k = randi(N); % choose a training point at random
    x = [x1(k); x2(k)];
    % Forward pass
    a2 = activate(x,W2,b2);
    a3 = activate(a2,W3,b3);
    a4 = activate(a3,W4,b4);
    % Backward pass
    delta4 = a4.*(1-a4).*(a4-y(:,k));
    delta3 = a3.*(1-a3).*(W4'*delta4);
    delta2 = a2.*(1-a2).*(W3'*delta3);
    % Gradient step
    W2 = W2 * (1 - (eta/(sigma1 * N))) - (eta*delta2*x')/ sigma2;
    W3 = W3 * (1 - (eta/(sigma1 * N))) - (eta*delta3*a2')/ sigma2;
    W4 = W4 * (1 - (eta/(sigma1 * N))) - (eta*delta4*a3')/ sigma2;
    b2 = b2 * (1 - (eta/(sigma1 * N))) - (eta*delta2)/ sigma2;
    b3 = b3 * (1 - (eta/(sigma1 * N))) - (eta*delta3)/ sigma2;
    b4 = b4 * (1 - (eta/(sigma1 * N))) - (eta*delta4)/ sigma2;
    % Monitor progress
    newcost = cost(W2,W3,W4,b2,b3,b4, sigma1, sigma2);  % semicolon toegevoegd voor efficientie, 
                                        % printen duur 
                                        % display cost to screen
    savecost(counter) = newcost;
end

% Show decay of cost function
save costvec
semilogy([1:1e2:Niter],savecost(1:1e2:Niter))

%generate test data
[xA_t, yA_t, xB_t, yB_t] = random_data_generator(100, 200);

x1_t = [xA_t xB_t];
x2_t = [yA_t yB_t];
N = length(x1_t);

XA = {};
YA = {};
XB = {};
YB = {};

for i = 1:N
    x = [x1_t(i); x2_t(i)];
    x
    % Forward pass
    a2 = activate(x,W2,b2);
    a3 = activate(a2,W3,b3);
    a4 = activate(a3,W4,b4);
    if a4(1) >= a4(2)
        XA = [XA, x1_t(i)];
        YA = [YA, x2_t(i)];
    else
        XB = [XB, x1_t(i)];
        YB = [YB, x2_t(i)];
    end
end

XA = cell2mat(XA);
YA = cell2mat(YA);
XB = cell2mat(XB);
YB = cell2mat(YB);

th = 0:pi/50:2*pi;
xunit = 0.3 * cos(th) + 0.5;
yunit = 0.3 * sin(th) + 0.5;



figure
hold on
axis([0 1 0 1])
%scatter(X,Y,[],'filled')
scatter(XA,YA,'filled')
scatter(XB,YB,'filled')
plot(xunit, yunit);

function costval = cost(W2,W3,W4,b2,b3,b4, sigma1, sigma2)
    costvec = zeros(N,1);

    for i = 1:N
        x =[x1(i);x2(i)];
        a2 = activate(x,W2,b2);
        a3 = activate(a2,W3,b3);
        a4 = activate(a3,W4,b4);
        costvec(i) = norm(y(:,i) - a4,2);
    end
    
    costReg = norm(W2)^2 + norm(W3)^2 + norm(W4)^2 + norm(b2)^2 + norm(b3)^2 + norm(b4)^2;

    costval = norm(costvec,2)^2 / sigma2 + costReg / sigma1;

end % of nested function

end