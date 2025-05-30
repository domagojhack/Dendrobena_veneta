function [prdData, info] = predict_Dendrobena_veneta(par, data, auxData)
  % unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);


  info = 1;

  % temperature correction factors
  TC_ab_25  = tempcorr(auxData.temp.ab_25,  par.T_ref, par.T_A);
  TC_ab_20  = tempcorr(auxData.temp.ab_20,  par.T_ref, par.T_A);
  % TC_ab_18  = tempcorr(auxData.temp.ab_18,  par.T_ref, par.T_A);
  TC_tp  = tempcorr(auxData.temp.tp,  par.T_ref, par.T_A);
  %TC_Ri_20  = tempcorr(auxData.temp.Ri_20,  par.T_ref, par.T_A);
  TC_am = tempcorr(auxData.temp.am,  par.T_ref, par.T_A);
  TC_20 = tempcorr(auxData.temp.Wwb_20,  par.T_ref, par.T_A);
  TC_25 = tempcorr(auxData.temp.Wwb_25,  par.T_ref, par.T_A);
  % TC_15 = tempcorr(auxData.temp.Wwb_15,  par.T_ref, par.T_A);
  TC_15 = tempcorr(auxData.temp.Ri_15,  par.T_ref, par.T_A);
  TC_18 = tempcorr(auxData.temp.Ri_18,  par.T_ref, par.T_A);

  % zero-variate predictions

  % life cycle
  pars_tp = [g k l_T v_Hb v_Hp];
  [t_p, t_b, l_p, l_b, info] = get_tp(pars_tp, f);
  

   % birth
  L_b = L_m * l_b;                  % cm, structural length at birth at f
  Lw_b = L_b/ del_M;                % cm, physical length at birth at f
  Ww_b_25 = L_b^3 * (1 + f * ome);
  Ww_b_20 = L_b^3 * (1 + f * ome);        % g, wet weight at birth at f 
  aT_b_25 = t_b/ k_M/ TC_ab_25;
  aT_b_20 = t_b/ k_M/ TC_ab_20;     % d, age at birth at f and T

  % puberty 
  L_p = L_m * l_p;                  % cm, structural length at puberty at f
  Lw_p = L_p/ del_M;                % cm, physical length at puberty at f
  Ww_p = L_p^3 *(1 + f * ome);        % g, wet weight at puberty 
  aT_p = (t_p - t_b)/ k_M/ TC_tp;           % d, age since birth at puberty at f and T

  % ultimate
  l_i = f - l_T;                    % -, scaled ultimate length
  L_i = L_m * l_i;                  % cm, ultimate structural length at f
  Lw_i = L_i/ del_M;                % cm, ultimate physical length at f
  Ww_i = L_i^3 * (1 + f * ome);       % g, ultimate wet weight 
 
  % reproduction
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp]; % compose parameter vector at T
  RT_i_20 = TC_20 * reprod_rate(L_i, f_Kova, pars_R);             % #/d, ultimate reproduction rate at T
  RT_i_25 = TC_25 * reprod_rate(L_i, f_Vilj, pars_R);             % #/d, ultimate reproduction rate at T
  RT_i_15 = TC_15 * reprod_rate(L_i, f_Vilj_3, pars_R); % adjust f_Vilj_3 if needed
  RT_i_18 = TC_18 * reprod_rate(L_i, f_podolak, pars_R); % #/d, ultimate reproduction rate at T
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
  prdData.Ri_15  = RT_i_15;
  prdData.Ri_18 = RT_i_18;
  % --- Univariate predictions ---
  % uni-variate data : time-wet weight of 46 individual worms from 2
  % separate experiments
  
  % time-weight 
  f=f_Kova; ir_B = 3/ k_M + 3 * f * L_m/ v; rT_B = TC_20/ ir_B;                          % d, 1/von Bertalanffy growth rate
  L_i = L_m * (f - l_T); L_b = L_m * get_lb([g k v_Hb], f);         % cm, structural length
  L = L_i - (L_i - L_b) * exp( - rT_B * tW_Kova(:,1));                 % cm, structural length at time
  EWw_Kova = L.^3 * (1 + f * ome);                                       % g, wet weight  
  % pack to output
  prdData.tW_Kova = EWw_Kova;
  
    % time-weight 
  f=f_Vilj; ir_B = 3/ k_M + 3 * f * L_m/ v; rT_B = TC_25/ ir_B;                          % d, 1/von Bertalanffy growth rate
  L_i = L_m * (f - l_T); L_b = L_m * get_lb([g k v_Hb], f);         % cm, structural length
  L = L_i - (L_i - L_b) * exp( - rT_B * tW_Vilj(:,1));                 % cm, structural length at time
  EWw_Vilj = L.^3 * (1 + f * ome);                                       % g, wet weight  
  % pack to output
  prdData.tW_Vilj = EWw_Vilj;

  % --- Additional zero-variate predictions ---
  % ab_25_2
  aT_b_25_2 = t_b/ k_M/ tempcorr(auxData.temp.ab_25_2, par.T_ref, par.T_A);
  prdData.ab_25_2 = aT_b_25_2;

  % ab_15
  aT_b_15 = t_b/ k_M/ tempcorr(auxData.temp.ab_15, par.T_ref, par.T_A);
  prdData.ab_15 = aT_b_15;

  % ab_20
  aT_b_20_2 = t_b/ k_M/ tempcorr(auxData.temp.ab_20, par.T_ref, par.T_A);
  prdData.ab_20 = aT_b_20_2;

  % tp2
  prdData.tp2 = aT_p; % If you want to use a different f or temp, adjust accordingly

  % tp3 (at 15C)
  TC_tp3 = tempcorr(auxData.temp.tp3, par.T_ref, par.T_A);
  prdData.tp3 = (t_p - t_b)/ k_M/ TC_tp3;

  % --- Additional uni-variate predictions ---
  % tW_Vilj_2 (25C, f_Vilj_2)
  f = f_Vilj_2; TC = tempcorr(auxData.temp.tW_Vilj_2, par.T_ref, par.T_A);
  ir_B = 3/ k_M + 3 * f * L_m/ v; rT_B = TC/ ir_B;
  L_i = L_m * (f - l_T); L_b = L_m * get_lb([g k v_Hb], f);
  L = L_i - (L_i - L_b) * exp( - rT_B * tW_Vilj_2(:,1));
  EWw_Vilj_2 = L.^3 * (1 + f * ome);
  prdData.tW_Vilj_2 = EWw_Vilj_2;

  % tW_Vilj_3 (15C, f_Vilj_3)
  f = f_Vilj_3; TC = tempcorr(auxData.temp.tW_Vilj_3, par.T_ref, par.T_A);
  ir_B = 3/ k_M + 3 * f * L_m/ v; rT_B = TC/ ir_B;
  L_i = L_m * (f - l_T); L_b = L_m * get_lb([g k v_Hb], f);
  L = L_i - (L_i - L_b) * exp( - rT_B * tW_Vilj_3(:,1));
  EWw_Vilj_3 = L.^3 * (1 + f * ome);
  prdData.tW_Vilj_3 = EWw_Vilj_3;

  % tW_podolak (18C, f_podolak)
  f = f_podolak; TC = tempcorr(auxData.temp.tW_podolak, par.T_ref, par.T_A);
  ir_B = 3/ k_M + 3 * f * L_m/ v; rT_B = TC/ ir_B;
  L_i = L_m * (f - l_T); L_b = L_m * get_lb([g k v_Hb], f);
  w0_podo = 0.93; % initial wet weight from Podolak et al. 2020
  L_t0 = (w0_podo/(1+f*ome)).^(1/3);
  L = L_i - (L_i - L_t0) * exp( - rT_B * tW_podolak(:,1));
  EWw_podolak = L.^3 * (1 + f * ome);
  prdData.tW_podolak = EWw_podolak;
  
end





