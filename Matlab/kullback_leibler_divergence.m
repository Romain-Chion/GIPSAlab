function DKL=kullback_leibler_divergence(h1,h2)
DKL=0;
for i=1:size(h1,1)
    DKL=DKL+h1(i)+log(h1(i)/h2(i));
end
end