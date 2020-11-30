function new_value = classify(input, network)

new_value = input;

for i = 1:length(network)/2
    new_value = sigmoid_activate(new_value, network{1, 2*i-1}, network{1, 2*i});
end

end