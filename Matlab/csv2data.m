function [measures,label,data]=csv2data(data_csv)
% Get all lines
lines=textscan(data_csv,'%s','delimiter','\n','commentStyle','%');
% Get methodes labels
str=textscan(lines{1}{1},'%s','delimiter',';');
label=cell(size(str{1},1),1);
for i=1:size(str{1},1)
    label{i}=str{1}{i};
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
    data(i-2,1)=find(ismember(label,str{1}{1}));
    data(i-2,2:size(str{1},1))=cellfun(@str2num,str{1}(2:size(str{1},1)));
end
end