function DR=distance_riemannienne(C1,C2)
L=eig(pinv(C1)*C2);
DR=sqrt(sum(log(log(L))));
end