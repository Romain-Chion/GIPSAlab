function geometrie_riemannienne(h1,h2,h3)
C=cov(h1,h2,h3);
load();
C1=Cm;
load();
C2=Cm;
load();
C3=Cm;
load();
C4=Cm;

MIN=min(distance_riemannienne(C,C1),distance_riemannienne(C,C2),...
    distance_riemannienne(C,C3),distance_riemannienne(C,C4));
switch MIN
    case C1
        str='';
    case C2
        str='';
    case C3
        str='';
    case C4
        str='';
end
display(['Ce graph est un ',str,'\n C1=',num2str(C1),'\n C2=',num2str(C2),...
    '\n C3=',num2str(C3),'\n C4=',num2str(C4)])
end