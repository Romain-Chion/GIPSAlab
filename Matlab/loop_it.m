function loop_it(file,nbr,n,e,methode,measures)
% LOOP_IT   Run an iterative loop on the generative methode and save the
% measures in file
%
%   file : ID of the file opened with fopen
%   nbr  : number of iterations
%   n    : number of nodes
%   e    : number of edges
%
%   See also LOOP_NE
str=sys_methode2(methode{1},methode{2},n,e);
for i=1:nbr
    system(str);
    graph_txt=fopen(['DATA\GRAPH\',strrep(methode{1},' ','_'),num2str(n),'_',num2str(e),'.txt']);
    graph=txt2graph(graph_txt);
    save(['DATA\GRAPH\',strrep(methode{1},' ','_'),num2str(n),'_',num2str(e),'_',num2str(i),'.mat'],'graph');
    fclose(graph_txt);
    delete(['DATA\GRAPH\',strrep(methode{1},' ','_'),num2str(n),'_',num2str(e),'.txt']);
    line=[methode{1},';',num2str(n),';',num2str(e),';'];
    for k=1:size(measures,2)
        m=sys_measure(measures{k}{2},graph);
        line=[line,num2str(m),';'];
    end
    fprintf(file,[line,'\n']);
end
end