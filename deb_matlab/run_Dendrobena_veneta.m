close all; 

addpath(genpath("/home/domagoj/GitHub/DEBtool_m"))
addpath(genpath("/home/domagoj/GitHub/AmPtool"))
addpath(genpath("/home/domagoj/data/AmPdata"))

global pets 

pets = {'Dendrobena_veneta'};
check_my_pet(pets); 

estim_options('default'); 
estim_options('max_step_number', 5e2); 
estim_options('max_fun_evals', 5e3); 

estim_options('pars_init_method', 2); 
estim_options('results_output', 3); 
estim_options('method', 'nm'); 

estim_pars; 
