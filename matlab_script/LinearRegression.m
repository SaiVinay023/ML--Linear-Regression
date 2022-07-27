%% Saivinay Manda - S4845876/ Lab2

clear all; 
close all; 
clc; 


%First we need to get Data for Turkish_dataset and mtcarsdata
%% Task 1 : Get data 

turkish_dataset = load('turkish-se-SP500vsMSCI.csv');

mtcarsdata = readtable('mtcarsdata-4features.csv'); 
mtcars_dataset.model = mtcarsdata{:,1}; 
mtcars_dataset.data = mtcarsdata{:,2:end}; 

%% Task 2 : One-dimensional problem without intercept on the Turkish stock exchange data 
% linear model without intercept : y=wx
%The least squares method is applied,the solution is : w = som(xi*ti)/som(xi^2) for i=1:n

[w.turkishdataset] = one_dim_lin_regres(turkish_dataset);
fprintf('The least squares solution of the Turkish dataset is %d\n', w.turkishdataset); 

%plot data for the usage
y1=w.turkishdataset*turkish_dataset(:,1);
figure; 
hold on; 
grid on; 
plot(turkish_dataset(:,1), turkish_dataset(:,2), 'bx');
plot(turkish_dataset(:,1),y1, 'red', 'Linewidth', 1); 
title('Least squares solution on the Turkish Dataset'); 
xlabel('x Observation'); 
ylabel('t Target'); 


%% Task 2_b : Compare graphically the solution obtained on different random subsets (10%) of the whole data set
figure; 
for i = 1:10
    [numTur.rows, numTur.columns] = size(turkish_dataset); 
    Indexes_rand = randperm(numTur.rows); 
    
    %using 10% of the dataset for the subset 
    
    numelements= round(0.1*numTur.rows); 
    
    %new subset
    
    Indexes_subset = Indexes_rand(1:numelements); 
    turkish_subset = turkish_dataset(Indexes_subset,:);

    %least squares solution of the subset 
    [w.turkishsubset] = one_dim_lin_regres(turkish_subset); 

 

    %plot data 
    y2=w.turkishsubset*turkish_subset(:,1);
 
    hold on; 
    grid on; 
    plot(turkish_dataset(:,1), turkish_dataset(:,2), 'bx');
    plot(turkish_dataset(:,1),y1, 'green', 'Linewidth', 1); 
    plot(turkish_subset(:,1), y2,'red', 'Linewidth', 1); 
    title('Least squares solutions on the Turkish Subsets and Turkish Dataset'); 
    xlabel('x Obseration'); 
    ylabel('t Target'); 
    legend('forecasting','w of dataset', 'w of subset'); 
end
hold off


%% Task 2_c : One-dimensional problem with intercept on the Motor Trends car data, using columns mpg and weight
%we have to switch from linear to affine model 
% linear model wit intercept : y=w_1*x + w_0
%The solution in this case can be found by centering around the mean_x  and the mean_t
%forecasting mpg with weight st observations are weight data and targets are mpg data

mpg = mtcars_dataset.data(:,1); 
weight = mtcars_dataset.data(:,4); 

[w_intercept] = one_dim_lin_regres_intercept(mpg, weight);

fprintf('In the linear regression with offset we obtain:\n slope = %d,\n intercept = %d\n', w_intercept.w1, w_intercept.w0); 

%plot data 
y3 = (weight * w_intercept.w1) + w_intercept.w0; 
figure; 
hold on; 
grid on; 
plot(weight,mpg, 'bx');
plot(weight, y3, 'red', 'Linewidth', 1); 
title('The last square solution of model with offset on mtcar dataset'); 
xlabel('x Observation'); 
ylabel('t Target'); 
%% Task 2_d : Multi-dimensional problem on the complete MTcars data, using all four columns (predict mpg with the other three columns)

%preparing the data 
disp = mtcars_dataset.data(:,2); 
hp =  mtcars_dataset.data(:,3); 

%multi-dimensional observations 
Xmatrix = [disp hp weight]; 


[W_multi] = multi_dim_lin_regres(mpg, Xmatrix); 

fprintf('The least squares solution in the multidimensional dataset is :\n');

for i = 1:length(W_multi)
    fprintf('%d\n', W_multi(i));
end

[y4] = Xmatrix * W_multi; 

MultidimResults = table(mpg, y4);
MultidimResults.Properties.VariableNames = {'Real Target t' 'Predicted Target y'};


figure
uitable('Data',MultidimResults{:,:},'ColumnName', MultidimResults.Properties.VariableNames,...
    'Units', 'Normalized', 'Position',[0, 0, 1, 1]);

%% Task 3_a : Re-run 1,3 and 4 from task 2 using only 5% of the data.

%select the 5% of the Turkish dataset 


numelements_5perc= round(0.05*numTur.rows); 

%define new subset with 5 perc of data 

Indexes_subset_5perc = Indexes_rand(1:numelements_5perc); 
turkish_subset_5perc = turkish_dataset(Indexes_subset_5perc,:);

%define new subset with 95 perc of data 

Indexes_subset_95perc = Indexes_rand(1:(numTur.rows-numelements_5perc)); 
turkish_subset_95perc = turkish_dataset(Indexes_subset_95perc,:);



%select the 5% of the mtcars dataset 

[numMtcars.rows, numMtcars.columns] = size(mtcars_dataset.data); 

%set dataset in a random way

IndexesMtcars_rand = randperm(numMtcars.rows); 

%select the 5% of the Mtcars dataset 

numelements_Mtcars_5perc= round(0.05*numMtcars.rows); 

%define new subset with 5perc of data 

IndexesMtcars_subset_5perc = IndexesMtcars_rand(1:numelements_Mtcars_5perc); 
Mtcars_subset_5perc = mtcars_dataset.data(IndexesMtcars_subset_5perc,:);

%define new subset with 95perc of data 

IndexesMtcars_subset_95perc = IndexesMtcars_rand(1:(numMtcars.rows - numelements_Mtcars_5perc)); 
Mtcars_subset_95perc = mtcars_dataset.data(IndexesMtcars_subset_95perc,:);

[w_subset5perc] = one_dim_lin_regres(turkish_subset_5perc); 
fprintf('The least squares solution of the Turkish subset with 5percent of data is %d\n', w_subset5perc); 

[w_intercept_subset5perc] = one_dim_lin_regres_intercept(Mtcars_subset_5perc(:,1),Mtcars_subset_5perc(:,4));
fprintf('In the linear regression with offset using 5percent of data we obtain:\n slope = %d,\n intercept = %d\n', w_intercept_subset5perc.w1, w_intercept_subset5perc.w0); 

[W_multi_subset5perc] = multi_dim_lin_regres(Mtcars_subset_5perc(:,1),Mtcars_subset_5perc(:,2:end)); 
fprintf('The least squares solution in the multidimensional subset with 5percent of data is :\n');

for i = 1:length(W_multi_subset5perc)
    fprintf('%d\n', W_multi_subset5perc(i));
end

%% Task 3_b : Compute the objective (mean square error) on the training data (5perc) 

%first case: one dimensional linear regress problem on training data

targets_training.one_lin = turkish_subset_5perc(:,2);
observations_training.one_lin = turkish_subset_5perc(:,1); 

[objective_training.one_lin] = MSE(targets_training.one_lin, observations_training.one_lin, w_subset5perc, 1, 1); 

%second case: one dimensional linear regress problem with offset on training data

targets_training.one_lin_offset = Mtcars_subset_5perc(:,1);
observations_training.one_lin_offset = Mtcars_subset_5perc(:,4);

[objective_training.one_lin_offset] = MSE(targets_training.one_lin_offset, observations_training.one_lin_offset, w_intercept_subset5perc.w1,w_intercept_subset5perc.w0, 2);


%third case: multidimensional linear regress problem on training data 

targets_training.multi_lin_offset = Mtcars_subset_5perc(:,1);
observations_training.multi_lin_offset = Mtcars_subset_5perc(:,2:end);

[objective_training.multi_lin_offset] = MSE(targets_training.multi_lin_offset, observations_training.multi_lin_offset,W_multi_subset5perc,1,3);

%% Task 3_c : (mean square error) 
% of the same model on the test data (95perc) 


%first case: one dimensional linear regress problem on test data

targets_test.one_lin = turkish_subset_95perc(:,2);
observations_test.one_lin = turkish_subset_95perc(:,1); 


[objective_test.one_lin] = MSE(targets_test.one_lin, observations_test.one_lin, w_subset5perc, 1, 1); 

%second case: one dimensional linear regress problem with offset on training data 
targets_test.one_lin_offset = Mtcars_subset_95perc(:,1);
observations_test.one_lin_offset = Mtcars_subset_95perc(:,4);


[objective_test.one_lin_offset] = MSE(targets_test.one_lin_offset, observations_test.one_lin_offset, w_intercept_subset5perc.w1,w_intercept_subset5perc.w0, 2);


%third case: multidimensional linear regress problem on training data 
targets_test.multi_lin_offset = Mtcars_subset_95perc(:,1);
observations_test.multi_lin_offset = Mtcars_subset_95perc(:,2:end);


[objective_test.multi_lin_offset] = MSE(targets_test.multi_lin_offset, observations_test.multi_lin_offset,W_multi_subset5perc,1,3);


%% Task 3_d : Repeat for different training-test random splits, for instance 10 times. 

for k = 1:10
    %compute random subset for training and test 
    indexesrandom.subset1_5perc= randperm(numTur.rows); 
    indexesrandom.subset2_5perc = randperm(numMtcars.rows); 
    randomSubset1.training = turkish_dataset(indexesrandom.subset1_5perc(1:numelements_5perc), :); % Subset made of 5% of the data - Training Data
    randomSubset2.training = mtcars_dataset.data(indexesrandom.subset2_5perc(1:numelements_Mtcars_5perc), :);
    randomSubset1.test = turkish_dataset(indexesrandom.subset1_5perc(numelements_5perc+1:end), :); %Subset made of the remaining 95% of the data - Test Data
    randomSubset2.test = mtcars_dataset.data(indexesrandom.subset2_5perc(numelements_Mtcars_5perc+1:end), :);
    
    %compute the slopes
    [W_subset5perc] = one_dim_lin_regres(randomSubset1.training); 
    [W_intercept_subset5perc] = one_dim_lin_regres_intercept(randomSubset2.training(:,1),randomSubset2.training(:,4));
    [w_multi_subset5perc] = multi_dim_lin_regres(randomSubset2.training(:,1),randomSubset2.training(:,2:end)); 
    
    % Computing the objective on the Training Data
    objective1.training(k) = MSE(randomSubset1.training(:,2),randomSubset1.training(:,1),W_subset5perc, 1,1);
    objective2.training(k) = MSE(randomSubset2.training(:,1), randomSubset2.training(:,4),W_intercept_subset5perc.w1, W_intercept_subset5perc.w0, 2 );
    objective3.training(k) = MSE(randomSubset2.training(:,1),randomSubset2.training(:,2:end),w_multi_subset5perc,1,3 );
    
    
    %computing the objectiove of the same models on the Test Data 
    objective1.test(k) = MSE(randomSubset1.test(:,2),randomSubset1.test(:,1),W_subset5perc, 0,1);
    objective2.test(k) = MSE(randomSubset2.test(:,1), randomSubset2.test(:,4), W_intercept_subset5perc.w1, W_intercept_subset5perc.w0, 2 );
    objective3.test(k) = MSE(randomSubset2.test(:,1),randomSubset2.test(:,2:end),w_multi_subset5perc,0, 3 );
    
    
end
    
average_obj.training(1) = sum(objective1.training)/10;
average_obj.training(2) = sum(objective2.training)/10;
average_obj.training(3) = sum(objective3.training)/10;
average_obj.test(1) = sum(objective1.test)/10;
average_obj.test(2) = sum(objective2.test)/10;
average_obj.test(3) = sum(objective3.test)/10;


TT = table(average_obj.training', average_obj.test');
TT.Properties.VariableNames = {'Training' 'Test'};
TT.Properties.RowNames = {'Model 1' 'Model 2' 'Model 3'};

figure
uitable('Data',TT{:,:},'ColumnName',TT.Properties.VariableNames,...
    'RowName',TT.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
