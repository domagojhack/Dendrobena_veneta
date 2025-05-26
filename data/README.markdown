# README: CSV Glossary for Dendrobaena veneta DEB Modeling Data

This repository contains CSV files with raw data extracted from graphs in scientific papers, suitable for Dynamic Energy Budget (DEB) modeling of *Dendrobaena veneta*. Each CSV corresponds to a specific graph and includes measurements for life history traits (e.g., growth, reproduction, development) under specified conditions. Below is a glossary describing each CSV file, its contents, source, and relevance to DEB modeling.

## CSV Files

### Viljoen_et_al_1991_Fig1.csv
- **Description**: Biomass (wet weight, mg) of *D. veneta* over 200 days, starting from hatchlings.
- **Source**: Figure 1 in Viljoen et al. (1991), *South African Journal of Zoology*.
- **Conditions**: 25°C, urine-free cattle manure substrate, 75–80% moisture, ad libitum food.
- **DEB Relevance**: Provides univariate growth data (biomass vs. time) for estimating assimilation rate ({p_Am}), energy conductance (v), and allocation fraction to soma (kap).
- **Columns**: `Data_Type`, `Value` (mg), `Units`, `Time_or_Condition` (days), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Viljoen_et_al_1991_Fig2.csv
- **Description**: Percentage of worms with developed clitellum (% mature) over time, indicating sexual maturation.
- **Source**: Figure 2 in Viljoen et al. (1991).
- **Conditions**: 25°C, cattle manure, 75–80% moisture.
- **DEB Relevance**: Tracks maturation progress, useful for estimating maturity threshold at puberty (E_Hp) and age at puberty.
- **Columns**: `Data_Type`, `Value` (%), `Units`, `Time_or_Condition` (days), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Viljoen_et_al_1991_Fig3.csv
- **Description**: Cocoon production rate (cocoons/worm/day) over 200 days.
- **Source**: Figure 3 in Viljoen et al. (1991).
- **Conditions**: 25°C, cattle manure, 75–80% moisture.
- **DEB Relevance**: Provides univariate reproduction data for estimating reproduction efficiency (kap_R) and maximum reproduction rate.
- **Columns**: `Data_Type`, `Value` (cocoons/worm/day), `Units`, `Time_or_Condition` (days), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Viljoen_et_al_1991_Fig5.csv
- **Description**: Number of cocoons per incubation period range (days) for 643 cocoons.
- **Source**: Figure 5 in Viljoen et al. (1991).
- **Conditions**: 25°C, cattle manure, 75–80% moisture.
- **DEB Relevance**: Quantifies incubation period distribution, aiding estimation of development time from egg to hatching.
- **Columns**: `Data_Type`, `Value` (cocoons), `Units`, `Time_or_Condition` (day range), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Viljoen_et_al_1991_Fig6.csv
- **Description**: Percentage of cocoons producing 1 or 2 hatchlings.
- **Source**: Figure 6 in Viljoen et al. (1991).
- **Conditions**: 25°C, cattle manure, 75–80% moisture.
- **DEB Relevance**: Provides zero-variate data on hatchlings per cocoon, useful for reproduction output calculations.
- **Columns**: `Data_Type`, `Value` (%), `Units`, `Time_or_Condition` (hatchlings), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Trigui_et_al_2022_Fig1.csv
- **Description**: Relative earthworm weight (% of control) after 7 and 28 days at different OMW-contaminated soil (OMW CS) ratios (0%, 5%, 10%, 25%, 50%).
- **Source**: Figure 1 in Trigui et al. (2022), *Environmental Science and Pollution Research*.
- **Conditions**: 20°C, artificial soil (70% quartz sand, 20% kaolin clay, 10% sphagnum peat) mixed with OMW CS, 40% moisture, 12:12 light:dark cycle.
- **DEB Relevance**: Indicates weight changes under stress, useful for modeling stress effects on growth and maintenance (DEBtox).
- **Columns**: `Data_Type`, `Value` (%), `Units`, `Time_or_Condition` (OMW CS % and days), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Trigui_et_al_2022_Fig3.csv
- **Description**: Lipid content (% of control) after 7 and 28 days at different OMW CS ratios.
- **Source**: Figure 3 in Trigui et al. (2022).
- **Conditions**: 20°C, artificial soil + OMW CS, 40% moisture.
- **DEB Relevance**: Proxy for energy reserves, informing reserve dynamics ([E]) under stress conditions.
- **Columns**: `Data_Type`, `Value` (%), `Units`, `Time_or_Condition` (OMW CS % and days), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Kovacevic_et_al_2023_Fig1.csv
- **Description**: Percentage of cocoons hatched over time (days) at different tebuconazole (TEB) concentrations (0, 1, 5, 25, 50, 100 mg/kg).
- **Source**: Figure 1 in Kovačević et al. (2023), *Agriculture*.
- **Conditions**: 20°C, artificial soil, 50% water-holding capacity (WHC), 16:8 light:dark cycle, horse manure food.
- **DEB Relevance**: Provides hatching dynamics for estimating development time and hatching success under chemical stress.
- **Columns**: `Data_Type`, `Value` (%), `Units`, `Time_or_Condition` (days and TEB mg/kg), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Kovacevic_et_al_2023_Fig2.csv
- **Description**: Body mass (mg) of newly hatched juveniles at different TEB concentrations.
- **Source**: Figure 2 in Kovačević et al. (2023).
- **Conditions**: 20°C, artificial soil, 50% WHC.
- **DEB Relevance**: Zero-variate data for initial hatchling mass, critical for growth model initialization.
- **Columns**: `Data_Type`, `Value` (mg), `Units`, `Time_or_Condition` (TEB mg/kg), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Kovacevic_et_al_2023_Fig3.csv
- **Description**: Juvenile body mass (g) over time (days) at 0 and 100 mg/kg TEB concentrations.
- **Source**: Figure 3 in Kovačević et al. (2023).
- **Conditions**: 20°C, artificial soil, 50% WHC.
- **DEB Relevance**: Univariate growth data for estimating growth parameters under control and stress conditions.
- **Columns**: `Data_Type`, `Value` (g), `Units`, `Time_or_Condition` (days and TEB mg/kg), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Plytycz_Morgan_2015_Fig1.csv
- **Description**: Cumulative cocoons per worm over 8 weeks for untreated (control) *D. veneta*.
- **Source**: Figure 1 in Plytycz & Morgan (2015), *Invertebrate Survival Journal*.
- **Conditions**: Not specified (laboratory conditions assumed).
- **DEB Relevance**: Univariate reproduction data for estimating reproduction rates in baseline conditions.
- **Columns**: `Data_Type`, `Value` (cocoons/worm), `Units`, `Time_or_Condition` (weeks), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Amaroli_et_al_2018_Fig9.csv
- **Description**: Telomerase activity (attomoles/μg protein) at 24, 48, 72, 96 hours for non-irradiated (control) samples.
- **Source**: Figure 9 in Amaroli et al. (2018), *European Journal of Histochemistry*.
- **Conditions**: 22°C, substrate not specified.
- **DEB Relevance**: Indirect proxy for cellular proliferation, potentially informing growth dynamics.
- **Columns**: `Data_Type`, `Value` (attomoles/μg protein), `Units`, `Time_or_Condition` (hours), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

### Amaroli_et_al_2018_Fig10.csv
- **Description**: HSP70 expression (% relative to uncut worms) at 24 and 48 hours for non-irradiated samples.
- **Source**: Figure 10 in Amaroli et al. (2018).
- **Conditions**: 22°C, substrate not specified.
- **DEB Relevance**: Limited; indicates stress response, marginally relevant for DEBtox modeling.
- **Columns**: `Data_Type`, `Value` (%), `Units`, `Time_or_Condition` (hours), `Temperature_C`, `Substrate`, `Moisture`, `Source`.

## Notes
- **Data Extraction**: Values are visually estimated from graphs where exact numbers are not provided in the text. Exact values from tables (e.g., Kovačević et al., 2023) are used where available.
- **Units**: Standardized for DEB modeling (e.g., mg or g for biomass, days for time, cocoons/worm/day for reproduction).
- **Conditions**: Temperature, substrate, and moisture are included where specified; missing conditions (e.g., Plytycz & Morgan, 2015) noted as "Not_specified".
- **Usage**: Import CSVs into DEBtool (MATLAB) for parameter estimation. Combine with *Eisenia fetida* parameters from Add-my-Pet for initial guesses.
- **Limitations**: No ingestion or respiration rate data; limited temperature range (20–25°C). Additional experiments may be needed.

## Sources
- Viljoen et al. (1991). *Life-cycle of the European compost worm Dendrobaena veneta (Oligochaeta)*. South African Journal of Zoology.
- Trigui et al. (2022). *Effects of olive mill waste (OMW) contaminated soil on biochemical biomarkers and reproduction of Dendrobaena veneta*. Environmental Science and Pollution Research.
- Kovačević et al. (2023). *Effects of Tebuconazole on the Earthworm Dendrobaena veneta: Full Life Cycle Approach*. Agriculture.
- Plytycz & Morgan (2015). *Interactions between earthworm neuroendocrine and immune systems*. Invertebrate Survival Journal.
- Amaroli et al. (2018). *The earthworm Dendrobaena veneta (Annelida): A new experimental-organism for photobiomodulation and wound healing*. European Journal of Histochemistry.