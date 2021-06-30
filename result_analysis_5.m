% %%Collection of results 
% load 'variables\dimensions.mat'
% 
% if rows/10 == 1 
%     result_matrix_1 = {};
%     result_matrix_2 = {};
%     result_matrix_3 = {};
%     result_matrix_4 = {};
% end
% 
% %%Single gaussian estimated parameters
% load 'variables\test_set_single_gauss_estimated_params_results.mat'
% result_matrix_1{1,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% load 'variables\validation_set_single_gauss_estimated_params_results.mat'
% result_matrix_1{2,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% load 'variables\mp_set_single_gauss_estimated_params_results.mat'
% result_matrix_1{3,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% 
% %%EM
% load 'variables\test_set_EM_estimated_params_results.mat'
% result_matrix_2{1,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% load 'variables\validation_set_EM_estimated_params_results.mat'
% result_matrix_2{2,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% load 'variables\mp_set_EM_estimated_params_results.mat'
% result_matrix_2{3,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% %%Disc
% load 'variables\disc_test_set_results.mat'
% result_matrix_3{1,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% load 'variables\disc_validation_set_results.mat'
% result_matrix_3{2,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% load 'variables\disc_mp_set_results.mat'
% result_matrix_3{3,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% %%KNN
% load 'variables\knn_test_set_results.mat'
% result_matrix_4{1,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% load 'variables\knn_validation_set_results.mat'
% result_matrix_4{2,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% load 'variables\knn_mp_set_results.mat'
% result_matrix_4{3,rows/10} = struct('precision',results(1),'recall',results(2),'accuracy',results(3));
% 
% clearvars -except result_matrix_1 result_matrix_2 result_matrix_3 result_matrix_4;

% save('variables\result_matrices','result_matrix_1','result_matrix_2','result_matrix_3','result_matrix_4');

%%Plot collected results
load 'variables\result_matrices\result_matrices.mat'

plot_result_matrix(result_matrix_1,'Single gaussian estimated parameters')
plot_result_matrix(result_matrix_2,'EM estimated parameters')
plot_result_matrix(result_matrix_3,'Discriminative approach')
plot_result_matrix(result_matrix_4,'KNN')

clearvars;

function [] = plot_result_matrix(result_matrix,method)

symbol_max = 'max';
symbol_min = 'min';

features_vec = ([1:5] *10).^2 * 3;

figure('NumberTitle', 'off', 'Name', method);
subplot(2,1,1)

precision = [result_matrix{1,1}.precision result_matrix{1,2}.precision result_matrix{1,3}.precision result_matrix{1,4}.precision result_matrix{1,5}.precision];
recall = [result_matrix{1,1}.recall result_matrix{1,2}.recall result_matrix{1,3}.recall result_matrix{1,4}.recall result_matrix{1,5}.recall];
accuracy = [result_matrix{1,1}.accuracy result_matrix{1,2}.accuracy result_matrix{1,3}.accuracy result_matrix{1,4}.accuracy result_matrix{1,5}.accuracy];

plot(features_vec,precision);

[y,x] = max(precision);
text((x*10).^2*3,y,symbol_max);

[~,x] = find(precision == min(min(precision)));
text((x*10).^2*3,min(min(precision)),symbol_min);

hold on;
plot(features_vec,recall);

[y,x] = max(recall);
text((x*10).^2*3,y,symbol_max);

[~,x] = find(recall == min(min(recall)));
text((x*10).^2*3,min(min(recall)),symbol_min);

hold on;
plot(features_vec,accuracy);

[y,x] = max(accuracy);
text((x*10).^2*3,y,symbol_max);

[~,x] = find(accuracy == min(min(accuracy)));
text((x*10).^2*3,min(min(accuracy)),symbol_min);


title('test set')
xlabel('features')

legend({'precision','recall','accuracy'},'Location','southwest')

subplot(2,1,2)

precision = [result_matrix{2,1}.precision result_matrix{2,2}.precision result_matrix{2,3}.precision result_matrix{2,4}.precision result_matrix{2,5}.precision];
recall = [result_matrix{2,1}.recall result_matrix{2,2}.recall result_matrix{2,3}.recall result_matrix{2,4}.recall result_matrix{2,5}.recall];
accuracy = [result_matrix{2,1}.accuracy result_matrix{2,2}.accuracy result_matrix{2,3}.accuracy result_matrix{2,4}.accuracy result_matrix{2,5}.accuracy];

plot(features_vec,precision);

[y,x] = max(precision);
text((x*10).^2*3,y,symbol_max);

[~,x] = find(precision == min(min(precision)));
text((x*10).^2*3,min(min(precision)),symbol_min);

hold on;
plot(features_vec,recall);

[y,x] = max(recall);
text((x*10).^2*3,y,symbol_max);

[~,x] = find(recall == min(min(recall)));
text((x*10).^2*3,min(min(recall)),symbol_min);

hold on;
plot(features_vec,accuracy);

[y,x] = max(accuracy);
text((x*10).^2*3,y,symbol_max);

[~,x] = find(accuracy == min(min(accuracy)));
text((x*10).^2*3,min(min(accuracy)),symbol_min);

title('validation set')
xlabel('features')

legend({'precision','recall','accuracy'},'Location','southwest')
end