n=(100:100:2000);
p=(1.02:0.01:4);
d=zeros(size(n,2),size(p,2));
for i=1:size(n,2);
for j=1:size(p,2);
system(['DATA\graphgen -g:p -o:power_graph.txt',...
' -n:',num2str(n(i)),' -p:',num2str(p(j))]);
graph_txt=fopen('power_graph.txt');
graph=txt2graph(graph_txt);
d(i,j)=density_und(graph);
fclose(graph_txt);
delete('power_graph.txt');
end
end
save('d','d');

dp=log(d);
Z=reshape(dp,20*399,1);

X=[];
for i=1:size(p,2);
X=cat(1,X,n');
end

Y=[];
for i=1:size(p,2);
Y=cat(1,Y,ones(size(n))'*p(i));
end

X=X(:);
Y=Y(:);
Z=Z(:);
nx=length(X);
U=ones(nx,1);
M=[U X Y];
K=M\Z;

for i=1:size(n,2);
for j=1:size(p,2);
z(i,j)=exp(K(2)*n(i)+K(3)*p(j)+K(1));
end
end

surf(p,n,z)
figure
surf(p,n,d)