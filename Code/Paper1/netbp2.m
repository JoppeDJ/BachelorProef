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
    
   if ismember(10, usedArr) && ismember(1, usedArr) && ismember(2, usedArr) && ismember(3, usedArr) && ismember(4, usedArr) && ismember(5, usedArr) && ismember(6, usedArr) && ismember(7, usedArr) && ismember(8, usedArr) && ismember(9, usedArr)
        usedArr = [];
   end
   
   k = randi(10); % choose a training point at random
   while ismember(k, usedArr)
      k = randi(10);
   end
   usedArr(end + 1) = k;

   x = [x1(k); x2(k)];
   % Forward pass
   a2 = activate(x,W2,b2);
   a3 = activate(a2,W3,b3);
   a4 = activate(a3,W4,b4);
   % Backward pass
   delta14 = a4.*(1-a4).*(a4-y(:,k));
   delta13 = a3.*(1-a3).*(W4'*delta14);
   delta12 = a2.*(1-a2).*(W3'*delta13);
        
   delta141 = delta14*a3';
   delta131 = delta13*a2';
   delta121 = delta12*x';
   
   if ismember(10, usedArr) && ismember(1, usedArr) && ismember(2, usedArr) && ismember(3, usedArr) && ismember(4, usedArr) && ismember(5, usedArr) && ismember(6, usedArr) && ismember(7, usedArr) && ismember(8, usedArr) && ismember(9, usedArr)
        usedArr = [];
   end
   
   k = randi(10); % choose a training point at random
   while ismember(k, usedArr)
      k = randi(10);
   end
   usedArr(end + 1) = k;

   x = [x1(k); x2(k)];
   % Forward pass
   a2 = activate(x,W2,b2);
   a3 = activate(a2,W3,b3);
   a4 = activate(a3,W4,b4);
   % Backward pass
   delta24 = a4.*(1-a4).*(a4-y(:,k));
   delta23 = a3.*(1-a3).*(W4'*delta24);
   delta22 = a2.*(1-a2).*(W3'*delta23);
        
   delta242 = delta24*a3';
   delta232 = delta23*a2';
   delta222 = delta22*x';
       
   sumW2 = delta121 + delta222;
   sumW3 = delta131 + delta232;
   sumW4 = delta141 + delta242;
   
   sumB2 = delta12 + delta22;
   sumB3 = delta13 + delta23;
   sumB4 = delta14 + delta24;
    
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