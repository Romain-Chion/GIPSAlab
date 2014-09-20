load(['CC_Forest Fire500.mat']);
i=find(cc);
b=cc(i);
load(['CC_Preferential Attachment500.mat']);
i=find(cc);
c=cc(i);
load(['CC_Small-World500.mat']);
i=find(cc);
d=cc(i);
f=figure;
hist(b,(0.01:0.02:0.99));
hold on
hist(c,(0.01:0.02:0.99));
hist(d,(0.01:0.02:0.99));
h=findobj(gca,'Type','patch');
set(h(1),'FaceColor',[1 0 0],'EdgeColor','r');
set(h(2),'FaceColor',[0 1 0],'EdgeColor','g');
set(h(3),'FaceColor',[0 0 1],'EdgeColor','b');
legend('Forest Fire','Preferential Attachement',...
    'Small World');
title('Clustering Coefficient');
