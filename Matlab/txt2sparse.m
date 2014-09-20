function S=txt2sparse(graph_txt)
% TXT2SPARSE     Get the sparse matrix form of the adjacency matrix of a
% graph from a text file with the list of its edges
%
%   graph_txt   : fileID
%
% See also CSV2DATA, CSV2GRAPH, TXT2GRQPH
str=textscan(graph_txt, '%s \t %s','HeaderLines',4);
mat=[cellfun(@str2num,str{1}) cellfun(@str2num,str{2})]+1;
MAX=max(max(mat));
S=sparse(mat(:,2),mat(:,1),ones(size(mat(:,1))),MAX,MAX);
end