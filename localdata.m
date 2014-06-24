function localdata(j)
addpath('Matlab');
addpath('BCT');
addpath('DATA');
methodes_csv=fopen('\DATA\methodes2.csv');
measures_csv=fopen('\DATA\measures2.csv');
methodes=textscan(methodes_csv,'%s %s','Delimiter',';');
measures=textscan(measures_csv,'%s %s','Delimiter',';');
fclose(methodes_csv);
fclose(measures_csv);
name=methodes{1}{j};
for n=100:100:2000
    e=round(0.1*n*(n-1)/2);
    m=round(20000/n);
    cc=[];
    eff=[];
    cpl=[];
    deg=[];
    for i=1:m
        try
        line=sys_methode2(methodes{1}{j},methodes{2}{j},n,e);
        system(line);
        graph_txt=fopen(['DATA\GRAPH\',strrep(name,' ','_'),num2str(n),'_',num2str(e),'.txt']);
        graph=txt2graph(graph_txt);
        save(['DATA\GRAPH\Iteration\Randomize\',...
            strrep(name,' ','_'),num2str(n),'_',num2str(i),'.mat'],'graph');
        fclose(graph_txt);
        delete(['DATA\GRAPH\',strrep(name,' ','_'),num2str(n),'_',num2str(e),'.txt']);
        
        str=str2func(measures{2}{1});
        eff=cat(1,eff,str(graph,1));
        
        str=str2func(measures{2}{2});
        cc=cat(1,cc,str(graph));
        
        str=str2func(measures{2}{3});
        cpl=cat(1,cpl,str(graph));
        
        str=str2func(measures{2}{4});
        deg=cat(1,deg,str(graph)');
        end
    end
    save([measures{1}{1},'_',methodes{1}{j},num2str(n)],'eff');
    save([measures{1}{2},'_',methodes{1}{j},num2str(n)],'cc');
    save([measures{1}{3},'_',methodes{1}{j},num2str(n)],'cpl');
    save([measures{1}{4},'_',methodes{1}{j},num2str(n)],'deg');
end
end