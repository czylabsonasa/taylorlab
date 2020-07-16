b=100;
N=1000;
X=b*rand(1,N);
X=[X,3*randn(1,N)+10];
X=[X,randi(10,1,N)];


N=3*N;

ISM=1000;
mu=zeros(1,ISM);
mu2=zeros(1,ISM);
n=zeros(1,ISM);

K=10;
for ism=1:ISM
  k=randi(K); m=randi(k);
  ind=(randi(k,1,N)<=m);
  XX=X(ind);
  mu(ism)=log(mean(XX));
  mu2(ism)=log(mean(XX.*XX));
  n(ism)=sum(ind)/N;
end
subplot(3,1,1)
plot(mu, mu2,'*')
subplot(3,1,2)
plot(n,mu,'*')
subplot(3,1,3)
plot(n,mu2,'*')
