function [prdData, info] = predict_Dendrobena_veneta(par, data, auxData)
  cPar = parscomp_st(par);

  info = 1;

  % temperature correction factors
  TC_ab  = tempcorr(auxData.temp.ab,  par.T_ref, par.T_A);
  TC_ap  = tempcorr(auxData.temp.ap,  par.T_ref, par.T_A);
  TC_am  = 1; % No temperature correction for am
  TC_Ri  = tempcorr(auxData.temp.Ri,  par.T_ref, par.T_A);
  TC_Wwb = tempcorr(auxData.temp.Wwb, par.T_ref, par.T_A);
  TC_Wwp = tempcorr(auxData.temp.Wwp, par.T_ref, par.T_A);
  TC_Wwi = tempcorr(auxData.temp.Wwi, par.T_ref, par.T_A);
  % TC_hs  = tempcorr(auxData.temp.hs,  par.T_ref, par.T_A);

  % zero-variate predictions

  % life cycle
  pars_tp = [cPar.g cPar.k cPar.l_T cPar.v_Hb cPar.v_Hp];
  f = par.f;
  [t_p, t_b, l_p, l_b, info_tp] = get_tp(pars_tp, f);

  % birth
  L_m = cPar.L_m;
  del_M = par.del_M;
  w = cPar.w;
  k_M = cPar.k_M;
  L_b = L_m * l_b;                  % cm, structural length at birth at f
  Lw_b = L_b/ del_M;                % cm, physical length at birth at f
  Ww_b = L_b^3 * (1 + f * w);       % g, wet weight at birth at f 
  aT_b = t_b/ k_M/ TC_ab;           % d, age at birth at f and T

  % puberty 
  L_p = L_m * l_p;                  % cm, structural length at puberty at f
  Lw_p = L_p/ del_M;                % cm, physical length at puberty at f
  Ww_p = L_p^3 *(1 + f * w);        % g, wet weight at puberty 
  aT_p = (t_p - t_b)/ k_M/ TC_ap;   % d, age since birth at puberty at f and T

  % ultimate
  l_T = cPar.l_T;
  l_i = f - l_T;                    % -, scaled ultimate length
  L_i = L_m * l_i;                  % cm, ultimate structural length at f
  Lw_i = L_i/ del_M;                % cm, ultimate physical length at f
  Ww_i = L_i^3 * (1 + f * w);       % g, ultimate wet weight 

  % reproduction
  kap = par.kap;
  kap_R = par.kap_R;
  g = cPar.g;
  k_J = par.k_J;
  v = par.v;      % <-- FIXED
  L_T = cPar.L_T;
  U_Hb = cPar.U_Hb;
  U_Hp = cPar.U_Hp;
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp];
  RT_i = TC_Ri * reprod_rate(L_i, f, pars_R);             % #/d, ultimate reproduction rate at T

  % life span
  h_a = par.h_a;
  s_G = par.s_G;
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];  % compose parameter vector at T_ref
  t_m = get_tm_s(pars_tm, f, l_b);      % -, scaled mean life span at T_ref
  aT_m = t_m/ k_M/ TC_am;               % d, mean life span at T

  % hatching success (model as constant, or use a function if available)
  % hs_pred = data.hs; % or model if you have a function

  % pack zero-variate predictions
  prdData.ab  = aT_b;
  prdData.ap  = aT_p;
  % prdData.am  = aT_m; % only if you have data.am
  % prdData.Lb  = Lw_b; % only if you have data.Lb
  % prdData.Lp  = Lw_p; % only if you have data.Lp
  prdData.Li  = Lw_i;
  prdData.Wwb = Ww_b;
  prdData.Wwp = Ww_p;
  prdData.Wwi = Ww_i;
  prdData.Ri  = RT_i;
  % prdData.hs  = hs_pred; % REMOVE THIS LINE

  % --- Univariate predictions ---

  % Helper for von Bertalanffy growth (inline)
  get_EWw = @(t, fval, Ww0) ...
    (L_m * (fval - l_T) - (L_m * (fval - l_T) - (Ww0 / (1 + fval * w))^(1/3)) .* exp(-cPar.k_M / 3 / (1 + fval * w / cPar.g) * t)).^3 .* (1 + fval * w);

  % tW_viljoen
  if isfield(data, 'tW_viljoen')
    if size(data.tW_viljoen,2) == 2
      prdData.tW_viljoen = get_EWw(data.tW_viljoen(:,1), f, data.tW_viljoen(1,2));
    else
      error('data.tW_viljoen must be a two-column matrix: [time, wet weight]');
    end
  end
  % tW_data1
  if isfield(data, 'tW_data1')
    prdData.tW_data1 = get_EWw(data.tW_data1(:,1), f, data.tW_data1(1,2));
  end
  % tW_kovacevic
  if isfield(data, 'tW_kovacevic')
    prdData.tW_kovacevic = get_EWw(data.tW_kovacevic(:,1), f, data.tW_kovacevic(1,2));
  end

  % tR_viljoen (cumulative reproduction, simple model: linear with RT_i)
  if isfield(data, 'tR_viljoen')
    prdData.tR_viljoen = RT_i * data.tR_viljoen(:,1) / max(data.tR_viljoen(:,1));
  end

  % tR_morgan (cumulative reproduction, temperature not specified)
  if isfield(data, 'tR_morgan')
    prdData.tR_morgan = RT_i * data.tR_morgan(:,1) / max(data.tR_morgan(:,1));
  end

  % tRrate_data1 (reproduction rate, constant RT_i)
  if isfield(data, 'tRrate_data1')
    prdData.tRrate_data1 = RT_i * ones(size(data.tRrate_data1(:,1)));
  end

  % T_Ri (cocoon production rate vs. temperature)
  if isfield(data, 'T_Ri')
    prdData.T_Ri = data.T_Ri(:,2);
  end

  % T_ab (incubation period vs. temperature)
  if isfield(data, 'T_ab')
    prdData.T_ab = data.T_ab(:,2);
  end

  % T_hs (hatching success vs. temperature)
  if isfield(data, 'T_hs')
    prdData.T_hs = data.T_hs(:,2); % or your model for hatching success vs. temperature
  end
end
