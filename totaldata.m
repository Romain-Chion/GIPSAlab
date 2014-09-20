function totaldata(i)
addpath('Matlab');
addpath('BCT');
addpath('DATA');
total=fopen(['total',num2str(i),'bis.csv'],'w');
methodes_csv=fopen('\DATA\methodes2.csv');
measures_csv=fopen('\DATA\measures3.csv');
methodes=textscan(methodes_csv,'%s %s','Delimiter',';');
measures=textscan(measures_csv,'%s %s','Delimiter',';');
fclose(methodes_csv);
fclose(measures_csv);
CC_SW=load('DATA\Histogrammes\CC\CC_Small-World500.mat');
CC_RPL=load('DATA\Histogrammes\CC\CC_Power Law500.mat');
CC_RkR=load('DATA\Histogrammes\CC\CC_Random_k-Regular500.mat');
CC_PA=load('DATA\Histogrammes\CC\CC_Preferential Attachment500.mat');
CC_KG=load('DATA\Histogrammes\CC\CC_Kronecker500.mat');
CC_FF=load('DATA\Histogrammes\CC\CC_Forest Fire500.mat');
CC_ER=load('DATA\Histogrammes\CC\CC_Erdos-Renyi500.mat');
for j=1:100
    CC=zeros(7,1);
    DEG=zeros(7,1);
    
        line=sys_methode2(methodes{1}{i},methodes{2}{i},500,12475);
        system(line);
        graph_txt=fopen(['DATA\GRAPH\',strrep(methodes{1}{i},' ','_'),'.txt']);
        graph=txt2graph(graph_txt);
        fclose(graph_txt);
        delete(['DATA\GRAPH\',strrep(methodes{1}{i},' ','_'),'.txt']);

        cc=clustering_coef_bu(graph);
        deg=degrees_und(graph);
        
        MAXG=max(deg);
        MAX=max([CC_SW.cc;cc]);
        h1=histo(cc,MAX,30);
        h2=histo(CC_SW.cc,MAX,30);
        [~,CC(1)]=emd(h1,h2);
        h1=histo(deg,MAXG,30);
        [~,DEG(1)]=emd(h1,h2);
        
        MAX=max([CC_RPL.cc;cc]);
        h1=histo(cc,MAX,30);
        h2=histo(CC_RPL.cc,MAX,30);
        [~,CC(2)]=emd(h1,h2);
        h1=histo(deg,MAXG,30);
        [~,DEG(2)]=emd(h1,h2);
        
        MAX=max([CC_RkR.cc;cc]);
        h1=histo(cc,MAX,30);
        h2=histo(CC_RkR.cc,MAX,30);
        [~,CC(3)]=emd(h1,h2);
        h1=histo(deg,MAXG,30);
        [~,DEG(3)]=emd(h1,h2);
        
        MAX=max([CC_PA.cc;cc]);
        h1=histo(cc,MAX,30);
        h2=histo(CC_PA.cc,MAX,30);
        [~,CC(4)]=emd(h1,h2);
        h1=histo(deg,MAX,30);
        [~,DEG(4)]=emd(h1,h2);
        
        MAX=max([CC_KG.cc;cc]);
        h1=histo(cc,MAX,30);
        h2=histo(CC_KG.cc,MAX,30);
        [~,CC(5)]=emd(h1,h2);
        h1=histo(deg,MAX,30);
        [~,DEG(5)]=emd(h1,h2);
        
        MAX=max([CC_FF.cc;cc]);
        h1=histo(cc,MAX,30);
        h2=histo(CC_FF.cc,MAX,30);
        [~,CC(6)]=emd(h1,h2);
        h1=histo(deg,MAX,30);
        [~,DEG(6)]=emd(h1,h2);
        
        MAX=max([CC_ER.cc;cc]);
        h1=histo(cc,MAX,30);
        h2=histo(CC_ER.cc,MAX,30);
        [~,CC(7)]=emd(h1,h2);
        h1=histo(deg,MAX,30);
        [~,DEG(7)]=emd(h1,h2);
        
        line=[methodes{1}{i},';',num2str(CC(1)),';',num2str(CC(2)),...
            ';',num2str(CC(3)),';',num2str(CC(4)),';',num2str(CC(5)),...
            ';',num2str(CC(6)),';',num2str(CC(7)),';',num2str(DEG(1)),...
            ';',num2str(DEG(2)),';',num2str(DEG(3)),';',num2str(DEG(4)),...
            ';',num2str(DEG(5)),';',num2str(DEG(6)),';',num2str(DEG(7)),...
            ';',num2str(mean(cc)),';'];
        for k=1:5
            line=[line,num2str(sys_measure(measures{2}{k},graph)),';'];
        end
        line=[line,num2str(assortativity_bin(graph,0)),';'];
        fprintf(total,[line,'\n']);
    
end
fclose(total);
end