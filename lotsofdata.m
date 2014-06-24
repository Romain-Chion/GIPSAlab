function lotsofdata
% Include directory
addpath('Matlab');
addpath('BCT');
addpath('DATA');
methodes_csv=fopen('\DATA\methodes.csv');
measures_csv=fopen('\DATA\measures2.csv');
methodes=textscan(methodes_csv,'%s %s','Delimiter',';');
measures=textscan(measures_csv,'%s %s','Delimiter',';');
fclose(methodes_csv);
fclose(measures_csv);
i=1;methodes_main={};
while i<=size(methodes{1},1)
	methodes_main{i}={methodes{1}{i} methodes{2}{i}};
	i=i+1;
end
i=1;measures_main={};
while i<=size(measures{1},1)
	measures_main{i}={measures{1}{i} measures{2}{i}};
	i=i+1;
end
try
[name,path,~] = uiputfile(...
            {'*.csv','Coma Separated Value (CSV)'});
file=fopen([path,name],'wt');
catch
    file=fopen('lotsofdata.csv','wt');
end
line='name;N;E;';
for i=1:size(measures_main,2)
    line=[line,measures_main{i}{1},';'];
end
fprintf(file,[line,'\n']);
%loop_it(file,nbr,n,e,methode,measures);
%loop_ne(file,nd,np,nf,ed,ep,ef,methodes,measures);
fclose(file);
end