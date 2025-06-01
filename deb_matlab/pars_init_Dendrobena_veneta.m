function [par, metaPar, txtPar] = pars_init_Dendrobena_veneta(metaData)

metaPar.model = 'std'; 

%% reference parameter (not to be changed) 
par.T_ref = 293.15;   free.T_ref = 0;   units.T_ref = 'K';        label.T_ref = 'Reference temperature'; 

%% core primary parameters 
par.z = 0.3431;       free.z     = 1;   units.z = '-';            label.z = 'zoom factor'; 
par.F_m = 6.5;        free.F_m   = 0;   units.F_m = 'l/d.cm^2';   label.F_m = '{F_m}, max spec searching rate'; 
par.kap_X = 0.8;      free.kap_X = 0;   units.kap_X = '-';        label.kap_X = 'digestion efficiency of food to reserve'; 
par.kap_P = 0.1;      free.kap_P = 0;   units.kap_P = '-';        label.kap_P = 'faecation efficiency of food to faeces'; 
par.v = 0.01477;      free.v     = 1;   units.v = 'cm/d';         label.v = 'energy conductance'; 
par.kap = 0.5756;     free.kap   = 1;   units.kap = '-';          label.kap = 'allocation fraction to soma'; 
par.kap_R = 0.475;    free.kap_R = 0;   units.kap_R = '-';        label.kap_R = 'reproduction efficiency'; 
par.p_M = 4740.8319;  free.p_M   = 1;   units.p_M = 'J/d.cm^3';   label.p_M = '[p_M], vol-spec somatic maint'; 
par.p_T = 0;          free.p_T   = 0;   units.p_T = 'J/d.cm^2';   label.p_T = '{p_T}, surf-spec somatic maint'; 
par.k_J = 0.002;      free.k_J   = 0;   units.k_J = '1/d';        label.k_J = 'maturity maint rate coefficient'; 
par.E_G = 4181.7688;  free.E_G   = 1;   units.E_G = 'J/cm^3';     label.E_G = '[E_G], spec cost for structure'; 
par.E_Hb = 5.229e+00; free.E_Hb  = 1;   units.E_Hb = 'J';         label.E_Hb = 'maturity at birth'; 
par.E_Hp = 1.055e+03; free.E_Hp  = 1;   units.E_Hp = 'J';         label.E_Hp = 'maturity at puberty'; 
par.h_a = 1.629e-08;  free.h_a   = 1;   units.h_a = '1/d^2';      label.h_a = 'Weibull aging acceleration'; 
par.s_G = 0.0001;     free.s_G   = 0;   units.s_G = '-';          label.s_G = 'Gompertz stress coefficient'; 

%% other parameters 
par.T_A = 8000;         free.T_A   = 1;     units.T_A = 'K';      label.T_A = 'Arrhenius temperature'; 
par.del_M = 0.050632;   free.del_M = 1;     units.del_M = '-';    label.del_M = 'shape coefficient'; 
par.f = 1;              free.f     = 0;     units.f = '-';        label.f = 'scaled functional response for 0-var data'; 
par.f_Kova = 1;         free.f_Kova  = 1;   units.f_Kova = '-';   label.f_Kova = 'f for Kovacevic et al. 2023'; 
par.f_Vilj = 1;         free.f_Vilj = 1;    units.f_Vilj = '-';   label.f_Vilj = 'f for Viljoen et al. 1991'; 
par.f_Vilj_2 = 1;       free.f_Vilj_2 = 1;  units.f_Vilj_2 = '-'; label.f_Vilj_2 = 'f for Viljoen et al. 1992';
par.f_Vilj_3 = 1;       free.f_Vilj_3 = 1;  units.f_Vilj_3 = '-'; label.f_Vilj_3 = 'f for Viljoen et al. 1992 (15C)';
par.f_podolak = 1;      free.f_podolak = 1; units.f_podolak = '-';label.f_podolak = 'f for Podolak et al. 2020';

% Add Fayolle et al. 1997 functional responses for each dataset
par.f_Fayolle1 = 1;     free.f_Fayolle1 = 1; units.f_Fayolle1 = '-'; label.f_Fayolle1 = 'f for Fayolle et al. 1997 (paper sludge, 10C)';
par.f_Fayolle2 = 1;     free.f_Fayolle2 = 1; units.f_Fayolle2 = '-'; label.f_Fayolle2 = 'f for Fayolle et al. 1997 (paper sludge, 15C)';

par.f_Geza = 1;         free.f_Geza = 1;     units.f_Geza = '-';   label.f_Geza = 'f for Geza et al. 2023';

%% set chemical parameters from Kooy2010 
[par, units, label, free] = addchem(par, units, label, free, metaData.phylum, metaData.class);

%% Pack output: 
txtPar.units = units; txtPar.label = label; par.free = free;
