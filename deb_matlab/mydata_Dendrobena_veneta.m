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
metaData.data_1     = {'tW_viljoen', 'tW_data1', 'tW_kovacevic', 'tR_viljoen', 'tR_morgan', 'tRrate_data1', 'T_Ri', 'T_ab', 'T_hs'};
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

data.ab = 42.1; # 50% of all reared worms, Viljoen et al. 1991 21-
temp.ab = C2K(25); % 25°C, Viljoen et al. 1991
units.ab = 'd';
label.ab = 'age at birth'; 
bibkey.ab = 'Viljoen1991';
comment.ab = '15-65, Mean incubation period from Viljoen_et_al_1991_Fig5.csv';

data.ab = 21; # 50% of all reared worms, Viljoen et al. 1991 21-
temp.ab = C2K(20); % 25°C, Viljoen et al. 1991
units.ab = 'd';
label.ab = 'age at birth'; 
bibkey.ab = 'Kovacevic2023';
comment.ab = '';


data.Wwb = 0.01;   
temp.Wwb = C2K(20); % 20°C, Kovacevic2023
units.Wwb = 'g';
label.Wwb = 'wet weight at birth';     
bibkey.Wwb = 'Kovacevic2023';
comment.Wwb = 'From Kovacevic_et_al_2023_Fig2.csv, control (0 mg/kg TEB)';

data.Wwb = 0.024;   
temp.Wwb = C2K(25); % 25°C, Viljoen et al. 1991
units.Wwb = 'g';   
label.Wwb = 'wet weight at birth';     
bibkey.Wwb = 'Viljoen1991';
comment.Wwb = 'Mean mass of 55 hatched From Viljoen_et_al_1991_Fig1.csv, control (0 mg/kg TEB)';

data.Wwp = 1.09495;   
temp.Wwp = C2K(25); % 25°C, Viljoen et al. 1991
units.Wwp = 'g';   
label.Wwp = 'wet weight at puberty';     
bibkey.Wwp = 'Viljoen1991';
comment.Wwp = 'Estimated from Viljoen_et_al_1991_Fig1.csv: weight at ~65 days';

data.tp = 65; #
temp.tp = C2K(25); % 25°C, Viljoen et al. 1991
units.tp = 'd';
label.tp = 'time since birth at puberty';
bibkey.tp = 'Viljoen1991';
comment.tp = 'range 30-120 time since birth at puberty (first clitellum), 25C, cattle manure, 75-80% moisture';

data.Li = 11; % cm, hackenberger2019
units.Li = 'cm';
label.Li = 'ultimate body length';
bibkey.Li = 'Hackenberger2019';
comment.Li = '';

%Hackenberger DK, Hackenberger DK, Đerđ T, Hackenberger BK. ErIK-a software-based identification key for earthworm species of Croatia. Zootaxa. 2019 Jun 6;4613(3):zootaxa.4613.3.11. doi: 10.11646/zootaxa.4613.3.11. PMID: 31716407.

% data.am = NaN;
% temp.am = NaN;
% units.am = 'd';
% label.am = 'life span';
% bibkey.am = '';
% comment.am = 'Not available in data1.csv';

data.Wwi = 2.31172; % g (2311.72 mg)
temp.Wwi = C2K(25); % 25°C, Viljoen et al. 1991
units.Wwi = 'g';
label.Wwi = 'ultimate wet weight';
bibkey.Wwi = 'Viljoen1991';
comment.Wwi = 'Maximum body weight from Figure1 (Viljoen et al. 1991), 25C, cattle manure, 75-80% moisture';

data.Ri_25 = 0.28; # 1.1  worms per cocoon, 0.26 cocoons/worm/day
data.Ri_25 = data.Ri_25 * 1.1; % Corrected multiplication
temp.Ri_25 = C2K(25); % 25°C, Viljoen et al. 1991
units.Ri_25 = 'cocoons/worm/d';
label.Ri_25 = 'maximum reproduction rate';
bibkey.Ri_25 = 'Viljoen1991';
comment.Ri_25 = 'Maximum cocoon production rate from data1.csv (Viljoen et al. 1991), 25C, cattle manure, 75-80% moisture';

data.Ri_20 = 0.185; # Kovacevic2023 number of juevniles per ew divided by time of experiment (28days)
data.Ri_20 = data.Ri_20 * 2; % Corrected multiplication
temp.Ri_20 = C2K(20); % 25°C, Viljoen et al. 1991
units.Ri_20 = 'cocoons/worm/d';
label.Ri_20 = 'maximum reproduction rate';
bibkey.Ri_20 = 'Kovacevic2023';
comment.Ri_20 = 'Maximum cocoon production rate from kovacevic2023';


% Add other zero-variate data here as needed, with corresponding units, label, bibkey, comment, temp if available

% uni-variate data

data.tW_viljoen = [
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
data.tW_viljoen(:,2) = data.tW_viljoen(:,2) / 1000; % convert to g
units.tW_viljoen   = {'d', 'g'};  
label.tW_viljoen = {'time', 'wet weight'};
temp.tW_viljoen    = C2K(25);  
units.temp.tW_viljoen = 'K'; 
label.temp.tW_viljoen = 'temperature';
bibkey.tW_viljoen = 'Viljoen1991'; 
comment.tW_viljoen='Digitized from Viljoen_et_al_1991_Fig1.csv';


data.tW_kovacevic = [ ... % time (d), wet weight (g) at 0 mg/kg TEB
    0   1.0
    14  16.33
    28  29.0
    42  43.0
    63  64.0
    84  85.0
    105 106.0
    126 127.0
    197 196.67
];
units.tW_kovacevic   = {'d', 'g'};  
label.tW_kovacevic = {'time', 'wet weight'};
temp.tW_kovacevic    = C2K(20);  
units.temp.tW_kovacevic = 'K'; 
label.temp.tW_kovacevic = 'temperature';
bibkey.tW_kovacevic = 'Kovacevic2023'; 
comment.tW_kovacevic='Digitized from Kovacevic_et_al_2023_Fig3.csv, control (0 mg/kg TEB)';


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
set1 = {'tW_viljoen'}; subtitle1 = {'Growth: Viljoen et al. 1991'};
% set2 = {'tR_viljoen'}; subtitle2 = {'Cumulative reproduction: Viljoen et al. 1991'};
% set3 = {'tRrate_data1'}; subtitle3 = {'Reproduction rate: Viljoen et al. 1991'};
metaData.grp.sets = {set1};
metaData.grp.subtitle = {subtitle1};

%% Discussion points
D1 = 'We assume kap_R 0 0.95/2 for consistency with how all hermaphrodites are treated in the collection';
D2 = 'The mod_1 included more weight against time since birth data.';     
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



