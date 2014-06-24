function loop_ne(file,nd,np,nf,ed,ep,ef,methode,measures)
% LOOP_NE     Run a loop on the generative methode changing node and
% edges numbers and save the measures in file
%
%   file : ID of the file opened with fopen
%   nd   : Begining of the node loop
%   np   : Node loop step
%   nf   : End of the node loop
%   ed   : Begining of the edge loop
%   ep   : Edge loop step
%   ef   : End of the edge loop
%
%   See also LOOP_IT
for n=nd:np:nf
    for e=ed:ep:ef
        line=sys_methode2(methode{1},methode{2},n,e,0);
        system(line);
        graph_txt=fopen(['DATA/GRAPH/',strrep(methode{1},' ','_'),num2str(n),'_',num2str(e),'.txt']);
        graph=txt2graph(graph_txt);
        save(['DATA/GRAPH/',strrep(methode{1},' ','_'),num2str(n),'_',num2str(e),'.mat'],'graph');
        fclose(graph_txt);
        delete(['DATA/GRAPH/',strrep(methode{1},' ','_'),num2str(n),'_',num2str(e),'.txt']);
        line=[methode{1},';',num2str(n),';',num2str(e),';'];
        for k=1:size(measures,2)
            m=sys_measure(measures{k}{2},graph);
            line=[line,num2str(m),';'];
        end
        fprintf(file,[line,'\n']);
    end
end
end