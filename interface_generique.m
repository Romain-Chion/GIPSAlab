function interface_generique

% clear all windows
clc;
clear all;
close all;

% Include directory
addpath('Matlab');
addpath('BCT');
addpath('DATA');

% Initialize global parameters
methodes_csv=fopen('\DATA\methodes.csv');
measures_csv=fopen('\DATA\measures.csv');
methodes=textscan(methodes_csv,'%s %s','Delimiter',';');
measures=textscan(measures_csv,'%s %s','Delimiter',';');
fclose(methodes_csv);
fclose(measures_csv);
methodes_bool=zeros(size(methodes{1}),1);
measures_bool=zeros(size(measures{1}),1);
density=0;
n=0;
graph=[];

% Initialize window
scrsz=get(0,'ScreenSize');
dire=dir('interface_generique.m');
figure('Name',['Graph Generation (v1.0 ',datestr(dire.date,'dd-mm-yyyy'),')'],'NumberTitle','off',...
              'MenuBar','none','Resize','off',...
              'Position',[(scrsz(3)-800)/2 (scrsz(4)-600)/2 800 600]);

% Set up Graph panel
hpg=uipanel('Title','Graph setting','FontSize',12,'Position',[.6 .5125 .4 .475]);

% Load Graph
uicontrol('Parent',hpg,'Style','pushbutton','FontSize',12,'String','Select Graph',...
              'Position',[25 10 100 30],'Callback',@getGraph);
uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .5 .95 .45],...
              'FontSize',12,'HorizontalAlignment','left','String','Filepath: -');
uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .35 .95 .1],...
              'FontSize',12,'HorizontalAlignment','left','String','Filename: -');
uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .2 .95 .1],...
              'FontSize',12,'HorizontalAlignment','left','String','Nodes: -                 Density: -');
    function getGraph(hObj,event)
        try
            [name, path] = uigetfile( ...
                   {'*.mat','Matrix (Matlab)';...
                    '*.txt','Text (TXT)';...
                    '*.csv','Comma Separated Value (CSV)'},...
                    'Select Graph', 'multiselect', 'off');
            if name
                l=length(name);
                if strcmp(name(l-2:l),'txt')
                    graph_txt=fopen([path,name]);
                    graph=txt2graph(graph_txt);
                    fclose(graph_txt);
                elseif strcmp(name(l-2:l),'csv')
                    graph_csv=fopen([path,name]);
                    graph=csv2graph(graph_csv);
                    fclose(graph_csv);
                elseif strcmp(name(l-2:l),'mat')
                    load([path,name],'graph');
                end
                if size(graph,1)==size(graph,2)
                    density=density_und(graph);
                    n=size(graph,1);
    uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .5 .95 .45],...
              'FontSize',12,'HorizontalAlignment','left','String',['Filepath: ',path]);
    uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .35 .95 .1],...
              'FontSize',12,'HorizontalAlignment','left','String',['Filename: ',name]);
    uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .2 .95 .1],...
              'FontSize',12,'HorizontalAlignment','left','String',['Node: ',num2str(n),'        Density: ',num2str(density)]);
                    subplot('Position',[.001 .5125 0.58 0.475]);
                    if(0)
                        [X,Y]=adjacency_plot_und(graph);
                        plot(X,Y);
                    else
                        imagesc(graph); axis('off'); colormap(gray);
                    end
                end
            end
        catch merr
            errordlg(sprintf('No graph selected \n%s',merr.message), merr.identifier);
        end
    end

% Set up Generative Methods panel
hpm=uipanel('Title','Generative Methods','FontSize',12,'Position',[.0 .25 1 .25]);
for j=1:size(methodes{1})
    methode=methodes{1}(j);
    x=200*floor((j-1)/5)+10;
    y=25*mod(j-1,5)+5;
    uicontrol('Parent',hpm,'Style','checkbox','Position', [x y 190 24],...
                'String',methode,'Callback',{@m,j});
end
    function m(hObj,event,i)
        methodes_bool(i)=get(hObj,'Value');
    end

% Set up Measures/Distances panel
hpd=uipanel('Title','Measures','FontSize',12,'Position',[.0 .0 1 .25]);
for j=1:size(measures{1})
    measure=measures{1}(j);
    x=200*floor((j-1)/5)+10;
    y=25*mod(j-1,5)+5;
    uicontrol('Parent',hpd,'Style','checkbox','Position', [x y 190 24],...
                'String',measure,'Callback',{@d,j});
end
    function d(hObj,event,i)
        measures_bool(i)=get(hObj,'Value');
    end

% Main Launcher
uicontrol('Parent',hpg,'Style','pushbutton','FontSize',14,'String','GO!',...
              'Position', [195 10 100 30],'Callback', @mainLauncher);
    function mainLauncher(hObj,event)
        if max(graph)
            i=1;k=1;
            methodes_main={};
            while i<=size(methodes{1},1)
                if methodes_bool(i)
                    methodes_main{k}={methodes{1}{i} methodes{2}{i}};
                    k=k+1;
                end
                i=i+1;
            end
            i=1;k=1;
            measures_main={};
            while i<=size(measures{1},1)
                if measures_bool(i)
                    measures_main{k}={measures{1}{i} measures{2}{i}};
                    k=k+1;
                end
                i=i+1;
            end
            main(graph,density,methodes_main,measures_main,n); 
        else
            errordlg('No graph selected')
        end
    end
end

