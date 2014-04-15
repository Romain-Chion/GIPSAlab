function interface_RGB_visualize

% clear all windows
clc;
clear all;
close all;

% Include directory
addpath('Matlab');
addpath('BCT');
addpath('DATA');

% Initialize global parameters

R=[];   %red data
G=[];   %green data
B=[];   %blue data
I=[];   %image data, sum of R+G+B channels
r=0;    %red data choice
g=0;    %green data choice
b=0;    %blue data choice
m=0;    %measure choice
measures=[];    %list of measures
labels=[];      %list of labels
data=[];        %complete data

% Initialize window
scrsz=get(0,'ScreenSize');
dire=dir('interface_RGB_visualize.m');
figure('Name',['RGB Data Visualization (v0.1 ',datestr(dire.date,'dd-mm-yyyy'),')'],'NumberTitle','off',...
              'MenuBar','none','Resize','off',...
              'Position',[(scrsz(3)-800)/2 (scrsz(4)-600)/2 800 600]);

% Set up Data panel
hpg=uipanel('Title','Graph setting','FontSize',12,'Position',[.5 .0 .5 .333]);

% Save image plotted
uicontrol('Parent',hpg,'Style','pushbutton','FontSize',12,'String','Save Image',...
              'Position', [250 10 100 30],'Callback', @saveData);
    function saveData(hObj,event)
    end

% Load Data
uicontrol('Parent',hpg,'Style','pushbutton','FontSize',12,'String','Select Data',...
              'Position',[50 10 100 30],'Callback',@getData);
uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .5 .95 .4],...
              'FontSize',12,'HorizontalAlignment','left','String','Filepath: -');
uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .35 .95 .1],...
              'FontSize',12,'HorizontalAlignment','left','String','Filename: -');
    function getData(hObj,event)
        try
            [name, path] = uigetfile( ...
                   {'*.csv','Comma Separated Value (CSV)'},...
                    'Select data', 'multiselect', 'off');
            if name
                data_csv=fopen([path,name]);
                [measures,labels,data]=csv2data(data_csv);
                fclose(data_csv);
    uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .5 .95 .4],...
              'FontSize',12,'HorizontalAlignment','left','String',['Filepath: ',path]);
    uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .25 .95 .1],...
              'FontSize',12,'HorizontalAlignment','left','String',['Filename: ',name]);
                R=[];G=[];B=[];I=[];
                r=0;g=0;b=0;m=0;
                setInterface;
            end
        catch merr
            errordlg(sprintf('No data selected \n%s',merr.message), merr.identifier);
        end
    end

setInterface;
function setInterface
% Set up RGB channels panel
hpc=uipanel('Title','RGB Channels','FontSize',12,'Position',[.0 .333 .5 .666]);

% Set up red channel
uicontrol('Parent',hpc,'Style','popupmenu','Units','normalized','Callback',@getRed,...
          'Position',[.05 .7 .45 .2],'FontSize',12,'String',lbl2str(labels));
uicontrol('Parent',hpc,'Style','text','Units','normalized','Position',[.55 .7 .45 .2],...
          'FontSize',12,'HorizontalAlignment','left','String','Choose red channel');
    function getRed(hObj,event)
        r = get(hObj,'Value');
        R = zeros(max(data(2,:)),max(data(3,:)));
        plotData
    end

% Set up green channel
uicontrol('Parent',hpc,'Style','popupmenu','Units','normalized','Callback',@getGreen,...
          'Position',[.05 .4 .45 .2],'FontSize',12,'String',lbl2str(labels));
uicontrol('Parent',hpc,'Style','text','Units','normalized','Position',[.55 .4 .45 .2],...
          'FontSize',12,'HorizontalAlignment','left','String','Choose green channel');
    function getGreen(hObj,event)
        g = get(hObj,'Value');
        G = zeros(max(data(2,:)),max(data(3,:)));
        plotData
    end

% Set up blue channel
uicontrol('Parent',hpc,'Style','popupmenu','Units','normalized','Callback',@getBlue,...
          'Position',[.05 .1 .45 .2],'FontSize',12,'String',lbl2str(labels));
uicontrol('Parent',hpc,'Style','text','Units','normalized','Position',[.55 .1 .45 .2],...
          'FontSize',12,'HorizontalAlignment','left','String','Choose blue channel');
    function getBlue(hObj,event)
        b = get(hObj,'Value');
        B = zeros(max(data(2,:)),max(data(3,:)));
        plotData
    end

% Set up Measures panel
hpm=uipanel('Title','Measure','FontSize',12,'Position',[.0 .0 .5 .333]);
uicontrol('Parent',hpm,'Style','popupmenu','Units','normalized','Callback',@getMeasure,...
          'Position',[.05 .4 .45 .2],'FontSize',12,'String',lbl2str(labels));
uicontrol('Parent',hpm,'Style','text','Units','normalized','Position',[.55 .4 .45 .2],...
          'FontSize',12,'HorizontalAlignment','left','String','Choose measure');
    function getMeasure(hObj,event)
        plotData
    end
end

% Plot Data
    function plotData
        if data
        if r&&g&&b&&m
            MAX=max(max(max(R)),max(max(G)),max(max(B)));
            R=255*R/MAX;G=255*G/MAX;B=255*B/MAX;
            I=cat(3,R,G,B);
            subplot('Position',[.5 .333 0.5 0.666]);
            imagesc(I);
        end
        end
    end

% Labels and mesure vector to string for menu
    function str=lbl2str(labels)
        try
            str=labels(1);
            for i=1:size(labels,1);
                str=[str,'|',labels(i)]
            end
        catch
            str='|';
        end
    end
end

