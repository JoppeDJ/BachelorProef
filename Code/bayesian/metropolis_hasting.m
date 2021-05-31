function resultNetworks = metropolis_hasting(first_network, iterations, burn_N, q_sigma, reg_sigma, all_data, seed, type)
%METROPOLIS_HASTING
% data generation
% [data_XA, data_YA, data_XB, data_YB] = random_data_generator(1000,seed,"Cirkel");
% data = [data_XA data_XB; data_YA data_YB; ones(1,length(data_XA)) zeros(1,length(data_XB)); zeros(1,length(data_XA)) ones(1,length(data_XB))];
if type == "FULL"
    data = all_data;
elseif type == "BATCH" || type == "RANDOM_BATCH"   
    data = strat_sample(all_data, 750);
end
    

N = iterations;
xCell = cell(1,N);


%draw initial
xCell{1,1} = first_network;

burn_count = 0;
%Burn in
i = 0;
old_f = f(xCell{1,1}, reg_sigma, data);
while i < burn_N
    xt = draw_Q(xCell{1, 1}, q_sigma);
    new_f = f(xt, reg_sigma, data);
    
    if type == "RANDOM_BATCH"
        old_f = f(xCell{1, 1}, reg_sigma, data);
        data = strat_sample(all_data, 750);
        
    end
    
    p = min([1;new_f/old_f]);
    r = rand;
    burn_count = burn_count + 1;
    if r <= p
      xCell{1,1} = xt;
      i = i + 1;
      old_f = new_f;
    end
end

burned = burn_N/burn_count;
burned

if type == "RANDOM_BATCH"
        data = strat_sample(all_data, 750);
end

alg_count = 0;

i = 1;
while i < N
    xt = draw_Q(xCell{1, i}, q_sigma);
    new_f = f(xt, reg_sigma, data);
    
    if type == "RANDOM_BATCH"
        old_f = f(xCell{1, i}, reg_sigma, data);
        data = strat_sample(all_data, 750);
    end
    
    p = min([1;new_f/old_f]);
    r = rand;
    alg_count = alg_count + 1;
    if r <= p
      xCell{1,i+1} = xt;
      i = i + 1;
      old_f = new_f;
    end
end

iterations  = N/alg_count;
iterations

 function value = f(network_weights, reg_sigma, datap)
     
%      exp_value = [data(3,index); data(4,index)];
%      data_point = [data(1,index); data(2,index)];
%      cost1 = exp(-0.5*((norm(exp_value - classify(data_point, parameters)))/10)^2); 
     % All points f:
     
     cost1 = 1;
     for ix = 1:length(datap)
         exp_value = [datap(3,ix); datap(4,ix)];
         data_point = [datap(1,ix); datap(2,ix)];
         cost1 = cost1 * exp(-0.5*(norm(exp_value - classify(data_point, network_weights)))^2); 
     end
     

     cost2 = 1;
     for j = 1:length(network_weights) 
         cost2 = cost2 * exp(-0.5*(norm(network_weights{1,j})/reg_sigma)^2);      
     end   
     value = cost1 * cost2;
 end

resultNetworks = xCell;

%resultNetworks = cell(1,100);
%draw 100 samples to use for classification
%indexes = randperm(N,100);
% indexes = [N-99:1:N];
% 
% for ind = 1:10 
%     resultNetworks{1,ind} = xCell{1,indexes(ind)};
% end

end