%Get a list of all minimum path between each node
function array = distances(A)
D=distance_bin(A);
array=reshape(D,size(D,1)*size(D,1),1);
end