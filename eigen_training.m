function [eigen_vectors,eigen_values] = eigen_training(matrix,normalization)

if normalization ~= 0 && normalization ~= 1
    error('Second input must be boolean')
end

M=size(matrix,2);

prop_matrix = matrix' * matrix;

[eigen_vectors,eigen_values] = eig(prop_matrix);
[~,indexes] = sort (diag(eigen_values),'descend');
eigen_values = eigen_values (indexes,indexes);
eigen_vectors = eigen_vectors(:,indexes);

eigen_vectors = matrix * eigen_vectors;

if normalization == 1
    for i=1:M
        eigen_vectors(:,i)=eigen_vectors(:,i)/norm(eigen_vectors(:,i));
    end
end

end