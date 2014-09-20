function main(graph,density,methodes,measures,n)
    [name,path,~] = uiputfile(...
            {'*.csv','Matlab (MAT)'},'Save data in file...'); 
    file=fopen([path,name],'wt');
    if size(methodes,1)
    line='Name;';
    for i=1:size(measures,2)
        line=[line,measures{i}{1},';'];
    end
    fprintf(file,[line,'\n']);
    h=waitbar(0,'Generating graphs...');
    for i=1:size(methodes,2)
        for j=1:100
            line=sys_methode(methodes{i}{1},methodes{i}{2},j,density,n);
            system(line);
            graph_txt=fopen(['DATA\GRAPH\',strrep(methodes{i}{1},' ','_'),num2str(j),'.txt']);
            graph=txt2graph(graph_txt);
            save(['DATA\GRAPH\',strrep(methodes{i}{1},' ','_'),num2str(j),'.mat'],'graph');
            fclose(graph_txt);
            line=[methodes{i}{1},';'];
            for k=1:size(measures,2)
                m=sys_measure(measures{k}{2},graph);
                line=[line,num2str(m),';'];
            end
            fprintf(file,[line,'\n']);
            try
                waitbar(((i-1)*100+j)/(100*size(methodes,2)),h,...
                    [methodes{i}{1},': ',num2str(j),' model generated']);
            catch
                h=waitbar(((i-1)*100+j)/(100*size(methodes,2)),...
                    [methodes{i}{1},': ',num2str(j),' model generated']);
            end
        end
    end
    close(h);
    else
        [name, path] = uigetfile( ...
                   {'*.mat','Matrix (Matlab)'},...
                    'Select graphes for measuring','DATA\GRAPH\','multiselect', 'on');
        line='Name;';
        for i=1:size(measures,2)
            line=[line,measures{i}{1},';'];
        end
        fprintf(file,[line,'\n']);
        for i=1:size(name,2)
            load([path,name{i}],'graph');
            line=[name2label(name{i}),';'];
            for k=1:size(measures,2)
                m=sys_measure(measures{k}{2},graph);
                line=[line,num2str(m),';'];
            end
            fprintf(file,[line,'\n']);
        end
    end
    fclose(file);
end