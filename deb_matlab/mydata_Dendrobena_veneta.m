function [data, auxData, metaData, txtData, weights] = mydata_Dendrobena_veneta 

%% set metaData
metaData.phylum     = 'Annelida'; 
metaData.class      = 'Clitellata'; 
metaData.order      = 'Haplotaxida'; 
metaData.family     = 'Lumbricidae';
metaData.species    = 'Dendrobena_veneta'; 
metaData.species_en = 'European_nightcrawler'; 

metaData.ecoCode.climate = {'C'};
metaData.ecoCode.ecozone = {'TP', 'TN', 'TA', 'TH'};
metaData.ecoCode.habitat = {'0iTh', '0iTf', '0iTi'};
metaData.ecoCode.embryo  = {'Tt'};
metaData.ecoCode.migrate = {};
metaData.ecoCode.food    = {'biD'};
metaData.ecoCode.gender  = {'Hh'};
metaData.ecoCode.reprod  = {'O'};

metaData.T_typical  = C2K(20); % K, body temp
metaData.data_0     = {'ab'; 'ap'; 'am'; 'Lb'; 'Lp'; 'Li'; 'Wwb'; 'Wwp'; 'Wwi'; 'Ri'}; 
metaData.data_1     = {'tW_Vilj', 'tW_data1', 'tW_kovacevic', 'tR_viljoen', 'tR_morgan', 'tRrate_data1', 'T_Ri', 'T_ab', 'T_hs'};
metaData.COMPLETE = 2.5; % using criteria of LikaKear2011

metaData.author   = {"Domagoj K. Hackenberger", "Sunčana Geček"};    
metaData.date_subm = [2025 05 27];              
metaData.email    = {''};            
metaData.address  = {'IRB, Zagreb, Croatia'}; 

% metaData.author_mod_1    = {'Andre Gergs'};            
% metaData.date_mod_1 = [2017 05 25];               
% metaData.email_mod_1     = {'Gergs@gaiac.rwth-aachen.de'};            
% metaData.address_mod_1   = {'gaiac, 52072 Aachen, Germany'};

metaData.curator     = {'Nina Marn'};
metaData.email_cur   = {''}; 
metaData.date_acc    = [2017 07 22]; 

%% set data
% zero-variate data

data.ab_25 = 42.1; % 50% of all reared worms, Viljoen et al. 1991 21-
temp.ab_25 = C2K(25); % 25°C, Viljoen et al. 1991
units.ab_25 = 'd';
label.ab_25 = 'age at birth'; 
bibkey.ab_25 = 'Viljoen1991';
comment.ab_25 = '15-65, Mean incubation period from Viljoen1991';


data.ab_25_2 = 42; # 50% of all reared worms, Viljoen et al. 1991 21-
temp.ab_25_2 = C2K(25); % 25°C, Viljoen et al. 1991
units.ab_25_2 = 'd';
label.ab_25_2 = 'age at birth'; 
bibkey.ab_25_2 = 'Viljoen1992';
comment.ab_25_2 = 'Mean incubation period from Viljoen1992';


data.ab_15 = 71; # 50% of all reared worms, Viljoen et al. 1991 21-
temp.ab_15 = C2K(15); % 25°C, Viljoen et al. 1991
units.ab_15 = 'd';
label.ab_15 = 'age at birth'; 
bibkey.ab_15 = 'Viljoen1992';
comment.ab_15 = '15-65, Mean incubation period from Viljoen1992';



data.ab_20 = 21; %# 50% of all reared worms, Viljoen et al. 1991 21-
temp.ab_20 = C2K(20); % 25°C, Viljoen et al. 1991
units.ab_20 = 'd';
label.ab_20 = 'age at birth'; 
bibkey.ab_20 = 'Kovacevic2023';
comment.ab_20 = '';

data.Wwb_20 = 0.01;   
temp.Wwb_20 = C2K(20); % 20°C, Kovacevic2023
units.Wwb_20 = 'g';
label.Wwb_20 = 'wet weight at birth';     
bibkey.Wwb_20 = 'Kovacevic2023';
comment.Wwb_20 = 'From Kovacevic_et_al_2023_Fig2, control (0 mg/kg TEB)';

data.Wwb_25 = 0.024;   
temp.Wwb_25 = C2K(25); % 25°C, Viljoen et al. 1991
units.Wwb_25 = 'g';   
label.Wwb_25 = 'wet weight at birth';     
bibkey.Wwb_25 = 'Viljoen1991';
comment.Wwb_25 = 'Mean mass of 55 hatched From Viljoen_et_al_1991_Fig1, control (0 mg/kg TEB)';

data.Wwp = 1.09495;   
temp.Wwp = C2K(25); % 25°C, Viljoen et al. 1991
units.Wwp = 'g';   
label.Wwp = 'wet weight at puberty';     
bibkey.Wwp = 'Viljoen1991';
comment.Wwp = 'Estimated from Viljoen_et_al_1991_Fig1: weight at ~65 days';

data.tp = 65; %#
temp.tp = C2K(25); % 25°C, Viljoen et al. 1991
units.tp = 'd';
label.tp = 'time since birth at puberty';
bibkey.tp = 'Viljoen1991';
comment.tp = 'range 30-120 time since birth at puberty (first clitellum), 25C, cattle manure, 75-80% moisture';

data.tp = 60; #
temp.tp = C2K(25); % 25°C, Viljoen et al. 1991
units.tp = 'd';
label.tp = 'time since birth at puberty';
bibkey.tp = 'Viljoen1992';
comment.tp = 'time since birth at puberty (first clitellum), 25C, cattle manure, 75-80% moisture';

data.tp2 = 65; #
temp.tp2 = C2K(25); % 25°C, Viljoen et al. 1991
units.tp2 = 'd';
label.tp2 = 'time since birth at puberty';
bibkey.tp2 = 'Viljoen1991';
comment.tp2 = 'range 30-120 time since birth at puberty (first clitellum), 25C, cattle manure, 75-80% moisture';

data.tp3 = 77; #
temp.tp3 = C2K(15); % 25°C, Viljoen et al. 1991
units.tp3 = 'd';
label.tp3 = 'time since birth at puberty';
bibkey.tp3 = 'Viljoen1992';
comment.tp3 = ' time since birth at puberty (first clitellum), 15, cattle manure, 75-80% moisture';

data.Li = 11; % cm, hackenberger2019
units.Li = 'cm';
label.Li = 'ultimate body length';
bibkey.Li = 'Hackenberger2019';
comment.Li = '';


%Hackenberger DK, Hackenberger DK, Đerđ T, Hackenberger BK. ErIK-a software-based identification key for earthworm species of Croatia. Zootaxa. 2019 Jun 6;4613(3):zootaxa.4613.3.11. doi: 10.11646/zootaxa.4613.3.11. PMID: 31716407.

data.am = 6*365; % days, 7 years - TODO: check / no exact data however composting worms can live from 4-8 years
temp.am = C2K(15);
units.am = 'd';
label.am = 'life span';
bibkey.am = 'guess';
comment.am = 'average of earthworms';

data.Wwi = 2.31172; % g (2311.72 mg)
temp.Wwi = C2K(25); % 25°C, Viljoen et al. 1991
units.Wwi = 'g';
label.Wwi = 'ultimate wet weight';
bibkey.Wwi = 'Viljoen1991';
comment.Wwi = 'Maximum body weight from Figure1 (Viljoen et al. 1991), 25C, cattle manure, 75-80% moisture';

data.Ri_25 = 0.28; %# 1.1  worms per cocoon, 0.26 cocoons/worm/day
data.Ri_25 = data.Ri_25 * 1.1; % Corrected multiplication
temp.Ri_25 = C2K(25); % 25°C, Viljoen et al. 1991
units.Ri_25 = 'cocoons/worm/d';
label.Ri_25 = 'maximum reproduction rate';
bibkey.Ri_25 = 'Viljoen1991';
comment.Ri_25 = 'Maximum cocoon production rate from  (Viljoen et al. 1991), 25C, cattle manure, 75-80% moisture, it is also same in Viljoen1992';

data.Ri_15 = 17;
% data.Ri_15 = 0.28; # 1.1  worms per cocoon, 0.26 cocoons/worm/day
data.Ri_15 = data.Ri_15 * 1.2; % Corrected multiplication for ammount of hatchlings per cocoon
temp.Ri_15 = C2K(15); % 25°C, Viljoen et al. 1991
units.Ri_15 = 'cocoons/worm/d'; 
label.Ri_15 = 'maximum reproduction rate';
bibkey.Ri_15 = 'Viljoen1992';
comment.Ri_15 = 'Maximum cocoon production rate from (Viljoen et al. 1992), 15C, cattle manure, 75-80% moisture';


data.Ri_18 = 0.28; # 1.1  worms per cocoon, 0.26 cocoons/worm/day
data.Ri_18 = data.Ri_25 * 1.1; % Corrected multiplication
temp.Ri_18 = C2K(25); % 25°C, Viljoen et al. 1991
units.Ri_18 = 'cocoons/worm/d';
label.Ri_18 = 'maximum reproduction rate';
bibkey.Ri_18 = 'Podolak2020';
comment.Ri_18 = 'Maximum cocoon production rate from (Poodolak et al. 2020), 18C';

data.Ri_20 = 0.185; %# Kovacevic2023 number of juevniles per ew divided by time of experiment (28days)
data.Ri_20 = data.Ri_20 * 2; % Corrected multiplication
temp.Ri_20 = C2K(20); % 25°C, Viljoen et al. 1991
units.Ri_20 = 'cocoons/worm/d';
label.Ri_20 = 'maximum reproduction rate';
bibkey.Ri_20 = 'Kovacevic2023';
comment.Ri_20 = 'Maximum cocoon production rate from kovacevic2023';

% Add other zero-variate data here as needed, with corresponding units, label, bibkey, comment, temp if available

% uni-variate data

data.tW_Vilj = [
    5   56.44
    10  96.88
    15  141.35
    20  205.86
    25  262.33
    30  363.0
    35  443.55
    40  560.22
    45  701.03
    50  797.63
    55  918.35
    60  1010.95
    65  1095.52
    70  1216.24
    75  1272.73
    80  1409.49
    85  1461.96
    90  1546.56
    95  1635.18
    100 1723.78
    105 1772.21
    110 1844.76
    115 1893.22
    120 1997.88
    125 2038.32
    130 2042.63
    135 2038.88
    140 2071.32
    145 2131.84
    150 2144.16
    155 2112.37
    160 2156.79
    165 2205.26
    170 2213.59
    175 2250.01
    180 2274.4
    185 2294.79
    190 2311.1
    195 2295.41
    200 2311.72
];
data.tW_Vilj(:,2) = data.tW_Vilj(:,2) / 1000; % convert to g
units.tW_Vilj   = {'d', 'g'};  
label.tW_Vilj = {'time', 'wet weight'};
temp.tW_Vilj    = C2K(25);  
units.temp.tW_Vilj = 'K'; 
label.temp.tW_Vilj = 'temperature';
bibkey.tW_Vilj = 'Viljoen1991'; 
comment.tW_Vilj='Digitized from Viljoen1991 Fig1';


data.tW_Vilj_2 = [
    5   31.47;
    10  83.53;
    15  135.6;
    20  216.71;
    25  274.58;
    30  344.04;
    35  436.77;
    40  564.27;
    45  726.62;
    50  813.52;
    55  888.8;
    60  1016.32;
    65  1050.98;
    70  1178.49;
    75  1253.77;
    80  1369.7;
    85  1357.91;
    90  1473.84;
    95  1601.36;
    100 1653.43;
    105 1693.87;
    110 1757.58;
    115 1844.47;
    120 1942.97;
    125 2006.64;
    130 2064.53;
    135 2012.16;
    140 2006.19;
    145 2040.84;
    150 1976.85;
    155 1976.66;
    160 2034.55;
    165 2109.83;
    170 2196.74;
    175 2260.42;
    180 2242.84;
    185 2225.26;
    190 2265.74;
    195 2306.21;
    200 2218.99
];
data.tW_Vilj_2(:,2) = data.tW_Vilj_2(:,2) / 1000; % convert to g
units.tW_Vilj_2   = {'d', 'g'};  
label.tW_Vilj_2 = {'time', 'wet weight'};
temp.tW_Vilj_2    = C2K(25);  
units.temp.tW_Vilj_2 = 'K'; 
label.temp.tW_Vilj_2 = 'temperature';
bibkey.tW_Vilj_2 = 'Viljoen1992'; 
comment.tW_Vilj_2='Digitized from Viljoen1992 Fig1';


data.tW_Vilj_3 = [
    5   37.24;
    10  71.92;
    15  89.17;
    20  147.05;
    25  181.71;
    30  239.58;
    35  326.46;
    40  384.36;
    45  453.84;
    50  523.33;
    55  633.44;
    60  668.1;
    65  813.06;
    70  882.53;
    75  969.41;
    80  1009.87;
    85  1027.15;
    90  1114.02;
    95  1154.48;
    100 1148.53;
    105 1223.83;
    110 1229.46;
    115 1264.14;
    120 1263.97;
    125 1263.8;
    130 1252.07;
    135 1309.93;
    140 1373.61;
    145 1414.09;
    150 1413.91;
    155 1390.56;
    160 1465.86;
    165 1448.28;
    170 1488.74;
    175 1488.57;
    180 1563.89;
    185 1563.73;
    190 1604.19;
    195 1621.46;
    200 1685.15
];
data.tW_Vilj_3(:,2) = data.tW_Vilj_3(:,2) / 1000; % convert to g
units.tW_Vilj_3   = {'d', 'g'};  
label.tW_Vilj_3 = {'time', 'wet weight'};
temp.tW_Vilj_3    = C2K(15);  
units.temp.tW_Vilj_3 = 'K'; 
label.temp.tW_Vilj_3 = 'temperature';
bibkey.tW_Vilj_3 = 'Viljoen1992'; 
comment.tW_Vilj_3='Digitized from Viljoen1992 Fig1';

data.tW_podolak = [ ... % time (d), wet weight (g) at 0 g/kg TEB
    0   0.93;
    28  1.42;
    56  1.72;
    84  2.14;
    112 2.48;
    140 2.67;
    168 2.86;
    196 2.97;
    224 2.97;
    252 2.98;
    280 2.72;
    308 2.65;
    336 2.61;
    364 2.28
];
units.tW_podolak   = {'d', 'g'};
label.tW_podolak = {'time', 'wet weight'};
temp.tW_podolak    = C2K(18);
units.temp.tW_podolak = 'K';
label.temp.tW_podolak = 'temperature';
bibkey.tW_podolak = 'Podolak2020';
comment.tW_podolak='Digitized from Podolak2020 Fig1, control (0 g/kg TEB)';




data.tW_Kova = [ ... % time (d), wet weight (g) at 0 mg/kg TEB
    0   0.01
    14  0.25
    28  0.51
    42  1.2
    63  1.8
    84  1.78
    105 1.89
    126 2.0
    197 2.29

];
units.tW_Kova   = {'d', 'g'};  
label.tW_Kova = {'time', 'wet weight'};
temp.tW_Kova    = C2K(20);  
units.temp.tW_Kova = 'K'; 
label.temp.tW_Kova = 'temperature';
bibkey.tW_Kova = 'Kovacevic2023'; 
comment.tW_Kova='Digitized from Kovacevic_et_al_2023_Fig3, control (0 mg/kg TEB)';


%% set weights for all real data
weights = setweights(data, []);

%% set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);
weights.psd.p_M = 10 * weights.psd.p_M;

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;
txtData.comment = comment;

%% Group plots
set1 = {'tW_Vilj'}; subtitle1 = {'Growth: Viljoen et al. 1991'};
% set2 = {'tR_viljoen'}; subtitle2 = {'Cumulative reproduction: Viljoen et al. 1991'};
% set3 = {'tRrate_data1'}; subtitle3 = {'Reproduction rate: Viljoen et al. 1991'};
metaData.grp.sets = {set1};
metaData.grp.subtitle = {subtitle1};

%% Discussion points
D1 = 'We assume kap_R 0 0.95/2 for consistency with how all hermaphrodites are treated in the collection';
D2 = '';     
metaData.discussion = struct('D1', D1, 'D2', D2);

%% Facts
F1 = 'Dendrobena veneta is hermaphroditic. However, two worms are still required for reproduction.';
metaData.bibkey.F1 = 'Wiki'; 
metaData.facts = struct('F1',F1);

%% Acknowledgment
metaData.acknowledgment = 'The creation of this entry was supported by the European Food Safety Authority (grant number OC/EFSA/SCER/2015/01)';

%% Links
metaData.links.id_CoL = '38W46'; % Cat of Life
metaData.links.id_ITIS = '976620'; % ITIS
metaData.links.id_EoL = '3126934'; % Ency of Life
metaData.links.id_Wiki = 'Dendrobena_veneta'; % Wikipedia
metaData.links.id_ADW = ''; % ADW
metaData.links.id_Taxo = '140603'; % Taxonomicon
metaData.links.id_WoRMS = '1041027'; % WoRMS

%% References
bibkey = 'Wiki'; type = 'Misc'; bib = ...
'howpublished = {\url{https://en.wikipedia.org/wiki/Dendrobena_veneta}}';
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'Viljoen1991'; type = 'Article'; bib = [ ...
'author = {S. A. Viljoen and A. J. Reinecke}, ' ...
'year = {1991}, ' ...
'title = {Life-cycle of the European compost worm Dendrobaena veneta (Oligochaeta)}, ' ...
'journal = {South African Journal of Zoology}, ' ...
'volume = {26}, ' ...
'pages = {41-45}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'Kovacevic2023'; type = 'Article'; bib = [ ...
'author = {Kovačević, A. and others}, ' ...
'year = {2023}, ' ...
'title = {Effects of Tebuconazole on the Earthworm Dendrobaena veneta: Full Life Cycle Approach}, ' ...
'journal = {Agriculture}, ' ...
'volume = {13}, ' ...
'pages = {2119}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'Hackenberger2019'; type = 'Article'; bib = [ ...
'author = {Hackenberger, D.K. and Hackenberger, D.K. and Đerđ, T. and Hackenberger, B.K.}, ' ...
'year = {2019}, ' ...
'title = {ErIK-a software-based identification key for earthworm species of Croatia}, ' ...
'journal = {Zootaxa}, ' ...
'volume = {4613}, ' ...
'number = {3}, ' ...
'pages = {zootaxa.4613.3.11}, ' ...
'doi = {10.11646/zootaxa.4613.3.11}, ' ...
'pmid = {31716407}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];


bibkey = 'Viljoen1992'; type = 'Article'; bib = [ ...
'author = {S. A. Viljoen and A. J. Reinecke}, ' ...
'year = {1992}, ' ...
'title = {The effect of temperature on the life cycle of the European compost worm Dendrobaena veneta (Oligochaeta)}, ' ...
'journal = {South African Journal of Zoology}, ' ...
'volume = {27}, ' ...
'pages = {1-5}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'Podolak2020'; type = 'Article'; bib = [ ...
'author = {Podolak, K. and others}, ' ...
'year = {2020}, ' ...
'title = {The effect of tebuconazole on the earthworm Dendrobaena veneta: a full life cycle approach}, ' ...
'journal = {Environmental Science and Pollution Research}, ' ...
'volume = {27}, ' ...
'pages = {1-12}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

2