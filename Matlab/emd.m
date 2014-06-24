function [x, fval] = emd(W1, W2)
% * MODIFIED FOR GRAPH HISTOGRAM COMPARISON *
% EMD   Earth Mover's Distance between two signatures
%    [X, FVAL] = EMD(F1, F2, W1, W2) is the Earth Mover's Distance
%    between two signatures S1 = {F1, W1} and S2 = {F2, W2}. F1 and F2
%    consists of feature vectors which describe S1 and S2, respectively.
%    Weights of these features are stored in W1 and W2. 
%
%    EMD is formalized as linear programming problem in which the flow that
%    minimizes an overall cost function subject to a set of constraints is
%    computed. This implementation is based on "The Earth Mover's Distance
%    as a Metric for Image Retrieval", Y. Rubner, C. Tomasi and L. Guibas,
%    International Journal of Computer Vision, 40(2), pp. 99-121, 2000.
%
%    The outcome of EMD is the flow (X) which minimizes the cost function
%    and the value (FVAL) of this flow.
%
%    This file and its content belong to Ulas Yilmaz.
%    You are welcome to use it for non-commercial purposes, such as
%    student projects, research and personal interest. However,
%    you are not allowed to use it for commercial purposes, without
%    an explicit written and signed license agreement with Ulas Yilmaz.
%    Berlin University of Technology, Germany 2006.
%    http://www.cv.tu-berlin.de/~ulas/RaRF
%

% number of feature vectors
[n,~]=size(W1);
[m,~]=size(W2);

% ground distance matrix
f=zeros(n,n);
for i = 1:n
    for j = 1:m
%         f(i,j) = norm(F1(i)-F2(j), 2);
        f(i,j) = abs(i-j)/n;
    end
end

% inequality constraints
A1 = zeros(n, n * m);
A2 = zeros(m, n * m);;
for i = 1:n
    for j = 1:m
        k = j + (i - 1) * n;
        A1(i, k) = 1;
        A2(j, k) = 1;
    end
end
A = [A1; A2];
b = [W1; W2];

% equality constraints
Aeq = ones(n+m,n*m);
beq = ones(n+m,1) * min(sum(W1), sum(W2));

% lower bound
lb = zeros(1,n*m);

% linear programming
optimoptions(@linprog,'Algorithm','simplex');
[x, fval] = linprog(f, A, b, Aeq, beq, lb);
fval = fval / sum(x);

end