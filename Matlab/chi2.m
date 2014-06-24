function m=chi2(h1,h2)
m=0;
for i=1:size(h1,1)
    if(h1(i)+h2(i))
    m=m+(h1(i)-h2(i))*(h1(i)-h2(i))/(h1(i)+h2(i));
    end
end
end