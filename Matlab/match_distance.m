function DM=match_distance(h1,h2)
DM=0;
h1i=0;
h2i=0;
for i=1:size(h1,1)
    h1i=h1i+h1(i);
    h2i=h2i+h2(i);
    DM=DM+abs(h1i-h2i);
end
end