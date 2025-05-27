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

data.ab = 21;
temp.ab = C2K(25); % 25°C, Viljoen et al. 1991
units.ab = 'd';
label.ab = 'age at birth'; 
bibkey.ab = 'Viljoen1991';
comment.ab = 'Mean incubation period from Viljoen_et_al_1991_Fig5.csv';

data.Wwb = 0.01;   
temp.Wwb = C2K(20); % 20°C, Kovacevic2023
units.Wwb = 'g';   
label.Wwb = 'wet weight at birth';     
bibkey.Wwb = 'Kovacevic2023';
comment.Wwb = 'From Kovacevic_et_al_2023_Fig2.csv, control (0 mg/kg TEB)';

data.Wwp = 0.30;   
temp.Wwp = C2K(25); % 25°C, Viljoen et al. 1991
units.Wwp = 'g';   
label.Wwp = 'wet weight at puberty';     
bibkey.Wwp = 'Viljoen1991';
comment.Wwp = 'Estimated from Viljoen_et_al_1991_Fig1.csv: weight at ~60 days';

data.ap = 65;
temp.ap = C2K(25); % 25°C, Viljoen et al. 1991
units.ap = 'd';
label.ap = 'age at puberty';
bibkey.ap = 'Viljoen1991';
comment.ap = 'Age at puberty (first clitellum) from data1.csv, 25C, cattle manure, 75-80% moisture';

data.Li = 11; % cm, hackenberger2019
units.Li = 'cm';
label.Li = 'ultimate body length';
bibkey.Li = 'Hackenberger2019';

%Hackenberger DK, Hackenberger DK, Đerđ T, Hackenberger BK. ErIK-a software-based identification key for earthworm species of Croatia. Zootaxa. 2019 Jun 6;4613(3):zootaxa.4613.3.11. doi: 10.11646/zootaxa.4613.3.11. PMID: 31716407.

% data.am = NaN;
% temp.am = NaN;
% units.am = 'd';
% label.am = 'life span';
% bibkey.am = '';
% comment.am = 'Not available in data1.csv';

data.Wwi = 2.2; % g (2200 mg)
temp.Wwi = C2K(25); % 25°C, Viljoen et al. 1991
units.Wwi = 'g';
label.Wwi = 'ultimate wet weight';
bibkey.Wwi = 'Viljoen1991';
comment.Wwi = 'Maximum body weight from data1.csv (Viljoen et al. 1991), 25C, cattle manure, 75-80% moisture';

data.Ri = 0.43;
temp.Ri = C2K(25); % 25°C, Viljoen et al. 1991
units.Ri = 'cocoons/worm/d';
label.Ri = 'maximum reproduction rate';
bibkey.Ri = 'Viljoen1991';
comment.Ri = 'Maximum cocoon production rate from data1.csv (Viljoen et al. 1991), 25C, cattle manure, 75-80% moisture';

% Add other zero-variate data here as needed, with corresponding units, label, bibkey, comment, temp if available

% uni-variate data

data.tW_viljoen = [
  0   0.01
  30  0.05
  60  0.15
  90  0.30
  120 0.50
  150 0.80
  180 1.10
  200 1.30
];
units.tW_viljoen   = {'d', 'g'};  
label.tW_viljoen = {'time', 'wet weight'};
temp.tW_viljoen    = C2K(25);  
units.temp.tW_viljoen = 'K'; 
label.temp.tW_viljoen = 'temperature';
bibkey.tW_viljoen = 'Viljoen1991'; 
comment.tW_viljoen='Digitized from Viljoen_et_al_1991_Fig1.csv';

data.tR_viljoen = [ ... % time since birth (d), cumulative cocoons/worm
0   0
30  10
60  25
90  40
120 60
150 80
180 100
200 120
];
units.tR_viljoen   = {'d', '#'};  
label.tR_viljoen = {'time', 'cumulative cocoons/worm'};
temp.tR_viljoen    = C2K(25);  
units.temp.tR_viljoen = 'K'; 
label.temp.tR_viljoen = 'temperature';
bibkey.tR_viljoen = 'Viljoen1991'; 
comment.tR_viljoen='Digitized from Viljoen_et_al_1991_Fig3.csv';

data.tW_kovacevic = [ ... % time (d), wet weight (g) at 0 mg/kg TEB
0   0.010
14  0.025
28  0.060
42  0.120
56  0.200
70  0.300
84  0.400
];
units.tW_kovacevic   = {'d', 'g'};  
label.tW_kovacevic = {'time', 'wet weight'};
temp.tW_kovacevic    = C2K(20);  
units.temp.tW_kovacevic = 'K'; 
label.temp.tW_kovacevic = 'temperature';
bibkey.tW_kovacevic = 'Kovacevic2023'; 
comment.tW_kovacevic='Digitized from Kovacevic_et_al_2023_Fig3.csv, control (0 mg/kg TEB)';

data.tR_morgan = [ ... % time (weeks), cumulative cocoons/worm
0   0
2   5
4   15
6   28
8   40
];
units.tR_morgan   = {'wk', '#'};  
label.tR_morgan = {'time', 'cumulative cocoons/worm'};
temp.tR_morgan    = NaN; % temperature not specified
units.temp.tR_morgan = 'K'; 
label.temp.tR_morgan = 'temperature';
bibkey.tR_morgan = 'Plytycz2015'; 
comment.tR_morgan='Digitized from Plytycz_Morgan_2015_Fig1.csv, temperature not specified';

data.tW_data1 = [ ... % time (d), wet weight (g)
0    0.0239
30   0.231
100  1.970
140  2.330
200  2.200
];
units.tW_data1   = {'d', 'g'};
label.tW_data1   = {'time', 'wet weight'};
temp.tW_data1    = C2K(25);
units.temp.tW_data1 = 'K';
label.temp.tW_data1 = 'temperature';
bibkey.tW_data1 = 'Viljoen1991';
comment.tW_data1 = 'Growth data from data1.csv (Viljoen et al. 1991), cattle manure, 25C, 75-80% moisture';

data.tRrate_data1 = [ ... % time (d), cocoon production rate (cocoons/worm/day)
110  0.4
130  0.4
200  0.43
];
units.tRrate_data1   = {'d', 'cocoons/worm/day'};
label.tRrate_data1   = {'time', 'cocoon production rate'};
temp.tRrate_data1    = C2K(25);
units.temp.tRrate_data1 = 'K';
label.temp.tRrate_data1 = 'temperature';
bibkey.tRrate_data1 = 'Viljoen1991';
comment.tRrate_data1 = 'Cocoon production rate from data1.csv (Viljoen et al. 1991), cattle manure, 25C, 75-80% moisture';

% --- Univariate data from new CSVs ---

% Cocoon production rate vs. temperature
data.T_Ri = [ ...
    15 0.5
    25 0.8
];
units.T_Ri = {'C', 'cocoons/worm/d'};
label.T_Ri = {'temperature', 'cocoon production rate'};
temp.T_Ri = NaN; % temperature is independent variable
units.temp.T_Ri = '';
label.temp.T_Ri = '';
bibkey.T_Ri = 'Viljoen1991';
comment.T_Ri = 'Cocoon production rate at 15°C and 25°C (Viljoen et al. 1991)';

% Incubation period vs. temperature
data.T_ab = [ ...
    15 60
    25 40
];
units.T_ab = {'C', 'd'};
label.T_ab = {'temperature', 'incubation period'};
temp.T_ab = NaN;
units.temp.T_ab = '';
label.temp.T_ab = '';
bibkey.T_ab = 'Viljoen1991';
comment.T_ab = 'Incubation period at 15°C and 25°C (Viljoen et al. 1991)';

% Hatching success vs. temperature
data.T_hs = [ ...
    15 70
    25 60
];
units.T_hs = {'C', '%'};
label.T_hs = {'temperature', 'hatching success'};
temp.T_hs = NaN;
units.temp.T_hs = '';
label.temp.T_hs = '';
bibkey.T_hs = 'Viljoen1991';
comment.T_hs = 'Hatching success at 15°C and 25°C (Viljoen et al. 1991)';


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
set1 = {'tW_viljoen', 'tW_data1'}; subtitle1 = {'Growth: Viljoen et al. 1991'};
set2 = {'tR_viljoen'}; subtitle2 = {'Cumulative reproduction: Viljoen et al. 1991'};
set3 = {'tRrate_data1'}; subtitle3 = {'Reproduction rate: Viljoen et al. 1991'};
metaData.grp.sets = {set1, set2, set3};
metaData.grp.subtitle = {subtitle1, subtitle2, subtitle3};

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

bibkey = 'Plytycz2015'; type = 'Article'; bib = [ ...
'author = {Plytycz, B. and Morgan, A.J.}, ' ...
'year = {2015}, ' ...
'title = {Interactions between earthworm neuroendocrine and immune systems}, ' ...
'journal = {Invertebrate Survival Journal}, ' ...
'volume = {12}, ' ...
'pages = {42-52}'];
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

bibkey = 'Podolak2020'; type = 'Article'; bib = [ ...
'author = {Podolak, A. and Kostecka, J. and Babczyńska, A.}, ' ...
'year = {2020}, ' ...
'title = {Life Cycle of the Eisenia fetida and Dendrobaena veneta Earthworms (Oligohaeta, Lumbricidae)}, ' ...
'journal = {Journal of Ecological Engineering}, ' ...
'volume = {21}, ' ...
'number = {2}, ' ...
'pages = {188-197}, ' ...
'doi = {10.12911/22998993/116354}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

disp('DEBUG: size of data.tW_viljoen at end of mydata_Dendrobena_veneta:');
disp(size(data.tW_viljoen));
disp('DEBUG: data.tW_viljoen at end of mydata_Dendrobena_veneta:');
disp(data.tW_viljoen);

