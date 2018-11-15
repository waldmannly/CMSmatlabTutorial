function [value, grad, hess]  = Nf3(x)
n = length(x);
if n ~= 2 
    fprintf('Error: The variable x must be of lenght 2\n')
    return
end
switch nargout 
    case 1
        value = (1-x(1))^2 + 7/2*(x(2) - x(1)^2)^2;
    case 2
        value = (1-x(1))^2 + 7/2*(x(2) - x(1)^2)^2;
        grad = [ 2*x(1) - 2 - 14*x(1)*x(2) + 4*x(1)^3 ; 7*x(2)-2*x(1)^2];
    case 3
        value = (1-x(1))^2 + 7/2*(x(2) - x(1)^2)^2;
        grad = [ 2*x(1) - 2 - 14*x(1)*x(2) + 4*x(1)^3 ; 7*x(2)-2*x(1)^2];
        hess = [2-14*x(2) +12*x(1)^2 14*x(1); 14*x(1) 7];
end
end
