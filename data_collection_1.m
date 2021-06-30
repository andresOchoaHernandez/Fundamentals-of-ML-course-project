%% DATA COLLECTION

project_folder = '';
save(strcat(project_folder,'variables\project_folder'),'project_folder');

%%Reading the folders
training_folder_without_mask = dir(strcat(project_folder,'Face Mask Dataset\Train\WithoutMask\*.png'));
training_folder_with_mask = dir(strcat(project_folder,'Face Mask Dataset\Train\WithMask\*.png'));

test_folder_without_mask = dir(strcat(project_folder,'Face Mask Dataset\Test\WithoutMask\*.png'));
test_folder_with_mask = dir(strcat(project_folder,'Face Mask Dataset\Test\WithMask\*.png'));

validation_folder_without_mask = dir(strcat(project_folder,'Face Mask Dataset\Validation\WithoutMask\*.png'));
validation_folder_with_mask = dir(strcat(project_folder,'Face Mask Dataset\Validation\WithMask\*.png'));

%%Counting the samples
training_samples_without_mask = size(training_folder_without_mask,1);
training_samples_with_mask = size(training_folder_with_mask,1);

test_samples_without_mask = size(test_folder_without_mask,1);
test_samples_with_mask = size(test_folder_with_mask,1);

validation_samples_without_mask = size(validation_folder_without_mask,1);
validation_samples_with_mask = size(validation_folder_with_mask,1);

%%Creating the datasets
%%rows and columns values must be the same by desing, recommended values
%%are 10, 20, 30, 40 and 50. Higher values (7.5k+ features) will make LDA
%%computationally unmanageable
rows = 10;
columns = 10;
channels = 3 ;

save(strcat(project_folder,'variables\dimensions'),'rows','columns','channels','-v7.3');

%training set
training_set_without_mask = zeros(rows * columns * channels,training_samples_without_mask);
for i = 1:training_samples_without_mask
   tmp_img = imread(strcat(training_folder_without_mask(i).folder,'\',training_folder_without_mask(i).name)); 
   tmp_resized = imresize(tmp_img,[rows columns]);
   tmp_data = reshape(tmp_resized,rows * columns * channels,1);
   training_set_without_mask(:,i) = tmp_data;
end

training_set_with_mask = zeros(rows * columns * channels,training_samples_with_mask);
for i = 1:training_samples_with_mask
   tmp_img = imread(strcat(training_folder_with_mask(i).folder,'\',training_folder_with_mask(i).name)); 
   tmp_resized = imresize(tmp_img,[rows columns]);
   tmp_data = reshape(tmp_resized,rows * columns * channels,1);
   training_set_with_mask(:,i) = tmp_data;
end

train_set = [training_set_without_mask training_set_with_mask ];
train_set_labels = [ones(1,training_samples_without_mask) repmat(2,1,training_samples_with_mask)];

save(strcat(project_folder,'variables\train_set'),'train_set','train_set_labels','-v7.3');

%test set
test_set_without_mask = zeros(rows * columns * channels,test_samples_without_mask);
for i = 1:test_samples_without_mask
   tmp_img = imread(strcat(test_folder_without_mask(i).folder,'\',test_folder_without_mask(i).name)); 
   tmp_resized = imresize(tmp_img,[rows columns]);
   tmp_data = reshape(tmp_resized,rows * columns * channels,1);
   test_set_without_mask(:,i) = tmp_data;
end

test_set_with_mask = zeros(rows * columns * channels,test_samples_with_mask);
for i = 1:test_samples_with_mask
   tmp_img = imread(strcat(test_folder_with_mask(i).folder,'\',test_folder_with_mask(i).name)); 
   tmp_resized = imresize(tmp_img,[rows columns]);
   tmp_data = reshape(tmp_resized,rows * columns * channels,1);
   test_set_with_mask(:,i) = tmp_data;
end

test_set = [test_set_without_mask test_set_with_mask ];
test_set_labels = [ones(1,test_samples_without_mask) repmat(2,1,test_samples_with_mask)];

save(strcat(project_folder,'variables\test_set'),'test_set','test_set_labels','-v7.3');

%validation set
validation_set_without_mask = zeros(rows * columns * channels,validation_samples_without_mask);
for i = 1:validation_samples_without_mask
   tmp_img = imread(strcat(validation_folder_without_mask(i).folder,'\',validation_folder_without_mask(i).name)); 
   tmp_resized = imresize(tmp_img,[rows columns]);
   tmp_data = reshape(tmp_resized,rows * columns * channels,1);
   validation_set_without_mask(:,i) = tmp_data;
end

validation_set_with_mask = zeros(rows * columns * channels,validation_samples_with_mask);
for i = 1:validation_samples_with_mask
   tmp_img = imread(strcat(validation_folder_with_mask(i).folder,'\',validation_folder_with_mask(i).name)); 
   tmp_resized = imresize(tmp_img,[rows columns]);
   tmp_data = reshape(tmp_resized,rows * columns * channels,1);
   validation_set_with_mask(:,i) = tmp_data;
end

validation_set = [validation_set_without_mask validation_set_with_mask ];
validation_set_labels = [ones(1,validation_samples_without_mask) repmat(2,1,validation_samples_with_mask)];

save(strcat(project_folder,'variables\validation_set'),'validation_set','validation_set_labels','-v7.3');

%%CLASS 1 -> NO MASK
%%CLASS 2 -> MASK

clearvars -except result_matrix_1 result_matrix_2 result_matrix_3 result_matrix_4;