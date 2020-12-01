function trained_network = train_net(network, data, step_size, max_iterations, batch_size, model_params, noise_params)
% traint het netwerk gegeven de cell met de netwerk weights en biases, de
% trainset, de stapgrootte, het aantal iteraties en de vatch grootte

activations = cell(1, length(network)/2);
deltas = cell(1, length(network)/2);
batch_deltas_W = {};
batch_deltas_B = {};
for i = 1: length(network)/2
        batch_deltas_W = [batch_deltas_W, 0];
        batch_deltas_B = [batch_deltas_B, 0];
end

function wipe_batch()
     for index = 1: length(network)/2
        batch_deltas_W{1,index} = 0;
        batch_deltas_B{1,index} = 0;
     end
end

%train loop
for i = 1:max_iterations
    indexes = randperm(length(data), batch_size);
    gradient(indexes);   
    update_params();
    wipe_batch();
end

trained_network = network;

function update_params()
    step_rate = step_size/(batch_size*noise_params(2)^2); 
    reg_rate = 1-(step_size/(length(data)*model_params(2)^2));
    for index = 1:length(batch_deltas_W)
        network{1,2*index - 1} = network{1,2*index - 1} * reg_rate - step_rate*batch_deltas_W{1,index};
        network{1,2*index} = network{1,2*index} * reg_rate - step_rate*batch_deltas_B{1,index};
    end      
end
        

% berekent de gradient van een batch, gegeven de indexen van de batchpunten

function gradient(indexes)
    for index = 1:length(indexes)
       current_point_index = indexes(index);
       forward_pass(current_point_index);
       backward_pass(current_point_index);
    end
end

% maakt een forward pass in het netwerk gegeven de index van de input
    
function forward_pass(point_index)
    datapoint = [data(1,point_index),data(2,point_index)];
    activations{1,1} = sigmoid_activate(datapoint', network{1,1}, network{1,2});
    for index = 2:length(activations)
        activations{1,index} = sigmoid_activate(activations{1,index - 1}, network{1,2*index - 1}, network{1,2*index});
    end   
end

% maakt een backwards pass in het netwerk gegeven de index van de input

function backward_pass(point_index)
    expectation = [data(3,point_index);data(4,point_index)];
    deltas{1,end} = activations{1,end}.*(1-activations{1,end}).*(activations{1,end} - expectation);
    for index = length(deltas):-1:2
        deltas{1,index-1} = activations{1,index-1}.*(1-activations{1,index-1}).*(network{1,2*index - 1}' * deltas{1,index});
    end
    
    batch_deltas_W{1,1} = batch_deltas_W{1,1} + deltas{1,1}*[data(1,point_index);data(2,point_index)]';
    batch_deltas_B{1,1} = batch_deltas_B{1,1} + deltas{1,1};
    for index = 2:length(batch_deltas_W)
       batch_deltas_W{1,index} = batch_deltas_W{1,index} + deltas{1,index} * activations{1,index-1}';
       batch_deltas_B{1,index} = batch_deltas_B{1,index} + deltas{1,index};
    end
    
end

end