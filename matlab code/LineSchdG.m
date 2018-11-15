%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% LINESEARCH ROUTINE FOR NONLINEAR OPTIMIZATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Line search routine to approx. solve: min{f(x+td) : t >=0}.
%Uses Armijo-Goldstein and Wolfe conditions to
%determine a suitable step size t.
%
%Input     x = starting vector (n-dimensional)
%          t = initial step size (real)
%          d = direction (n-dim)
%          f = function of x
%          fx = function value at  x
%          fx_no = number of function evaluate up-to-date
%          Df = gradient of f
%          Dfx = gradient at x
%          Dfx_no = gradient evaluation up-to-date
%          sigma  		%linesearch parameter for Armijo-Goldstein
%          mu 		%linesearch parameter for Wolfe
%          lsearch_max  	%max no. of line search steps allowed before giving up
%          n = dimension of x
%
%Output    x = final value (initial x + td for final t)
%          t = final step size
%          fx = final function value (<= initial value)
%          fx_no = number of function evaluate up-to-date
%          Dfx = final gradient vector
%          Dfx_no = gradient evaluation up-to-date
%          lsearch_no = no. of steps needed by line search
%          lsearch_success = 1 if the routine was successful
%                            0 otherwise (eg too many steps used)


function     [x,t,fx,fx_no,Dfx,Dfx_no,lsearch_no,lsearch_success] = ...
    LineSchdG(x,t,d,f,fx,fx_no,Df,Dfx,Dfx_no,sigma,mu,lsearch_max,n)



t_hi=inf; t_lo=0;	%for "bracketing" step size

do_lsearch = 1; 	%"true"
lsearch_no = 0;		%no. of line search steps attempted

%Initial Values
tol = 10^(-6);
a=0;
b=t;
gamma=2/(1+sqrt(5));
p = b-gamma*(b-a);
q = a+gamma*(b-a);
gp = feval(f, x + p*d);
gq = feval(f, x + q*d);
fx_no = fx_no + 2;
lsearch_no = 0;
lsearch_max = 1000; %max no. of line search steps allowed



g = Dfx'*d;
if (g > 0)
    disp('linesearch WARNING: <grad,d> > 0, using -grad instead');
    d= -Dfx;  g = -Dfx'*Dfx;
end

% Start of Main Loop
while ((b-a) > tol && lsearch_no <=lsearch_max )
    
    lsearch_no = lsearch_no +1;
    if (gp <= gq)
        b=q;
        q=p;
        gq=gp;
        p=a+b-q;
        gp=feval(f, x + p*d);
        fx_no = fx_no +1;
    else
        a=p;
        p=q;
        gp=gq;
        q=a+b-p;
        gq=feval(f, x + q*d);
        fx_no = fx_no +1;
    end
    
    
end%linesearch
%end main loop
if (lsearch_no <= lsearch_max)
    t=(a+b)/2;
    lsearch_success = 1;
else
    t=(a+b)/2;
    lsearch_success = 0;
end
%update point, function value, gradient
x = x + t*d;
[fx, Dfx ] = feval(f, x + t*d);
fx_no = fx_no +1;
Dfx_no = Dfx_no + 1;



