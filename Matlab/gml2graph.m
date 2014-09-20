function S=gml2sparse(inputfile)
A=[];l=0;k=1;
while 1
      % Get a line from the input file
      tline = fgetl(inputfile);
      % Quit if end of file
      if ~ischar(tline)
          break
      end
      nums = regexp(tline,'\d+','match');
      if length(nums)
          if l==1
              l=0;
              A(k,2)=str2num(nums{1});  
              k=k+1;
              continue;
          end
          A(k,1)=str2num(nums{1});
          l=1;
      else
          l=0;
          continue;
      end
end
A=A+1;
graph=zeros(max(max(A)));
for i=1:size(A,1)
    graph(A(:,1),A(:,2))=1;
    graph(A(:,2),A(:,1))=1;
end
fclose(inputfile);
end