%Get a list of all minimum path between each node
function array = char_l(A)
D=distance_bin(A);
array=mean(D,2);
end