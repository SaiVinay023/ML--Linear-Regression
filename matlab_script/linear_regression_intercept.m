%S4845876 - Saivinay Manda

function [x2,t2,y2,w2,w0] =  linear_regression_intercept(test)
    x2 = test(:,1); % first column
   
    [n2,p2] = size(x2);
    
    t2 = test(:,2); % second column
    
    [m2,d2] = size(t2);
        
    x_segn = (1/n2)*(sum(x2));
    t_segn = (1/m2)*(sum(t2));
    num = 0;
    den = 0;
    
    for i=1:n2
        
        num = num + sum((x2(i)-x_segn)*(t2(i)-t_segn));
        den = den + sum((x2(i)-x_segn)^2);
    end
        
w2 = num/den;
w0 = t_segn - (w2*x_segn);
y2 = w0 + (x2*w2); % y is the linear regression line
end