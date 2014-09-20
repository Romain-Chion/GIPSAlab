n=(100:100:2000);
f=(0.1:0.01:0.4);
b=(0.1:0.01:0.4);
d=zeros(size(n,2)*size(f,2)*size(b,2));
X1=d;X2=d;X3=d;Z=d;
for i=1:size(n,2);
for j=1:size(f,2);
for k=1:size(b,2);
l=k+(j-1)*size(b,2)+(i-1)*size(f,2)*size(b,2);
X1(l)=n(i);
X2(l)=f(j);
X3(l)=b(k);
system(['DATA\forestfire -n:',num2str(n(i)),' -f:',num2str(f(j)),...
    ' -b:',num2str(b(k)),' -o:forestfire.txt']);
graph_txt=fopen('forestfire.txt');
graph=txt2graph(graph_txt);
Z(l)=density_und(graph);
dz(i,j,k)=Z(l);
fclose(graph_txt);
delete('forestfire.txt');
end
end
end
save('dff','d');

zn(:,:)=z(2,:,:);
zf(:,:)=z(:,10,:);
zb(:,:)=z(:,:,10);
surf(f,b,zn)
figure
surf(b,n,zf)
figure
surf(f,n,zb)

nx=length(X1);
U=ones(nx,1);
M=[U X2 X3 X1];
K=M\log(Z);

for i=1:size(n,2);
for j=1:size(f,2);
for k=1:size(b,2);
z(i,j,k)=exp(K(1)+K(2)*f(j)+K(3)*b(k)+K(4)*n(i));
end
end
end

dn(:,:)=d(2,:,:);
df(:,:)=d(:,10,:);
db(:,:)=d(:,:,10);
figure
surf(f,b,dn)
figure
surf(b,n,df)
figure
surf(f,n,db)