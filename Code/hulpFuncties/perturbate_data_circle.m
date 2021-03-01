function perturbed_data = perturbate_data_circle(circle_data, epsilonl, epsilonu)

close_points = {};

for i = 1:length(circle_data)
    x = circle_data(1,i);
    y = circle_data(2,i);
    if epsilonl < abs(sqrt((x-0.5)^2+(y-0.5)^2) - 0.4) && abs(sqrt((x-0.5)^2+(y-0.5)^2) - 0.4) < epsilonu
        a = circle_data(3,i);
        b = circle_data(4,i);
        close_points{length(close_points)+1} = [x;y;a;b;i]; 
    end
end

ind = randi(length(close_points));
pert_point = close_points{1,ind};
circle_data(:,pert_point(5)) = [];

% plot the points
% close_points = cell2mat(close_points);
% figure
% hold on
% scatter(circle_data(1,:),circle_data(2,:),'filled')
% scatter(close_points(1,:),close_points(2,:),'filled')
% th = 0:pi/50:2*pi;
% xunit = 0.4 * cos(th) + 0.5;
% yunit = 0.4 * sin(th) + 0.5;
% plot(xunit, yunit);


if pert_point(3) == 1
    pert_point = [pert_point(1); pert_point(2); 0; 1];
    perturbed_data = [circle_data pert_point];
else
    pert_point = [pert_point(1); pert_point(2); 1; 0];
    perturbed_data = [pert_point circle_data];
end




