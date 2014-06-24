function sys=sys_methode(name,code,density,n)
% SYS_METHODE   associate a system command (Windows) to a generative
% methode function using density
%
%   name    : name of the generative methode
%   code    : name of the generative function
%   density : density of the graph generated
%   n       : number of nodes of generated graph
%
%   See also SYS_METHODE2, SYS_MEASURE
switch code
    case 'forestfire'
        b=sqrt((log(density)+4+0.002*n)/12);
        f=b;
        sys=['.\DATA\',code,...
            ' -n:',num2str(n),' -f:',num2str(f),' -b:',num2str(b),...
            ' -o:DATA\GRAPH\',strrep(name,' ','_'),'.txt'];
    case {'graphgen -g:w','graphgen -g:k','graphgen -g:b','graphgen -g:e'}
        sys=['.\DATA\',code,...
            ' -n:',num2str(n),' -m:',num2str(n*(n-1)*density/2),...
            ' -k:',num2str((n-1)*density/2),...
            ' -o:DATA\GRAPH\',strrep(name,' ','_'),'.txt'];
    case 'graphgen -g:c'                        
        system(['DATA\graphgen -g:p -o:DATA\GRAPH\',strrep(name,' ','_'),'.txt',...
        ' -n:',num2str(1/density)]);
    case 'graphgen -g:p'
        p=(0.35-log(density)-0.0007*n)/2.4;
        if p<=1
            p=1.0001;
        end
        system(['DATA\graphgen -g:p -o:DATA\GRAPH\',strrep(name,' ','_'),'.txt',...
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
            ' -o:DATA\GRAPH\',strrep(name,' ','_'),'.txt'];
        delete \DATA\temp.txt
    case 'maggen'
    case 'agmgen'
    case 'rtg'
end
end
