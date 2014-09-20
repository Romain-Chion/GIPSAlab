function graph=txt2graph(graph_txt)
% TXT2GRAPH     Get the adjacency matrix of a graph from a text file with
% the list of its edges
%
%   graph_txt   : fileID
%
% See also CSV2DATA, CSV2GRAPH, TXT2SPARSE
str=textscan(graph_txt, '%s \t %s','HeaderLines',4);
mat=[cellfun(@str2num,str{1}) cellfun(@str2num,str{2})]+1;
graph=zeros(max(max(mat)));
for i=1:size(mat,1)
    graph(mat(i,1),mat(i,2))=1;
    graph(mat(i,2),mat(i,1))=1;
end
end