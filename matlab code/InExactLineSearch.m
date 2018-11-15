function [t,lsearch_no,lsearch_success] =...
InExactLineSearch(f,sigma,mu,lsearch_max)
%Line search routine to approx. solve: min{f(t) : t >=0}.
%Uses Armijo-Goldstein and Wolfe conditions to
%determine a suitable step size t.
%(This checks the syntax of the call made)
if (nargin < 4), lsearch_max=30; end
if (nargin < 2), sigma=0.1, mu = 0.9; end

%(Initalize the low and high values of t and loop parameters)
t_hi=inf; t_lo=0; %for ”bracketing” step size
t_0 = 0; %Intial value of t
do_lsearch = 1; %”true” then we keep iterating
lsearch_no = 0; %no. of line search steps attempted
[ft, g] = feval(f, 0);
t = norm(g)^2; %intial step size
if (g > 0)
disp('linesearch WARNING: grad > 0, using -grad instead');
g = -g;
end
%(Start of the mail loop)
while (do_lsearch && (lsearch_no < lsearch_max))
lsearch_no = lsearch_no +1;
t_new = t_0 + t;
[ft_new, Dft_new] = feval(f,t_new);
if (ft_new > ft + sigma*t*g) %Armijo-Goldstein fails
t_hi = t;
t = (t_lo + t)/2;
%t lo unchanged
else
g_new = Dft_new;
if (g_new < mu*g) %Wolfe fails
    t_lo = t;
if (t_hi < inf)
t = (t+t_hi)/2;
else
t= 2*t;
end
%t hi unchanged
else %Armijo-Goldstein & Wolfe hold
do_lsearch = 0;
end %end Wolfe
end %end Armijo-Goldstein
end %end linesearch
%if linesearch fails, but not because of infinite descent:
if ((do_lsearch ~=0) && t_hi < inf)
lsearch_success = 0;
else
lsearch_success=1;
end
%update point, function value, gradient
t=t_new; ft = ft_new; g = Dft_new;
end
    