function sys=sys_methode(name,code,j,density,n)
switch code
    case 'forestfire'
        sys=['.\DATA\',code,...
            ' -n:',num2str(n),' -f:',num2str(0.3),' -b:',num2str(0.25),...
            ' -o:DATA\GRAPH\',strrep(name,' ','_'),num2str(j),'.txt'];
    case {'graphgen -g:w','graphgen -g:k','graphgen -g:b','graphgen -g:e'}
        sys=['.\DATA\',code,...
            ' -n:',num2str(n),' -m:',num2str(n*(n-1)*density/2),...
            ' -k:',num2str((n-1)*density/2),...
            ' -o:DATA\GRAPH\',strrep(name,' ','_'),num2str(j),'.txt'];
    case 'graphgen -g:c'
        system(['DATA\graphgen -g:p -o:power_graph',num2str(i),'.txt',...
        ' -n:',num2str(1/density)]);
    case 'graphgen -g:p'
        p=0.6*density^-0.20;
        system(['DATA\graphgen -g:p -o:power_graph',num2str(i),'.txt',...
        ' -n:',num2str(n),' -p:',num2str(p)]);
    case 'krongen'
        k=round(log2(n));
        x=nthroot(density/2,k)-0.3;
        alpha=num2str(0.8+x);
        beta=num2str(0.4+x);
        gamma=num2str(x);
        matrix=['"',alpha,' ',beta,';',beta,' ',gamma,'"'];
        sys=['.\DATA\',code,...
            ' -m:',matrix,...
            ' -i:',num2str(k),...
            ' -o:DATA\GRAPH\',strrep(name,' ','_'),num2str(j),'.txt'];
        delete \DATA\temp.txt
    case 'maggen'
    case 'agmgen'
end

