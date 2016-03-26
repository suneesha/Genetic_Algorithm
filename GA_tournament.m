% GAalgorithm with tournament selection and crossoverat 4

h=input("enter the no.of hidden layers");
n=input("enter the no.of nodes");
l=h*n;
r=input("enter the range of the weights");


%Generating a random array within the range [-r,r] of length l=h*n
A = -r; B = r;
randomArray = (A-1) + (B-(A-1))*rand(1,l);
X = floor(randomArray) + 1   % array of the random weights generated

%loop for iterations
for r=1:50,
F=X.^2 %fitness function chosen

prob= (1/sum(F)) .* F %probability of the weight
statprob=sum(F)/l   %statistic probability

cum=zeros(1,l);
cum(1)=prob(1);
for i=2:l,
cum(i)=prob(i)+cum(i-1);
end

cum %contains the array of the cumilative probabilities


%implementing tournament selection

select=zeros(1,l);
tournamentsize=4; % size of the tournament
for j=1:l,


%randomly choosing the competitors
A = 1; B = l;
randomArray = (A-1) + (B-(A-1))*rand(1,tournamentsize);
tourindex= floor(randomArray) + 1;
max=0;
for i=tourindex,
if(prob(i)>max),max=prob(i);
index=i;
endif
end

select(j)=X(index);


end




select


crossoverrate=0.9;



% checking if the selected weights are fit for crossover
i=0;
for j=1:l,
if(fit(j)<=crossoverrate)
select_index(++i)=j;
endif
end

%checking if the population is even for crossover
if(mod(i,2)==0)
select_index=select_index(1:i)
else
select_index=select_index(1:i-1)
endif

%rearrange the select matrix

reselect=select(select_index)

%decimal to binary conversion
l1=length(reselect)

for u=1:l1,
	if (reselect(u)<0),
	temp(u,1:8)=[ '1' , dec2bin((-1*reselect(u)),7) ];
	else
	temp(u,1:8)=[ '0' , dec2bin(reselect(u),7) ];
	endif
end

temp



%crossover at 4 
cross=zeros(1,8);


	for v=1:2:l1-1,
	cross(v,1:8)=[temp(v,1:4), temp(v+1,5:8)];
	cross(v+1,1:8)=[temp(v+1,1:4), temp(v,5:8)];
	endfor
	
	
	
%checking the mutation rate of the population of weights
mutation=0.01;
n=ceil(0.01*l1);


A = 1; B = l1;
randomArray = (A-1) + (B-(A-1))*rand(1,n);
stringsformutation = floor(randomArray) + 1;

for i=stringsformutation,
A = 7; B = 8;
randomArray = (A-1) + (B-(A-1))*rand(1,1);
site4mut = floor(randomArray) + 1;

if (cross(i,site4mut)==48), cross(i,site4mut)=49;
else cross(i,site4mut)=48;
endif
end



for u=1:l1,
for v=1:8,
if (cross(u,v)==49) cross(u,v)=1; else cross(u,v)=0; endif
end
end

cross


% converting the crossed binary values to decimal

for u=1:l1,
e=0;
reselect(u)=0;
for v=8:-1:2,
reselect(u)=reselect(u) + 2^(e++)*cross(u,v);
end
if(cross(u,1)==1)
reselect(u)=-reselect(u);
endif
end

reselect

for j=1:l,
for i=1:l1,
if(j==select_index(i))
select(select_index(i))=reselect(i);
endif
end
end


%checking if the values are within the range
for i=1:l,
	if (select(i)>r), select(i)=r; endif
	if (select(i)<-r), select(i)=-r; endif
end

X=select


end

