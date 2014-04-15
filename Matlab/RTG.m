function RTG(W, k, beta, q, isBipartite, dirName, isSelfLoop, numTimeTicks)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Leman Akoglu
% Date: October 20, 2009
% email to lakoglu@cs.cmu.edu for questions
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
% This code generates source-destination pairs as well as timestamps
% that generates a realistic, time-evolving graph.
% 
%  Output format:   time   source_label   destination_label
% 
%--------------------------------------------------------------------------
% Parameters:
% W: size of the graph (number of multi-edges generated)
% k: number of keys in the 1D keyboard. --> (k+1)^2 keys in the 2D keyboard
%    including the "S"pace character
% beta: the imbalance factor to provide homophily and 
%       ensure community structure
% q: probability of hitting the "S"pace key
%
%
% -------------------------------------------------------------------------
% auxiliary params:
% isBipartite: 1 if a bipartite graph is wanted
% dirName: name of the directory where the edgefile will be written
%          file name will be in the form of:
%          edgefile_',num2str(W),'_',num2str(k),'_',num2str(beta),'_',num2s
%          tr(q),'.txt'
% isSelfLoop: 0 if no self-loops are wanted
%             note: due to boosting of diagonal keys, many self-loops 
%             will be generated.
% numTimeTicks: number of time ticks the graph should evolve over
%--------------------------------------------------------------------------
%Note: Remaining probability (1-q) is distributed unevenly
%      to the rest of the keys which smoothes the power-law fit.
%
%--------------------------------------------------------------------------
%%Reference:
%   Leman Akoglu, Christos Faloutsos. RTG: A Recursive Realistic Graph
%   Generator using Random Typing. ECML PKDD, Bled, Slovenia, Sep. 2009.
%
% Please cite the above paper if you use the code for your own research.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(k>26)
   disp 'Number of keys cannot be greater than 26'; 
   % one can add more characters but usually a small number of keys 3-7
   % would be enough
   return;
end

chars = {'a' ,'b', 'c', 'd', 'e', 'f' ,'g', 'h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
chars2 = {'A' ,'B', 'C', 'D', 'E', 'F' ,'G', 'H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% call burst to assign time labels
Wt = burst(W, numTimeTicks);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = zeros(k,1);
% assign "unequal" probabilities to keys - randomly
prem = 1-q; % remaining prob
for i=1:k-1
    r = rand * prem;
    p(i) = r;
    prem = prem-r;
end
p(k) = prem;

% create the probability matrix -- 2D keyboard
pmat = zeros(k+1, k+1);
for i=1:k
   pmat(i,k+1) = p(i)*q*beta; 
   pmat(k+1,i) = pmat(i,k+1);  
end
pmat(k+1,k+1) = q - sum(pmat(k+1,:));

for i=1:k
    for j=1:k
        if(i~=j)
            pmat(i,j) = p(i)*p(j)*beta;
        end
    end
end
for i=1:k
   pmat(i,i) = p(i) - sum(pmat(i,:));
end

pmat

disp(strcat('Output filename:  ',dirName,'edgefile_',num2str(W),'_',num2str(k),'_',num2str(beta),'_',num2str(q),'.txt'))
fid = fopen( strcat(dirName,'edgefile_',num2str(W),'_',num2str(k),'_',num2str(beta),'_',num2str(q),'.txt'), 'w');

% initialize src and dst
numpairs = 0;
numselfloops = 0;
tind = 1;
while(numpairs~=W)
    s = '';
    d = '';
    src = 0;
    dst = 0;
    r = rand();
    putchar(r);  

    while(~(src==1 && dst==1))
        r = rand();
        putchar(r);
    end
    s = s(1:find(s=='#'));
    if(isBipartite)
        d = d(1:find(d=='$'));
    else
        d = d(1:find(d=='#'));
    end

    numpairs = numpairs+1; 
    if(length(s)==length(d))
        if(s==d)
            numselfloops=numselfloops+1;
            if(~isSelfLoop)
                numpairs = numpairs-1; 
                continue;
            end
        end
    end
      
    fprintf(fid,'%d %s %s\n', tind, s, d);
    if(numpairs >= Wt(tind))
        tind=tind+1;
    end
end
fclose(fid);

%sprintf('Number of self-loops generated: %s', num2str(numselfloops))




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find the key that is pressed and appends characters to the 
% existing labels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function putchar(r)
        prob = 0;
        for i1=1:k
            for i2=1:k
                prob = prob+pmat(i1,i2);
                if(r<=prob)
                    s = strcat(s, chars{i1});
                    if(isBipartite)
                        d = strcat(d, chars2{i2});
                    else
                        d = strcat(d, chars{i2});
                    end
                    return;
                end
            end
        end
        
                
        for i3=1:k
            prob = prob + pmat(i3,k+1); 
            if(r<=prob)
                s = strcat(s, chars{i3});
                dst=1; % terminate dst label
                if(isBipartite)
                    d = strcat(d, '$');
                else
                    d = strcat(d, '#');
                end
                return;
            end
            prob = prob + pmat(k+1,i3); 
            if(r<=prob)
                if(isBipartite)
                    d = strcat(d, chars2{i3});
                else
                    d = strcat(d, chars{i3});
                end
                src=1;
                s = strcat(s, '#'); % terminate src label
                return;
            end
        end
        % reaches here only if S-S key is pressed
        % terminate both labels
        s = strcat(s, '#');
        if(isBipartite)
            d = strcat(d, '$');
        else
            d = strcat(d, '#');
        end
        src=1;
        dst=1;
        return;
        
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     function Wt = burst(W,len)

        res=100; % max possible resolution
        f = [.2 .8];

        % slope = -0.2*log2(.2)-0.8*log2(.8) = 0.7219
        % change the f vector for a different slope
        % uneven: bursty   more even: smoother

        a = W;
        for ind=1:res
            c = [];
            done=0;
            for jind=1:length(a)
                b= ceil(a(jind) * f);
                if(ind>3)
                    b = b(randperm(length(b)));
                end
                c = [c b];

                if(length(c)+length(a)-jind == len)
                    a = [c a(jind+1:length(a))];
                    done=1;
                    break;
                end
            end

            if(min(c) < 1)
                %i
                break;
            end
            if(done), break; end

            a = c;
        end

       Wt = cumsum(a);
    
    end

end