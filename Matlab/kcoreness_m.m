%Get the maximum coreness from the kcoreness_centrality_bu function
function m=kcoreness_m(graph)
    m=max(kcoreness_centrality_bu(graph));
end