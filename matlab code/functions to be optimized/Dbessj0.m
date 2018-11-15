function y =Dbessj0(x)
syms u;
Df = diff(feval(@bessj0,u));
u=x;
y=eval(Df); 
