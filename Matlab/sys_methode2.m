function sys=sys_methode2(name,code,n,e)
% SYS_METHODE2   associate a system command (Windows) to a generative
% methode function using nodes and edges
%
%   name: name of the generative methode
%   code: name of the generative function
%   n   : number of nodes of graph generated
%   e   : number of edges of graph generated
%
%   See also SYS_METHODE, SYS_MEASURE
switch code
    case 'forestfire'
        d=2*e/(n*(n-1));
        b=sqrt((log(d)+4+0.002*n)/12);
        f=b;
        sys=['.\DATA\',code,...
            ' -n:',num2str(n),' -f:',num2str(f),' -b:',num2str(b),...
            ' -o:DATA\GRAPH\',strrep(name,' ','_'),'.txt'];
    case {'graphgen -g:w','graphgen -g:k','graphgen -g:b','graphgen -g:e'}
        sys=['.\DATA\',code,...
        ' -n:',num2str(n),' -m:',num2str(e),...
        ' -k:',num2str(round(e/n)),...
        ' -o:DATA\GRAPH\',strrep(name,' ','_'),'.txt'];
    case 'graphgen -g:p'
        d=2*e/(n*(n-1));
        p=(0.35-log(d)-0.0007*n)/2.4;
        if p<=1
            p=1.0001;
        end
        sys=['DATA\graphgen -g:p -o:DATA\GRAPH\',strrep(name,' ','_'),...
            '.txt -n:',num2str(n),' -p:',num2str(p)];
    case 'krongen'
        k=round(log2(n));
        d=2*e/(n*(n-1));
        x=nthroot(d/2,k)-0.3;
        alpha=num2str(0.8+x);
        beta=num2str(0.4+x);
        gamma=num2str(x);
        matrix=['"',alpha,' ',beta,';',beta,' ',gamma,'"'];
        sys=['.\DATA\',code,...
            ' -m:',matrix,...
            ' -i:',num2str(k),...
            ' -o:DATA\GRAPH\',strrep(name,' ','_'),'.txt'];
end
end

