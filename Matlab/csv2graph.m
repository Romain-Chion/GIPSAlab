function graph=csv2graph(graph_csv)
% CSV2GRAPH     Get the adjacency matrix of a graph from a csv file with
% the matrix separated by comas.
%
%   graph_csv   : fileID
%
% See also CSV2DATA, TXT2GRAPH
lines=textscan(graph_csv,'%s');
graph=zeros(size(lines{1},1));
for i=1:size(lines{1},1)
    str=textscan(lines{1}{i},'%s','Delimiter',';');
    graph(i,:)=cellfun(@str2num,str{1}(:));
end
end