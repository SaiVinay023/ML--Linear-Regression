
---

# Linear Regression Project

**Course:** Machine Learning  
**Institution:** Università degli Studi di Genova  
**Student:** Sai Vinay Manda  
**Student ID:** S4845876  
**Date:** 07/07/2022

## Abstract
This project implements three different linear regression models in MATLAB to analyze datasets and calculate their mean square error. The results are evaluated using two distinct datasets: the Motor Trend Car Road Tests and the Turkish stock exchange data.

## Project Structure
```
LinearRegression/
├── 4.fig
├── LinearRegression.m
├── MSE.m
├── linear_regression_intercept.m
├── mtcarsdata-4features.csv
├── multi_dim_lin_regres.m
├── one_dim_lin_regres.m
├── one_dim_lin_regres_intercept.m
└── turkish-se-SP500vsMSCI.csv
```

## File Descriptions

1. **4.fig**
   - **Description:** MATLAB figure file containing visual representations of the linear regression results.
   - **Usage:** Load in MATLAB to view graphical outputs of the regression analysis.

2. **LinearRegression.m**
   - **Description:** Main script to execute the linear regression analysis.
   - **Implementation:**
     - Loads the Turkish stock exchange dataset and the car dataset.
     - Calls regression functions to compute and visualize results.
   - **Key Code Snippet:**
     ```matlab
     % Load datasets
     turkishData = load('turkish-se-SP500vsMSCI.csv');
     carData = readtable('mtcarsdata-4features.csv');

     % Call regression functions
     [w1] = oneDimLinReg(turkishData(:,1), turkishData(:,2));
     ```

3. **MSE.m**
   - **Description:** Computes the mean square error for the regression models.
   - **Implementation:**
     - Takes model predictions and actual target values as inputs.
     - Computes and returns the mean square error.
   - **Key Code Snippet:**
     ```matlab
     function objective = meanSquareError(x, t, w1, w0, problem)
         if problem == 1
             objective = (1/length(x)) * sum((t - (w1*x)).^2);
         else
             % Multi-dimensional MSE
             objective = immse(t, X*w);
         end
     end
     ```

4. **linear_regression_intercept.m**
   - **Description:** Computes the linear regression weights, including intercept for 1D data.
   - **Implementation:**
     - Calculates the slope and intercept based on the input data.
   - **Key Code Snippet:**
     ```matlab
     function [w1, w0] = oneDimLinRegIntercept(x, t)
         w1 = sum((x - mean(x)) .* (t - mean(t))) / sum((x - mean(x)).^2);
         w0 = mean(t) - w1 * mean(x);
     end
     ```

5. **mtcarsdata-4features.csv**
   - **Description:** Dataset containing various car attributes used for linear regression analysis.
   - **Usage:** This dataset includes attributes such as weight and miles per gallon (MPG).

6. **multi_dim_lin_regres.m**
   - **Description:** Implements multi-dimensional linear regression.
   - **Implementation:**
     - Computes weights using the normal equation for multi-dimensional data.
   - **Key Code Snippet:**
     ```matlab
     function W = multiDimLinReg(X, t)
         W = (X' * X) \ (X' * t);
     end
     ```

7. **one_dim_lin_regres.m**
   - **Description:** Computes weights for 1D linear regression without intercept.
   - **Implementation:**
     - Calculates the slope based on input data.
   - **Key Code Snippet:**
     ```matlab
     function w = oneDimLinReg(x, t)
         w = sum(x .* t) / sum(x.^2);
     end
     ```

8. **one_dim_lin_regres_intercept.m**
   - **Description:** Similar to `linear_regression_intercept.m`, this computes slope and intercept for 1D linear regression.
   - **Key Code Snippet:**
     ```matlab
     function [w1, w0] = oneDimLinRegIntercept(x, t)
         % Similar implementation as in linear_regression_intercept.m
     end
     ```

9. **turkish-se-SP500vsMSCI.csv**
   - **Description:** Dataset from the Turkish stock exchange, used for analysis in the project.
   - **Usage:** Contains historical stock prices, utilized to model stock performance.

## Implementation Details

### Linear Regression Algorithm Overview
Linear regression aims to model the relationship between a dependent variable \( t \) (target) and independent variable(s) \( X \) (data) using a linear equation:

\[ y = wX \]

Where \( w \) is the vector of weights. The objective function \( J \) is minimized to find the optimal weights:

\[ J = \frac{1}{N} \sum_{i=1}^{N} (t_i - y_i)^2 \]

### Tasks Overview

- **Task 1 & 2:** Load datasets and compute linear regression models.
- **Task 3:** Split datasets into training and test sets, re-compute models, and evaluate using the mean square error.

### Usage Instructions
1. **Clone or Download:** Clone or download the repository to your local machine.
2. **Open MATLAB:** Start MATLAB and navigate to the project directory.
3. **Run Main Script:** Execute `LinearRegression.m` to perform the analysis and view the results.

## References
- GeeksforGeeks: [Linear Regression Python Implementation](https://www.geeksforgeeks.org/linear-regression-python-implementation/)
- Wikipedia: [Linear Regression](https://en.wikipedia.org/wiki/Linear_regression)

---

