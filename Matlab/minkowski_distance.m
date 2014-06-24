function DM=minkowski_distance(h1,h2,r)
DM=0;
for i=1:size(h1,1)
    DM=DM+(abs(h1(i)-h2(i)))^r;
end
DM=DM^(1/r);
end