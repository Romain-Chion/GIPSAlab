function DB=distance_bhattacharyya(h1,h2)
DB=0;
for i=1:size(h1,1)
    DB=DB+sqrt(h1(i)*h2(i));
end
end