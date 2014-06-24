function [h,f]=histo(array,MAX,n)
array=array/MAX;
[h,f]=hist(array,(1/(2*n):1/n:1-1/(2*n)));
h=h'/sum(h);
f=f';
end