function metropolis_hasting()
%METROPOLIS_HASTING
% data generation
[data_XA, data_YA, data_XB, data_YB] = random_data_generator(1000,100);
data = [data_XA data_XB; data_YA data_YB; ones(1,length(data_XA)) zeros(1,length(data_XB)); zeros(1,length(data_XA)) ones(1,length(data_XB))];
M = size(data);

N = 5;
xCell = cell(1,N);


%draw initial
xCell{1,1} = NN_gen([2 5 2],'normal',[0 10],5000);



%Burn in
for i = 1:1000
    k = randi(M(1,2));
    xt = draw_Q(xCell{1, 1});
    p = min([1;f(k,xt)/f(k,xCell{1,1})]);
    
    bool = rand <= p;
    if bool
      xCell{1,1} = xt;
    end
end

i = 1;
while i < N
    k = randi(M(1,2));
    xt = draw_Q(xCell{1, i});
    
    p = min([1;f(k,xt)/f(k,xCell{1,i})]);
    
    bool = rand <= p;
    if bool
      xCell{1,i+1} = xt;
      i = i + 1;
    end
end

 function value = f(index, parameters)
     exp_value = [data(3,index); data(4,index)];
     data_point = [data(1,index); data(2,index)];
     cost1 = exp(-norm(exp_value - classify(data_point, parameters))^2);
     cost2 = 0;
     for j = 1:length(parameters)
         cost2 = cost2 * exp(-norm(parameters{1,j})^2);
     end
     
     value = cost1 + cost2;
 end
end

