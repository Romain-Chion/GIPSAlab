a=load('CC_Control_417')
b=load('CC_Patient_417')
c=load('DEG_Patient_417')
d=load('DEG_Control_417')
s1=load('CC_Small-World417')
s2=load('DEG_Small-World417')
e2=load('DEG_Erdos-Renyi417')
e1=load('CC_Erdos-Renyi417')
hist(a.cc/max(a.cc),30)
figure;hist(b.cc/max(b.cc),30)
figure;hist(c.deg/max(c.deg),30)
figure;hist(d.deg/max(d.deg),30)

function localdata
addpath('Matlab');
addpath('BCT');
addpath('DATA');
measures_csv=fopen('\DATA\measures2.csv');
measures=textscan(measures_csv,'%s %s','Delimiter',';');
fclose(measures_csv);
for n=100:100:2000
    e=round(0.1*n*(n-1)/2);
    m=round(20000/n);
    cc=[];
    deg=[];
    for i=1:m
        try
        system(['.\DATA\graphgen -g:w -p:0.005 -o:smallworld.txt -n:',...
            num2str(n),' -k:',num2str(round(e/n))]);
        graph_txt=fopen('smallworld.txt');
        graph=txt2graph(graph_txt);
        fclose(graph_txt);
        delete('smallworld.txt');
        
        str=str2func(measures{2}{2});
        cc=cat(1,cc,str(graph));
        
        str=str2func(measures{2}{4});
        deg=cat(1,deg,str(graph)');
        end
    end
    save([measures{1}{2},'_Small-World-',num2str(n)],'cc');
    save([measures{1}{4},'_Small-World-',num2str(n)],'deg');
end
end