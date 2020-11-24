function trained_network = train(network, data, step_size, max_iterations, batch_size)
% traint het netwerk gegeven de cell met de netwerk weights en biases, de
% trainset, de stapgrootte, het aantal iteraties en de vatch grootte

size = length(network) - 1;

activations = cell(size,1);

%train loop
for i = 1:max_iterations
    randperm(1:length(data), batch_size);
    
end

function batch_gradient = gradient(points)