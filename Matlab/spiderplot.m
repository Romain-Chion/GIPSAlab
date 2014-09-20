function spiderplot(array)

data_csv=fopen('C:\Users\Romain\Documents\Dropbox\EC Lyon\Stage\G3 - GIPSA\Logiciel\Test\spiderplot.csv');

[m,l,d]=csv2data_plot(data_csv);

color={'r','g','b','y','c','m','k'};
d_l=zeros(size(l,1),size(d,2)-1);
for i=1:size(l)
    d_l(i,:)=mean(d(d(:,1)==i,2:size(d,2)));
end
if array
radarplot(d_l(:,array),l,color,color,color,3);
else
radarplot(d_l,l,color,color,color,3);
end
legend(l,'Box','on');
end