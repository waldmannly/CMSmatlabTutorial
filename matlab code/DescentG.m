%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DESCENT METHOD FOR NONLINEAR OPTIMIZATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  MATH2143 Optimization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%  This script file tries to minimize a given function using
%  a descent method, and a line search which produces a step 
%  size that satisfies the Armijo-Goldstein condition 
%  (condition (AG)) and the Wolfe condition (condition (W)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;         		%clear MATLAB workspace
f = 'Nf2';		%Function to be minimized

%Starting vector
n=100;			%Dimension1
x = ones(n,1); %intial point or
%x=[-1.2;1]; n=length(x); %or
%x = (3/2)*ones(n,1);

%%%%
%HOUSEKEEPING
%%%%
eps = 1e-6;		%Stopping tolerance
sigma = 0.1;    %Amijo rule parameter
mu = 0.9;        %Wolfe condition parameter 
lsearch_max =1000; %max iteration number in line search

t=1;			%Initial step size should be one for Newton like algorithms

iter_max = 500;		%Max no. of iterations allowed
iter_no = 0;		%Initialize iteration count

%Counters for the no. of evaluations of the function, gradient and Hessian
fx_no = 0;
Dfx_no = 0;
D2fx_no=0;

steps=[];	%List of output
i=(1:n);

fprintf('\n');
fprintf('MINIMIZING USING THE STEEPEST DESCENT ALGORITHM '); fprintf(f); fprintf('\n');
if (n<20) 
     fprintf('Initial point x = [');
     fprintf('%6.8f   ', x(i)');
     fprintf(']\n');
     
end
fprintf('No. of variables n = %5.0f\n',n);
fprintf('Stopping tolerance, epsilon= %5.2g\n', eps);
fprintf('----------------------------------------\n');

%Initial function & gradient values
[fx, Dfx]= feval(f,x); fx_no=fx_no+1; Dfx_no=Dfx_no+1;
%[fx, Dfx, D2fx] = feval(f,x); fx_no=fx_no+1; Dfx_no=Dfx_no+1; D2fx_no=D2fx_no+1;
residual = norm(Dfx);
steps = [steps;[x(i)'  fx]];

%%%%
%NOW FOR THE REAL WORK OF THE BEAST
%  All remaining calculations, including evaluations of the
%  function and its derivatives, occur in the following loop.
%%%%

% MAIN LOOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while ( (residual > eps*(1+abs(fx))) && (iter_no < iter_max))
    iter_no = iter_no +1;

    %Report on current iteration
    fprintf('ITERATION %5.0f: function value  = %8.4g,\n',...
            iter_no,fx);
    fprintf('               : normed residual = %6.2g,\n',...
             residual);
  
    %Descent direction
    d = -Dfx;			%steepest descent 
    %[fx, Dfx, D2fx] = feval(f,x); fx_no=fx_no+1; 
    %Dfx_no=Dfx_no+1; D2fx_no=D2fx_no+1;
    %d=-D2fx\Dfx;		%Newtons Step

    %Line search.
    %Want to use last value of t as initial value, but also
    %want initial stepsize to tend to 1, if possible:
    if (t<1) 
        t=min(t*2,1);
    else
        t=max(t/2,1);
    end

    %The line search returns NEW values of x, fx, Dfx etc.
    [x,t,fx,fx_no,Dfx,Dfx_no,lsearch_no,lsearch_success]...
    =LineSchdG(x,t,d,f,fx,fx_no,Dfx,Dfx_no,sigma,mu,lsearch_max,n);
   
    steps = [steps;[x(i)'  fx]];  %Update the matrix of intermediate values

    %Report on line search
    if (lsearch_success ~=1)
        fprintf('               :Line Search STOP.\n');
        fprintf('                Stepsize %6.2g unsatisfactory after %2.0f steps\n',t,lsearch_no);
       break; %stop iterating
    else
        fprintf('               : %2.0f line search steps, t=%6.2g\n',...
               lsearch_no,t);
        fprintf('\n');
    end

    residual = norm(Dfx,n);

end 
% of main loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Final report
fprintf('\n');
fprintf('Function value  = %8.4g,\n', fx)
fprintf('Normed residual = %6.2g,\n', residual);

if (residual < eps*(1+abs(fx))) 
    fprintf('SUCESSFUL termination after %5.0f iterations\n',...
            iter_no);
else
    fprintf('UNSUCESSFUL termination after %5.0f iterations\n',...
            iter_no);
end

if (n<30) 
     fprintf('Optimal solution x = [');
     fprintf('%6.8f   ', x(i)');
     fprintf(']\n');
     
end

fprintf('No. of function, gradient, Hessian evaluations:\n');
fprintf('    %5.0f,%5.0f,%5.0f\n',fx_no,Dfx_no,D2fx_no);

 


