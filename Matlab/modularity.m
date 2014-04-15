%Get the average maximum modularity from modularity_und function
function m=modularity(graph)
    m=0;
    n=10;
    for i=1:n
        [~,Q]=modularity_und(graph);
        m=m+Q;
    end
    m=m/n;
end