function [value, grad, hess]  = Nf1(x)
n = length(x);
if n ~= 2 
    fprintf('Error: The variable x must be of lenght 2\n')
    return
end
switch nargout 
    case 1
        value = x(1)*x(1)+ x(2)*x(2)/4;
    case 2
        value = x(1)*x(1)+ x(2)*x(2)/4;
        grad = [2*x(1); x(2)/2];
    case 3
        value = x(1)*x(1)+ x(2)*x(2)/4;
        grad = [2*x(1); x(2)/2];
        hess = [2 0; 0 1/2];
end
end
