%% TESTING
function results = test_gen(set,name_of_set,elems_class_1,elems_class_2,W,class_1_mean,std_class_1,class_2_mean,std_class_2)

confusion_matrix = zeros(2,2);

for i=1:(elems_class_1 + elems_class_2)
    test_img = set (:,i);
    class = classify(test_img,W,class_1_mean,std_class_1,class_2_mean,std_class_2);
    
    
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

function class = classify (test_img,W,mean_1,std_1,mean_2,std_2)

projected_img = W' * test_img;
likelihood_class_1 = normpdf(projected_img,mean_1,std_1);
likelihood_class_2 = normpdf(projected_img,mean_2,std_2);

posterior_class_1 = (likelihood_class_1 * 0.5) / (likelihood_class_1 * 0.5 + likelihood_class_2 * 0.5);
posterior_class_2 = (likelihood_class_2 * 0.5) / (likelihood_class_1 * 0.5 + likelihood_class_2 * 0.5);

%fprintf('posterior class 1 : %.5f | posterior class 2 : %.5f \n',posterior_class_1,posterior_class_2);

if posterior_class_1 > posterior_class_2
    class = 1;
else
    class = 2;
end

end

