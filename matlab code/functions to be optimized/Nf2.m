function [value grad Hess] =  Nf2(x);
   n=length(x);
   i = (1:n)';
   switch nargout 
    case 1
        value = sum(exp(x).*i) + 5*(ones(1,n)*x)^2;
    case 2
        value = sum(exp(x).*i) + 5*(ones(1,n)*x)^2;
        grad = exp(x(i)).*i  + 10*ones(n,1)*(ones(1,n)*x(i));
    case 3
        value = sum(exp(x).*i) + 5*(ones(1,n)*x)^2;
        grad = exp(x(i)).*i  + 10*ones(n,1)*(ones(1,n)*x(i));
        Hess = diag(exp(x).*i) + 12*ones(n,n);
   end
end

   

