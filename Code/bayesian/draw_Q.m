function newNet = draw_Q(network, q_sigma)
%DRAW_Q

N1 = length(network);

for i = 1:N1
   sz = size(network{1,i});
   for j = 1:sz(1,1)
      for k = 1:sz(1,2)
          network{1,i}(j,k) = normrnd(network{1,i}(j,k), q_sigma);
      end
   end
end

newNet = network;
end
