function [measures,labels,data]=csv2data(data_csv)
% CSV2DATA   Get all graph data contained in a csv file
%
%   data_csv: fileID of the csv file
%   measures: cell array of text names of measures used
%   labels  : cell array of text labels of generative methodes used
%   data    : matrix of all measure values
%
%   See also TXT2GRAPH,CSV2GRAPH

% Get all lines
lines=textscan(data_csv,'%s','delimiter','\n','commentStyle','%');
% Get methodes labels
str=textscan(lines{1}{1},'%s','delimiter',';');
labels=cell(size(str{1},1),1);
for i=1:size(str{1},1)
    labels{i}=str{1}{i};
end
% Get measures label
str=textscan(lines{1}{2},'%s','delimiter',';');
measures=cell(size(str{1},1)-3,1);
for i=4:size(str{1},1)
    measures{i-3}=str{1}{i};
end
% Get data
data=zeros(size(lines{1},1)-2,size(str{1},1));
for i=3:size(lines{1},1)
    str=textscan(lines{1}{i},'%s','delimiter',';');
    % find the index of the generative methode used in the label cell array
    data(i-2,1)=find(ismember(labels,str{1}{1}));
    % get all remaining data in the line
    data(i-2,2:size(str{1},1))=cellfun(@str2num,str{1}(2:size(str{1},1)));
end
end