function [value, grad]  = NSRFS(x)
n = length(x);
 i = (1:n-1)';
 switch nargout 
    case 1
        value =  (1/4)*(x(1)-1).^2 +sum(term(x,i).^2);
    case 2
        value =   (1/4)*(x(1)-1).^2 +sum(term(x,i).^2);
        grad = [(1/2)*(x(1) -1); zeros(n-1,1) ] -4*([x(i);0].*[term(x,i);0])+2*[0;term(x,i)];
end
    function z = term(x,j)
       z = x(j+1) - 2*x(j).^2 +1; 
    end
end
