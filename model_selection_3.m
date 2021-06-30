%% MODEL SELECTION & TRAINING 
load 'variables\dimensions.mat';

load 'variables\train_set.mat';
load 'variables\W.mat';
load 'variables\projected_train_set.mat';

load 'variables\project_folder.mat';

%%new dataset analysis
figure;
subplot(2,2,1)
scatter(projected_train_set,zeros(1,size(train_set,2)),10,train_set_labels)
text(mean(projected_train_set(:,1:sum(train_set_labels == 1))),0.15,'1','Color','b')
text(mean(projected_train_set(:,sum(train_set_labels == 1)+1:sum(train_set_labels == 1)+ sum(train_set_labels == 2))),0.15,'2','Color','y')
title('projected train set')
subplot(2,2,2)
histogram(projected_train_set)
title('projected train set distribution')
subplot(2,2,3)
qqplot(projected_train_set(:,1:sum(train_set_labels == 1)))
title('class 1 projected train set')
subplot(2,2,4)
qqplot(projected_train_set(:,sum(train_set_labels == 1)+1:sum(train_set_labels == 1)+ sum(train_set_labels == 2)))
title('class 2 projected train set')
%% GENERATIVE APPROACH
%%Estimate each gaussians' parameters

class_1 = projected_train_set(:,1:sum(train_set_labels == 1));
class_2 = projected_train_set(:,sum(train_set_labels == 1)+1:sum(train_set_labels == 1)+ sum(train_set_labels == 2));

class_1_mean = mean(class_1);
std_class_1 = std(class_1);
class_1_f = normpdf(class_1,class_1_mean,std_class_1);

class_2_mean = mean(class_2);
std_class_2 = std(class_2);
class_2_f = normpdf(class_2,class_2_mean,std_class_2);

save(strcat(project_folder,'variables\estimated_gaussians_parameters'),'class_1_mean','std_class_1','class_2_mean','std_class_2');

% PLOTS
figure;
scatter(class_1,class_1_f)
text(class_1_mean,max(class_1_f)+0.01,'1');
hold on;
scatter(class_2,class_2_f)
text(class_2_mean,max(class_2_f)+0.01,'2');
title('class 1 and 2 gaussians - es');

%%EM
[model,llh] = emgm(projected_train_set,2);

% PLOTS
figure;
scatter(projected_train_set(:,1:size(train_set,2)/2),normpdf(projected_train_set(:,1:size(train_set,2)/2),model.mu(1),model.Sigma(:,:,1)^2));
hold on;
scatter(projected_train_set(:,size(train_set,2)/2+1:size(train_set,2)),normpdf(projected_train_set(:,size(train_set,2)/2+1:size(train_set,2)),model.mu(2),model.Sigma(:,:,2)^2));
title('class 1 and 2 gaussians - EM');

class_1_mean = model.mu(1);
std_class_1 = model.Sigma(:,:,1)^2;

class_2_mean = model.mu(2);
std_class_2 = model.Sigma(:,:,2)^2;

save(strcat(project_folder,'variables\EM_estimated_parameters'),'class_1_mean','std_class_1','class_2_mean','std_class_2');

%% DISCRIMINATIVE APPROACH
load 'variables\train_set.mat';
load 'variables\projected_train_set.mat';load 'variables\estimated_gaussians_parameters.mat'

% Way to determine the position of the classes in respect to the treshold 
% 1 -> 1 | 2
% 2 -> 2 | 1
if class_1_mean > class_2_mean
    configuration = 2;
else
    configuration = 1;
end
save(strcat(project_folder,'variables\configuration'),'configuration');

separation_coordinate = (class_1_mean + class_2_mean)/2;

save(strcat(project_folder,'variables\separation_coordinate'),'separation_coordinate');

figure;
scatter(projected_train_set,zeros(1,size(projected_train_set,2)),10,train_set_labels)
hold on;
scatter(class_1_mean,0,100,'x');
text(class_1_mean,-0.3,'μ1')
hold on;
scatter(class_2_mean,0,100,'x');
text(class_2_mean,-0.3,'μ2')
hold on;
plot(repmat(separation_coordinate,1,11),[-5 : 5]);
title('Treshold')

clearvars -except result_matrix_1 result_matrix_2 result_matrix_3 result_matrix_4;












