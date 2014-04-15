function graph=txt2graph(graph_txt)
str=textscan(graph_txt, '%s \t %s','HeaderLines',4);
mat=[cellfun(@str2num,str{1}) cellfun(@str2num,str{2})];
graph=zeros(max(mat)+1);
for i=1:size(mat,1)
    graph(mat(i,1)+1,mat(i,2)+1)=1;
    graph(mat(i,2)+1,mat(i,1)+1)=1;
end
end