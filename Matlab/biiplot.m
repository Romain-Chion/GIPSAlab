function biiplot(dim)

scores_csv=fopen('C:\Users\Romain\Documents\Dropbox\EC Lyon\Stage\G3 - GIPSA\Logiciel\Test\PCA\biplot_lab.csv');
[~,ls,s]=csv2data_plot(scores_csv);
fclose(scores_csv);

coeff_csv=fopen('C:\Users\Romain\Documents\Dropbox\EC Lyon\Stage\G3 - GIPSA\Logiciel\Test\PCA\biplot_coeff.csv');
[mc,lc,c]=csv2data_plot(coeff_csv);
fclose(coeff_csv);

color={'k','m','c','y','b','g','r'};
if dim==2
    for j=1:size(c,1)
    scores=s(s(:,1)==j,2:3);
    labels=cell(size(scores,1),1);
    labels(:)=ls(j);
    biplot(c(:,2:3),'VarLabels',mc,'Color',color{j},...
        'ObsLabels',labels,'Scores',scores,'Clipping','off');
    hold on
    end
else
    for j=1:size(c,1)
    scores=s(s(:,1)==j,2:4);
    labels=cell(size(scores,1),1);
    labels(:)=ls(j);
    biplot(c(:,2:4),'VarLabels',mc,'Color',color{j},...
        'ObsLabels',labels,'Scores',scores,'Clipping','off');
    hold on
    end
end
hold off
end