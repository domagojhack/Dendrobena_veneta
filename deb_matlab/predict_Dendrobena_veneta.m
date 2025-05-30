function [prdData, info] = predict_Dendrobena_veneta(par, data, auxData)
  % unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);


  info = 1;

  % temperature correction factors
  TC_ab_25  = tempcorr(auxData.temp.ab_25,  par.T_ref, par.T_A);
  TC_ab_20  = tempcorr(auxData.temp.ab_20,  par.T_ref, par.T_A);
  TC_tp  = tempcorr(auxData.temp.tp,  par.T_ref, par.T_A);
  %TC_Ri_20  = tempcorr(auxData.temp.Ri_20,  par.T_ref, par.T_A);
  TC_am = tempcorr(auxData.temp.am,  par.T_ref, par.T_A);
  TC_20 = tempcorr(auxData.temp.Wwb_20,  par.T_ref, par.T_A);
  TC_25 = tempcorr(auxData.temp.Wwb_25,  par.T_ref, par.T_A);

  % zero-variate predictions

  % life cycle
  pars_tp = [g k l_T v_Hb v_Hp];
  [t_p, t_b, l_p, l_b, info] = get_tp(pars_tp, f);
  

   % birth
  L_b = L_m * l_b;                  % cm, structural length at birth at f
  Lw_b = L_b/ del_M;                % cm, physical length at birth at f
  Ww_b_25 = L_b^3 * (1 + f * w);
  Ww_b_20 = L_b^3 * (1 + f * w);        % g, wet weight at birth at f 
  aT_b_25 = t_b/ k_M/ TC_ab_25;
  aT_b_20 = t_b/ k_M/ TC_ab_20;     % d, age at birth at f and T

  % puberty 
  L_p = L_m * l_p;                  % cm, structural length at puberty at f
  Lw_p = L_p/ del_M;                % cm, physical length at puberty at f
  Ww_p = L_p^3 *(1 + f * w);        % g, wet weight at puberty 
  aT_p = (t_p - t_b)/ k_M/ TC_tp;           % d, age since birth at puberty at f and T

  % ultimate
  l_i = f - l_T;                    % -, scaled ultimate length
  L_i = L_m * l_i;                  % cm, ultimate structural length at f
  Lw_i = L_i/ del_M;                % cm, ultimate physical length at f
  Ww_i = L_i^3 * (1 + f * w);       % g, ultimate wet weight 
 
  % reproduction
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp]; % compose parameter vector at T
  RT_i_20 = TC_20 * reprod_rate(L_i, f_Kova, pars_R);             % #/d, ultimate reproduction rate at T
  RT_i_25 = TC_25 * reprod_rate(L_i, f_Vilj, pars_R);             % #/d, ultimate reproduction rate at T

  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];  % compose parameter vector at T_ref
  t_m = get_tm_s(pars_tm, f, l_b);      % -, scaled mean life span at T_ref
  aT_m = t_m/ k_M/ TC_am;               % d, mean life span at T
  
  % pack to output
  prdData.ab_25 = aT_b_25;
  prdData.ab_20 = aT_b_20;
  prdData.tp = aT_p;
  prdData.am = aT_m;
  % prdData.Lb = Lw_b;
  % prdData.Lp = Lw_p;
  prdData.Li = Lw_i;
  prdData.Wwb_25 = Ww_b_25;
  prdData.Wwb_20 = Ww_b_20;
  prdData.Wwp = Ww_p;
  prdData.Wwi = Ww_i;
  prdData.Ri_20  = RT_i_20;
  prdData.Ri_25  = RT_i_25;
  % --- Univariate predictions ---
  % uni-variate data : time-wet weight of 46 individual worms from 2
  % separate experiments
  
  % time-weight 
  f=f_Kova; ir_B = 3/ k_M + 3 * f * L_m/ v; rT_B = TC_20/ ir_B;                          % d, 1/von Bertalanffy growth rate
  L_i = L_m * (f - l_T); L_b = L_m * get_lb([g k v_Hb], f);         % cm, structural length
  L = L_i - (L_i - L_b) * exp( - rT_B * tW_Kova(:,1));                 % cm, structural length at time
  EWw_Kova = L.^3 * (1 + f * w);                                       % g, wet weight  
  % pack to output
  prdData.tW_Kova = EWw_Kova;
  
    % time-weight 
  f=f_Vilj; ir_B = 3/ k_M + 3 * f * L_m/ v; rT_B = TC_25/ ir_B;                          % d, 1/von Bertalanffy growth rate
  L_i = L_m * (f - l_T); L_b = L_m * get_lb([g k v_Hb], f);         % cm, structural length
  L = L_i - (L_i - L_b) * exp( - rT_B * tW_Vilj(:,1));                 % cm, structural length at time
  EWw_Vilj = L.^3 * (1 + f * w);                                       % g, wet weight  
  % pack to output
  prdData.tW_Vilj = EWw_Vilj;
  


