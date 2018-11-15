function [xb, steps] = golden(f,a,b,tol)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%(This checks the syntax of the call made)
if (nargin < 4), tol = eps; end
if (nargin < 3)
fprintf('Less than 3 input values - Golden.m needs 3 or 4'\n);
return; %stop iterating
end
%(The value of trace =1 if two outputs are called, zero otherwise)
trace=(nargout==2);
%(This sets up the intial values of p, q and their function values)
gamma=2/(1+sqrt(5));
p = b-gamma*(b-a);
q = a+gamma*(b-a);
gp = feval(f, p);
gq = feval(f, q);
n=0;
Maxit=200;
if trace, steps=[p gp q gq]; end
%(This is the main loop)
while ((b-a) > tol && n<=Maxit)
    n=n+1;
        if (gp <= gq)
            b=q;
            q=p;
            gq=gp;
            p=a+b-q;
            gp=feval(f, p);
        else
            a=p;
            p=q;
            gp=gq;
            q=a+b-p;
            gq=feval(f, q);
        end
if trace, steps=[steps; [p gp q gq]]; end
end
%(This check if the algorithm converged)
if (n <= Maxit)
xb=(a+b)/2;
fprintf('SUCESSFUL termination after %5.0f iterations\n', n);
else
fprintf('UNSUCESSFUL termination after %5.0f iterations\n',n );


end

