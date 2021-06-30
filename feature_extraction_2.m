%% FEATURE EXTRACTION 
load 'variables\train_set.mat'
%%LDA
%%Separating classes
no_mask_set = train_set(:,1:sum(train_set_labels == 1));
mask_set = train_set(:,sum(train_set_labels == 1)+1:sum(train_set_labels == 1)+ sum(train_set_labels == 2));

no_mask_mean = mean(no_mask_set,2);
mask_mean = mean(mask_set,2);

scatter_no_mask = cov(no_mask_set');
scatter_mask = cov(mask_set');

within_class_scatter = bsxfun(@plus,scatter_no_mask,scatter_mask);
between_class_scatter = (no_mask_mean - mask_mean)*(no_mask_mean - mask_mean)';

prod_Sw_inv_Sb =within_class_scatter \ between_class_scatter;

[V,D] = eig(prod_Sw_inv_Sb);
[~,indexes] = sort (diag(D),'descend');
V = V(:,indexes);
W = V(:,1);

projected_train_set = W'*train_set;

load 'variables\project_folder.mat'
save(strcat(project_folder,'variables\W'),'W');
save(strcat(project_folder,'variables\projected_train_set'),'projected_train_set');

clearvars -except result_matrix_1 result_matrix_2 result_matrix_3 result_matrix_4;