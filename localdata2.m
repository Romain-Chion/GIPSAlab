function localdata2(j)
addpath('Matlab');
addpath('BCT');
addpath('DATA');
measures_csv=fopen('\DATA\measures2.csv');
measures=textscan(measures_csv,'%s %s','Delimiter',';');
fclose(measures_csv);
[name,path]=uigetfile({'*.mat','Matrix (Matlab)'},...
        'Select graphes for measuring','DATA\GRAPH\Données Réelles (coma)\Synthèse\','multiselect', 'on');
m=size(name,2);
cc=[];
eff=[];
cpl=[];
deg=[];
for i=1:m
    load([path,name{i}],'graph')

    str=str2func(measures{2}{1});
    eff=cat(1,eff,str(graph,1));

    str=str2func(measures{2}{2});
    cc=cat(1,cc,str(graph));

    str=str2func(measures{2}{3});
    cpl=cat(1,cpl,str(graph));

    str=str2func(measures{2}{4});
    deg=cat(1,deg,str(graph)');
end
n=size(name{1},2);
save([measures{1}{1},'_',name{1}(1:(n-5)),'90'],'eff');
save([measures{1}{2},'_',name{1}(1:(n-5)),'90'],'cc');
save([measures{1}{3},'_',name{1}(1:(n-5)),'90'],'cpl');
save([measures{1}{4},'_',name{1}(1:(n-5)),'90'],'deg');
end