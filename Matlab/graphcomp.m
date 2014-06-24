function perc = graphcomp(g1,g2)
perc=100*sum(sum(and(g1,g2)))/400;
end

