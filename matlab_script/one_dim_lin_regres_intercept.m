function [w_intercept] = one_dim_lin_regres_intercept(mpg, weight)
%The solution can be found by centering around the mean_x  and the mean_t

%calculate the num of observations and targets 
if (length(mpg) < length(weight)) || (length(mpg) > length(weight))
    disp('the num of observations must be equal to the num of targets!!\n'); 
end

n = length(mpg); 

%compute the means of x observations and t targets 
x_mean= (1/n)*sum(weight); 

t_mean = (1/n)*sum(mpg); 

%w_1 = sum[(xi-x_mean)(ti-t_mean)]/[sum(xi-x_mean)^2] for i =1:n 
A = 0;

C = 0;
for i = 1:n 
    A = A + (weight(i) - x_mean)*(mpg(i) - t_mean);

    C = C + (weight(i) - x_mean)^2;
end 

w_intercept.w1 = A/C; 

%w_0 = t_mean - w_1*x_mean:
w_intercept.w0 = t_mean - (w_intercept.w1*x_mean); 

end

