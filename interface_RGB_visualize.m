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

R=[];   %red channel
G=[];   %green channel
B=[];   %blue channel
I=[];   %image data, sum of R+G+B channels
S=100;  %scale factor
r=0;    %red data choice
g=0;    %green data choice
b=0;    %blue data choice
m=0;    %measure choice
data_R=[];      %red data
data_G=[];      %green_data
data_B=[];      %blue_data
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
        if plotData
            [name,path,~] = uiputfile(...
            {'*.*','All Files';...
            '*.jpeg;*.jpg','Joint Photographic Experts Group (JPEG)';...
            '*.bmp','Bitmap (BMP)';...
            '*.png','Portable Network Graphics (PNG)';...
            '*.gif','Graphics Interchange Format (GIF)'});            
        try
            imwrite(I,[path,name]);
        catch merr
            errordlg(sprintf('Invalid save \n%s',merr.message), merr.identifier);
        end
        end
    end

% Load Data
uicontrol('Parent',hpg,'Style','pushbutton','FontSize',12,'String','Select Data',...
              'Position',[50 10 100 30],'Callback',@getData);
uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .4 .95 .4],...
              'FontSize',12,'HorizontalAlignment','left','String','Filepath: -');
uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .25 .95 .1],...
              'FontSize',12,'HorizontalAlignment','left','String','Filename: -');
uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .85 .35 .1],...
              'FontSize',12,'HorizontalAlignment','left','String','Scalar Parameter :');
uicontrol('Parent',hpg,'Style','edit','Units','normalized','Position',[.65 .85 .30 .1],...
              'FontSize',12,'String',S,'Callback',@getS);
    function getS(hObj,event)
        try
            S=str2double(get(hObj,'String'));
        catch merr
            errordlg(sprintf('Invalid scalar entry \n%s',merr.message), merr.identifier);
        end
    end
    function getData(hObj,event)
        try
            [name, path] = uigetfile( ...
                   {'*.csv','Comma Separated Value (CSV)'},...
                    'Select data', 'multiselect', 'off');
            if name
                data_csv=fopen([path,name]);
                [measures,labels,data]=csv2data(data_csv);
                fclose(data_csv);
    uicontrol('Parent',hpg,'Style','text','Units','normalized','Position',[.05 .4 .95 .4],...
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
    if data
        data_R=[];
        r = get(hObj,'Value')-1;
        j=1;
        for i=1:size(data,1)
        if r==data(i,1)
            data_R(j,:)=data(i,:);
            j=j+1;
        end
        end
        plotData;
    end
    end

% Set up green channel
uicontrol('Parent',hpc,'Style','popupmenu','Units','normalized','Callback',@getGreen,...
          'Position',[.05 .4 .45 .2],'FontSize',12,'String',lbl2str(labels));
uicontrol('Parent',hpc,'Style','text','Units','normalized','Position',[.55 .4 .45 .2],...
          'FontSize',12,'HorizontalAlignment','left','String','Choose green channel');
    function getGreen(hObj,event)
        data_G=[];
        g = get(hObj,'Value')-1;
        j=1;
        for i=1:size(data,1)
        if g==data(i,1)
            data_G(j,:)=data(i,:);
            j=j+1;
        end
        end
        plotData;
    end

% Set up blue channel
uicontrol('Parent',hpc,'Style','popupmenu','Units','normalized','Callback',@getBlue,...
          'Position',[.05 .1 .45 .2],'FontSize',12,'String',lbl2str(labels));
uicontrol('Parent',hpc,'Style','text','Units','normalized','Position',[.55 .1 .45 .2],...
          'FontSize',12,'HorizontalAlignment','left','String','Choose blue channel');
    function getBlue(hObj,event)
        data_B=[];
        b = get(hObj,'Value')-1;
        j=1;
        for i=1:size(data,1)
        if b==data(i,1)
            data_B(j,:)=data(i,:);
            j=j+1;
        end
        end
        plotData;
    end

% Set up Measures panel
hpm=uipanel('Title','Measure','FontSize',12,'Position',[.0 .0 .5 .333]);
uicontrol('Parent',hpm,'Style','popupmenu','Units','normalized','Callback',@getMeasure,...
          'Position',[.05 .4 .45 .2],'FontSize',12,'String',lbl2str(measures));
uicontrol('Parent',hpm,'Style','text','Units','normalized','Position',[.55 .4 .45 .2],...
          'FontSize',12,'HorizontalAlignment','left','String','Choose measure');
    function getMeasure(hObj,event)
        m = get(hObj,'Value');
        plotData;
    end
end

% Plot Data
    function bool=plotData
        bool=0;
        if data
        R = zeros(ceil(max(data(:,2))/S),ceil(max(data(:,3))/S));
        G = R; B = R;
        if m
            for i=1:size(data_R,1)
                N=ceil(data_R(i,2)/S);
                E=ceil(data_R(i,3)/S);
                R(N,E)=data_R(i,m+2);
            end
            for i=1:size(data_G,1)
                N=ceil(data_G(i,2)/S);
                E=ceil(data_G(i,3)/S);
                G(N,E)=data_G(i,m+2);
            end
            for i=1:size(data_B,1)
                N=ceil(data_B(i,2)/S);
                E=ceil(data_B(i,3)/S);
                B(N,E)=data_B(i,m+2);
            end
            MAX=max(max([R,G,B]));
            R=R/MAX;G=G/MAX;B=B/MAX;
            I=cat(3,R,G,B);
            subplot('Position',[.5 .333 0.5 0.666]);
            imagesc(I);axis('off');
            bool=1;
        end
        end
    end

% Labels and mesure vector to string for menu
    function str=lbl2str(labels)
        str=' ';
        try
            for i=1:size(labels,1);
                str=[str,'|',labels{i}]
            end
        end
    end
end

