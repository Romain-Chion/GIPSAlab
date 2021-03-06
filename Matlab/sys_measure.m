function m=sys_measure(code,graph)
% SYS_MEASURE   apply a measure on a graph using a string
%
%   code    : name of the measure function
%   graph   : adjacency matrix of a graph
%
%   See also SYS_METHODE, SYS_METHODE2
sys=str2func(code);
switch code
    case 'clustering_coef_bu'
        m=mean(sys(graph));
    case 'betweenness_bin'
        n=size(graph,1);
        m=mean(sys(graph))/((n-1)*(n-2));
    case {'density_und','transitivity_bu',...
            'efficiency_bin','kcoreness_a','kcoreness_m',...
            'charpath_d','charpath_l','charpath_r','modularity'}
        m=sys(graph);
    case 'degrees_und'
        n=size(graph,1);
        D=reshape(sys(graph),n*n,1);
        Distribution=zeros(max(D),1);
        for i=1:n*n
            Distribution(D(i))=Distribution(D(i))+1;
        end
    case 'distance_bin'
        m=max(max(sys(graph)));
    case 'assortativity_bin'
        m=sys(graph,0);
end