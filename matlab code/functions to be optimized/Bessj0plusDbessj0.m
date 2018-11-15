function [y,g] = Bessj0plusDbessj0(x)
    y=bessj0(x);
    g=Dbessj0(x);
end