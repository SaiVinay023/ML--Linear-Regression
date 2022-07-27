%Saivinay Manda - S4845876

function [w] = one_dim_lin_regres(turkish_dataset)


[n, c] = size(turkish_dataset); 


x = turkish_dataset(:,1); 
t = turkish_dataset(:,2); 

w = sum(x.*t) / sum(x.^2); 

end


