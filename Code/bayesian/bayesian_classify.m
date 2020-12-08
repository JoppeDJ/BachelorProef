function probabilities = bayesian_classify(input, networks)

len = length(networks);
a_count = 0;
b_count = 0;

for i = 1:len
    result = classify(input, networks{1,i});
    if result(1) > result(2)
        a_count = 1 + a_count;
    else
        b_count = 1 + b_count;
    end
end

probabilities = [a_count/len b_count/len];

end