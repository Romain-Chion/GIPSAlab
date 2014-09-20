function randomizer(alpha)
alpha=10;
% Include directory
addpath('Matlab');
addpath('BCT');
addpath('DATA');

% Select files
[name,path]=uigetfile({'*.mat','Matrix (Matlab)'},...
        'Select graphes for measuring','DATA\GRAPH\','multiselect', 'on');

% Randomize graphes
for i=1:size(name,2)
    name{i}
    load([path,name{i}],'graph')
    n=size(name{i},2);
    graph=randomizer_bin_und(graph,alpha/100);
    save([path,name{i}(1:(n-4)),'_',num2str(alpha),'p.mat'],'graph');
end
alpha=15;

% Randomize graphes
for i=1:size(name,2)
    name{i}
    load([path,name{i}],'graph')
    n=size(name{i},2);
    graph=randomizer_bin_und(graph,alpha/100);
    save([path,name{i}(1:(n-4)),'_',num2str(alpha),'p.mat'],'graph');
end
end