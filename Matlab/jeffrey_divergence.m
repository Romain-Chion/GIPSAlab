function DJ=jeffrey_divergence(h1,h2)
DJ=0;
for i=1:size(h1,1)
    mi=(h1(i)+h2(i))/2;
    DJ=DJ+h1(i)+log(h1(i)/mi)+h2(i)+log(h2(i)/mi);
end
end