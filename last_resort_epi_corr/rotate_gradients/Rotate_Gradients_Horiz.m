function Rotate_Gradients_Horiz(gradientFile,TM,outname)


fid=fopen(char(TM),'rt') ;

A=fscanf(fid,'%g\n',inf);
nm=length(A);
sqnm=sqrt(nm);
A=reshape(A,sqnm,sqnm);
R=A(1:3,1:3);

fid=fopen(char(gradientFile),'rt') ;

G= fscanf(fid,'%g\n',inf);
nm =length(G)
numG=nm/3
rotGrads = zeros(numG,3);

G=textread(char(gradientFile));
size(G)

%G_V=reshape(G,3,numG)
G=G'
for i = 1:numG

vec = G(i,:);%G((i-1)*3+1:(i-1)*3+3);
vec=vec(:);

rotV=R*vec;

rotGrads(i,:) = rotV';

end
rotGrads

dlmwrite(outname,rotGrads,'delimiter',' ','precision', 12);






