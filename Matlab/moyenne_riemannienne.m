function Cm=moyenne_riemannienne(C,e)
M=size(C,3);
Cm=sum(C,3)/M;
S=sum(logP(Cm,C))/M;
% t=0;
while S<e % and t<10
Cm=expP(Cm,S);
S=sum(logP(Cm,C))/M;
% t=t+1;
end

    function E=expP(P,S)
        A=sqrtm(P);
        B=pinv(A);
        E=A*exp(B*S*B)*A;
    end
    function L=logP(P,C)
        A=sqrtm(P);
        B=pinv(A);
        L=A*log(B*C*B)*A;
    end
end