%% TESTING
function results = test_knn(projected_train_set,train_set_labels,k,W,test_set,name_of_set,elems_class_1,elems_class_2)

confusion_matrix = zeros(2,2);

for i=1:(elems_class_1 + elems_class_2)
    test_img = test_set (:,i);
    class = knn(projected_train_set,train_set_labels,W'*test_img,k);
    
    
    if (1<=i && i<=elems_class_1) && class==1
        confusion_matrix(1,1) = confusion_matrix(1,1) + 1; 
    elseif (1<=i && i<=elems_class_1) && class==2
        confusion_matrix(2,1) = confusion_matrix(2,1) + 1;
    elseif (1<=elems_class_1+1 && i<=(elems_class_1 + elems_class_2)) && class==2
        confusion_matrix(2,2) = confusion_matrix(2,2) + 1;
     elseif (1<=elems_class_1+1 && i<=(elems_class_1 + elems_class_2)) && class==1
        confusion_matrix(1,2) = confusion_matrix(1,2) + 1;
    end
    
end

fprintf(strcat('\n===========\n',name_of_set,'\n'));

precision = confusion_matrix(1,1) / (confusion_matrix(1,1) + confusion_matrix(1,2));
recall = confusion_matrix(1,1) / (confusion_matrix(1,1) + confusion_matrix(2,1));
accuracy = (confusion_matrix(1,1) + confusion_matrix(2,2)) / sum(confusion_matrix(:));

results = [precision recall accuracy] * 100;
end

function class = knn(set,set_labels,point,k)

class_1_tot = sum(set_labels == 1);
class_2_tot = sum(set_labels == 2);

if k > size(set,2)
    error('k must be less than the available points')
end

distance_vector = zeros(1,size(set,2));
for i = 1: size(set,2)
    distance_vector(i)= abs(point - set(i)); 
end

[~,indexes] = sort(distance_vector);

indexes_k_nearest = indexes(1:k);

freq_class_1 = sum(indexes_k_nearest >=1 & indexes_k_nearest <= class_1_tot) ;
freq_class_2 = sum(indexes_k_nearest >= class_1_tot + 1 & indexes_k_nearest <= class_1_tot + class_2_tot) ;

if freq_class_1 > freq_class_2
    class = 1;
else
    class = 2;
end
end