function resultNetworks = metropolis_hasting()
%METROPOLIS_HASTING
% data generation
[data_XA, data_YA, data_XB, data_YB] = random_data_generator(1000,100,"Cirkel");
data = [data_XA data_XB; data_YA data_YB; ones(1,length(data_XA)) zeros(1,length(data_XB)); zeros(1,length(data_XA)) ones(1,length(data_XB))];
M = size(data);

N = 1e6;
xCell = cell(1,N);


%draw initial
xCell{1,1} = NN_gen([2 5 2],'normal',[0 10],5000);


%Burn in
i = 0;
while i < 20000
    k = randi(M(1,2));
    xt = draw_Q(xCell{1, 1});
    p = min([1;f(k,xt)/f(k,xCell{1,1})]);
    r = rand;
    if r <= p
      xCell{1,1} = xt;
      i = i + 1;
    end
end

i = 1;
while i < N
    k = randi(M(1,2));
    xt = draw_Q(xCell{1, i});
    p = min([1;f(k,xt)/f(k,xCell{1,i})]);
    r = rand;
    if r <= p
      xCell{1,i+1} = xt;
      i = i + 1;
    end
end

 function value = f(index, parameters)
     exp_value = [data(3,index); data(4,index)];
     data_point = [data(1,index); data(2,index)];
     cost1 = exp(-0.5*(norm(exp_value - classify(data_point, parameters))/1)^2); 
     cost2 = 1;
     for j = 1:length(parameters) 
         cost2 = cost2 * exp(-0.5*(norm(parameters{1,j})/10)^2);      
     end   
     value = cost1 * cost2;
 end


resultNetworks = cell(1,100);
%draw 100 samples to use for classification
indexes = randperm(N,100);
for ind = 1:100
    resultNetworks{1,ind} = xCell{1,indexes(ind)};
end

end

