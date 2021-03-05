function resultNetworks = metropolis_hasting(iterations)
%METROPOLIS_HASTING
seed = randi(1500)

% data generation
[data_XA, data_YA, data_XB, data_YB] = random_data_generator(1000,seed,"Cirkel");
data = [data_XA data_XB; data_YA data_YB; ones(1,length(data_XA)) zeros(1,length(data_XB)); zeros(1,length(data_XA)) ones(1,length(data_XB))];
M = size(data);

N = iterations;
xCell = cell(1,N);


%draw initial
xCell{1,1} = NN_gen([2 5 2],'normal',[0 10],seed);

burn_count = 0;
%Burn in
i = 0;
old_f = f(xCell{1,1});
while i < 300
    xt = draw_Q(xCell{1, 1});
    new_f = f(xt);
    p = min([1;new_f/old_f]);
    r = rand;
    burn_count = burn_count + 1;
    if r <= p
      xCell{1,1} = xt;
      i = i + 1;
      old_f = new_f;
    end
end

burned = 200/burn_count;
burned

alg_count = 0;

i = 1;
while i < N
    xt = draw_Q(xCell{1, i});
    new_f = f(xt);
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

 function value = f(parameters)
     
%      exp_value = [data(3,index); data(4,index)];
%      data_point = [data(1,index); data(2,index)];
%      cost1 = exp(-0.5*((norm(exp_value - classify(data_point, parameters)))/10)^2); 
     % All points f:
     
     cost1 = 1;
     for ix = 1:length(data)
         exp_value = [data(3,ix); data(4,ix)];
         data_point = [data(1,ix); data(2,ix)];
         cost1 = cost1 * exp(-0.5*(norm(exp_value - classify(data_point, parameters)))^2); 
     end
     

     cost2 = 1;
     for j = 1:length(parameters) 
         cost2 = cost2 * exp(-0.5*(norm(parameters{1,j})/10)^2);      
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