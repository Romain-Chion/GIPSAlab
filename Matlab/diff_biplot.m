function diff_biplot(dim,d)

scores_csv=fopen('C:\Users\Romain\Documents\Dropbox\EC Lyon\Stage\G3 - GIPSA\Logiciel\Test\PCA\biplot_lab4.csv');
[~,ls,s]=csv2data_plot(scores_csv);
fclose(scores_csv);

coeff_csv=fopen('C:\Users\Romain\Documents\Dropbox\EC Lyon\Stage\G3 - GIPSA\Logiciel\Test\PCA\biplot_coeff4.csv');
[mc,lc,c]=csv2data_plot(coeff_csv);
fclose(coeff_csv);

j=1
scores=s(s(:,1)==j,2:3);
scores(:,1)=-scores(:,1);
labels=cell(size(scores,1),1);
labels(:)=ls(j);
diff=s(s(:,1)==j,d);
diff=(diff-min(diff))/(max(diff)-min(diff));
I=(0:0.05:0.95);
for k =1:size(I,2)
    biplot(c(:,2:3),'Color',[0.8*exp(-I(k)+0.05) 0.8*exp(-I(k)+0.05) 0.8*exp(-I(k)+0.05)],...
        'Scores',scores(diff(:)>I(k),:,:),'Clipping','off');
    hold on
end

j=2
scores=s(s(:,1)==j,2:3);
scores(:,1)=-scores(:,1);
labels=cell(size(scores,1),1);
labels(:)=ls(j);
diff=s(s(:,1)==j,d);
diff=(diff-min(diff))/(max(diff)-min(diff));
for k =1:size(I,2)
    biplot(c(:,2:3),'Color',[1 0.8*exp(-I(k)+0.05) 1],...
        'Scores',scores(diff(:)>=I(k),:),'Clipping','off');
end

j=3
scores=s(s(:,1)==j,2:3);
scores(:,1)=-scores(:,1);
labels=cell(size(scores,1),1);
labels(:)=ls(j);
diff=s(s(:,1)==j,d);
diff=(diff-min(diff))/(max(diff)-min(diff));
for k =1:size(I,2)
    biplot(c(:,2:3),'Color',[0.8*exp(-I(k)+0.05) 1 1],...
        'Scores',scores(diff(:)>=I(k),:),'Clipping','off');
end

j=4
scores=s(s(:,1)==j,2:3);
scores(:,1)=-scores(:,1);
labels=cell(size(scores,1),1);
labels(:)=ls(j);
diff=s(s(:,1)==j,d);
diff=(diff-min(diff))/(max(diff)-min(diff));
for k =1:size(I,2)
    biplot(c(:,2:3),'Color',[1 1 0.8*exp(-I(k)+0.05)],...
        'Scores',scores(diff(:)>=I(k),:),'Clipping','off');
end

j=5
scores=s(s(:,1)==j,2:3);
scores(:,1)=-scores(:,1);
labels=cell(size(scores,1),1);
labels(:)=ls(j);
diff=s(s(:,1)==j,d);
diff=(diff-min(diff))/(max(diff)-min(diff));
for k =1:size(I,2)
    biplot(c(:,2:3),'Color',[0.8*exp(-I(k)+0.05) 0.8*exp(-I(k)+0.05) 1],...
        'Scores',scores(diff(:)>=I(k),:),'Clipping','off');
end

j=6
scores=s(s(:,1)==j,2:3);
scores(:,1)=-scores(:,1);
labels=cell(size(scores,1),1);
labels(:)=ls(j);
diff=s(s(:,1)==j,d);
diff=(diff-min(diff))/(max(diff)-min(diff));
for k =1:size(I,2)
    biplot(c(:,2:3),'Color',[0.8*exp(-I(k)+0.05) 1 0.8*exp(-I(k)+0.05)],...
        'Scores',scores(diff(:)>=I(k),:),'Clipping','off');
end

j=7
scores=s(s(:,1)==j,2:3);
scores(:,1)=-scores(:,1);
labels=cell(size(scores,1),1);
labels(:)=ls(j);
diff=s(s(:,1)==j,d);
diff=(diff-min(diff))/(max(diff)-min(diff));
for k =1:size(I,2)
    biplot(c(:,2:3),'Color',[1 0.8*exp(-I(k)+0.05) 0.8*exp(-I(k)+0.05)],...
        'Scores',scores(diff(:)>=I(k),:),'Clipping','off');
end

hold off
end