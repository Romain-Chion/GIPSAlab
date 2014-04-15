%Get the average coreness from the kcoreness_centrality_bu function
function a=kcoreness_a(graph)
    a=mean(kcoreness_centrality_bu(graph));
end