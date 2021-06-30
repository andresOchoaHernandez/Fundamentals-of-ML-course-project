%% TESTING
function results = test_disc(set,name_of_set,elems_class_1,elems_class_2,W,separation_coordinate,configuration)

confusion_matrix = zeros(2,2);

for i=1:(elems_class_1 + elems_class_2)
    test_img = set (:,i);
    class = classify(test_img,W,separation_coordinate,configuration);

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

function class = classify (test_img,W,separation_coordinate,configuration)

projected_img = W' * test_img;

if configuration == 1
   
    if projected_img > separation_coordinate
        class = 2;
    else
        class = 1;
    end
    
elseif configuration == 2
    
    if projected_img > separation_coordinate
        class = 1;
    else
        class = 2;
    end
    
else
    error('Configuration must be 1 or 2');
end

end