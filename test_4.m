%% TEST & USE 
load 'variables\test_set.mat';
load 'variables\validation_set.mat';

load 'variables\W.mat';

load 'variables\project_folder.mat';
%% GENERATIVE APPROACH
fprintf('GENERATIVE APPROACH - %.4d features\n',size(test_set,1));

%%Single gaussian estimated parameters
fprintf('\n\nSingle gaussian estimated parameters\n');
load 'variables\estimated_gaussians_parameters.mat';

results = test_gen(test_set,'TEST SET',sum(test_set_labels == 1),sum(test_set_labels == 2),W,class_1_mean,std_class_1,class_2_mean,std_class_2);
print_results(results);
save(strcat(project_folder,'variables\test_set_single_gauss_estimated_params_results'),'results')

results = test_gen(validation_set,'VALIDATION SET',sum(validation_set_labels == 1),sum(validation_set_labels == 2),W,class_1_mean,std_class_1,class_2_mean,std_class_2);
print_results(results);
save(strcat(project_folder,'variables\validation_set_single_gauss_estimated_params_results'),'results')

%%EM

fprintf('\n\nEM estimated parameters\n');
load 'variables\EM_estimated_parameters.mat';

results = test_gen(test_set,'TEST SET',sum(test_set_labels == 1),sum(test_set_labels == 2),W,class_1_mean,std_class_1,class_2_mean,std_class_2);
print_results(results);
save(strcat(project_folder,'variables\test_set_EM_estimated_params_results'),'results')

results = test_gen(validation_set,'VALIDATION SET',sum(validation_set_labels == 1),sum(validation_set_labels == 2),W,class_1_mean,std_class_1,class_2_mean,std_class_2);
print_results(results);
save(strcat(project_folder,'variables\validation_set_EM_estimated_params_results'),'results')
%% DISCRIMINATIVE APPROACH

fprintf('\n---\n\nDISCRIMINATIVE APPROACH - %.4d features',size(test_set,1));

%%Estimated gaussians' parameters
fprintf('\n\nSingle gaussian estimated parameters\n');
load 'variables\estimated_gaussians_parameters.mat';
load 'variables\separation_coordinate';
load 'variables\configuration'

results = test_disc(test_set,'TEST SET',sum(test_set_labels == 1),sum(test_set_labels == 2),W,separation_coordinate,configuration);
print_results(results);
save(strcat(project_folder,'variables\disc_test_set_results'),'results')

results = test_disc(validation_set,'VALIDATION SET',sum(validation_set_labels == 1),sum(validation_set_labels == 2),W,separation_coordinate,configuration);
print_results(results);
save(strcat(project_folder,'variables\disc_validation_set_results'),'results')
%% KNN
load 'variables\test_set.mat'
load 'variables\validation_set.mat'
load 'variables\projected_train_set.mat'
load 'variables\train_set.mat'
load 'variables\W.mat'

fprintf('\n\nKNN\n');

results = test_knn(projected_train_set,train_set_labels,1000,W,test_set,'TEST SET',sum(test_set_labels == 1),sum(test_set_labels == 2));
print_results(results);
save(strcat(project_folder,'variables\knn_test_set_results'),'results')

results = test_knn(projected_train_set,train_set_labels,1000,W,validation_set,'VALIDATION SET',sum(validation_set_labels == 1),sum(validation_set_labels == 2));
print_results(results);
save(strcat(project_folder,'variables\knn_validation_set_results'),'results')