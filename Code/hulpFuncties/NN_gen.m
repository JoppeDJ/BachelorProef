function params = NN_gen(nodes_in_layer, method, randparams)
% returnt cell met weight vector en bias vector matrix per laag
% e.x. [W1 B1 W2 B2 ...]
layers = length(nodes_in_layer);
params = cell(1,2*(layers-1));
params_counter = 1;

for i = 1:(layers-1)
    nodes_amount_current_layer = nodes_in_layer(i);
    nodes_amount_next_layer = nodes_in_layer(i+1);
    weightM = rand_init(nodes_amount_next_layer, nodes_amount_current_layer);
    biasM = rand_init(nodes_amount_next_layer,1);
    
    params{1,params_counter} = weightM;
    params{1,params_counter + 1} = biasM;
    params_counter = params_counter + 2;
end

%geeft random matrix terug gegeven de afmetingen de methode van random en
%de parameters voor de randomverdeling
function randM = rand_init(rows, columns)
    if method == 'random'
        randM = randn(rows,columns);
    elseif method == 'normal' 
        mu = randparams(1);
        sigma = randparams(2);
        randM = normrnd(mu, sigma, rows, columns);
     
    end    
end

end
