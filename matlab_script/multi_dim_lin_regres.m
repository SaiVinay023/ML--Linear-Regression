%Saivinay Manda - S4845876

function [W_multi] = multi_dim_lin_regres(mpg, Xmatrix)

%Here we are going to analyze observability Matrix 


[dim.rows, dim.columns] = size(Xmatrix); 
if dim.rows == dim.columns 
    disp('X is a square matrix'); 
    D = det(Xmatrix);
    if D~=0 %If its a non singular matrix, then only 1 solution 
        disp('X is invertible'); 
        
        W_multi = inv_svd(Xmatrix)*mpg; 
        
        else 
            disp('X is a singular matrix');
        
            W_multi = pinv(Xmatrix)*mpg;%%pinv(Xmatrix) This function defines the pseudoinverse
    
    end
    
%Defining normal equations for least square problem

else if dim.rows > dim.columns 
        disp('X is tall matrix'); 
        
         
        W_multi = pinv(Xmatrix)*mpg; %left pseudoinverse 
    
    else  %dim.rows < dim.columns 
        disp('X is flat matrix'); 
        
        %closed-form solution
        
        W_multi = (Xmatrix'*inv_svd(Xmatrix*Xmatrix'))*mpg;%%[Xmatrix'*inv_svd(Xmatrix*Xmatrix')] = right pseudoinverse
    end
end

end
 
 function res = inv_svd(A) 
        [U,S,V] = svd(A);
        res = transpose(V)*pinv(S)*U;
 end

        
