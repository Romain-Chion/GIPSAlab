function DH=distance_hellinger(h1,h2)
DH=0;
for i=1:size(h1,1)
    DH=DH+2*(sqrt(h1(i))-sqrt(h2(i)))^2;
end
end