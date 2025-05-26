import numpy as np
from scipy.integrate import solve_ivp
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import least_squares

# Example DEB parameters (to be estimated from your data)
params = {
    'kap': 0.8,         # Fraction of mobilized reserve allocated to soma
    'v': 0.02,          # Energy conductance (1/d)
    'p_Am': 50,         # Max assimilation rate (mg/d)
    'E_G': 0.5,         # Cost for structure (mg/mg)
    'E_m': 200,         # Reserve capacity (mg/mg)
    'k_J': 0.002,       # Maturity maintenance rate coefficient (1/d)
    'E_Hp': 100,        # Maturity at puberty (mg)
    'kappa_R': 0.95,    # Reproduction efficiency
}

def temp_correction(T, T_A=8000, T_ref=293.15):
    """Arrhenius temperature correction (T in Kelvin)."""
    return np.exp(T_A * (1/T_ref - 1/T))

def deb_odes(t, y, p, T=293.15):
    E, W, E_H, E_R = y
    # Temperature correction
    TC = temp_correction(T)
    # Assimilation (constant food, max rate)
    p_A = p['p_Am'] * TC
    # Mobilization
    p_C = E * (p['v'] * TC / W)
    # Growth
    p_G = p['kap'] * p_C - p['E_G'] * (W ** (2/3))
    # Maturity maintenance
    p_J = p['k_J'] * TC * E_H
    # Maturation/reproduction
    if E_H < p['E_Hp']:
        dE_H = (1 - p['kap']) * p_C - p_J
        dE_R = 0
    else:
        dE_H = 0
        dE_R = (1 - p['kap']) * p_C - p_J
    # ODEs
    dE = p_A - p_C
    dW = p_G / p['E_G']
    return [dE, dW, dE_H, dE_R]

# Initial conditions (estimate from your data)
E0 = 10   # mg
W0 = 23.9 # mg (from viljoen_1.csv, day 0)
E_H0 = 0
E_R0 = 0

y0 = [E0, W0, E_H0, E_R0]
t_span = (0, 200)
t_eval = np.linspace(0, 200, 201)

sol = solve_ivp(deb_odes, t_span, y0, args=(params,), t_eval=t_eval)

# Load growth data
df_growth = pd.read_csv('data/viljoen_1.csv')
times_growth = df_growth['Time_or_Condition'].str.replace('_days','').astype(float).values
obs_mass = df_growth['Value'].values

# Load reproduction data (adjust filename/columns as needed)
df_repro = pd.read_csv('data/viljoen_3.csv')
times_repro = df_repro['Time_or_Condition'].str.replace('_days','').astype(float).values
obs_repro = df_repro['Value'].values

T_sim = 293.15

def model_mass_and_repro(params_vec):
    # Unpack parameters to fit
    p = params.copy()
    p['kap'], p['v'], p['p_Am'], p['E_G'] = params_vec
    y0 = [E0, W0, E_H0, E_R0]
    # Simulate over the union of all time points
    all_times = np.unique(np.concatenate([times_growth, times_repro]))
    sol = solve_ivp(lambda t, y: deb_odes(t, y, p, T_sim), (all_times[0], all_times[-1]), y0, t_eval=all_times)
    # Interpolate to match data time points
    mass_interp = np.interp(times_growth, all_times, sol.y[1])
    repro_interp = np.interp(times_repro, all_times, sol.y[3])
    return mass_interp, repro_interp

def residuals(params_vec):
    pred_mass, pred_repro = model_mass_and_repro(params_vec)
    # Optionally, scale/weight the residuals
    res_mass = pred_mass - obs_mass
    res_repro = (pred_repro - obs_repro) / max(obs_repro)  # scale reproduction
    return np.concatenate([res_mass, res_repro])

# Initial guesses for parameters to fit: [kap, v, p_Am, E_G]
x0 = [0.8, 0.02, 50, 0.5]
bounds = ([0.5, 0.001, 10, 0.1], [0.99, 0.1, 200, 2.0])

result = least_squares(residuals, x0, bounds=bounds)
fitted_params = result.x
print("Fitted parameters:", fitted_params)

# Use fitted parameters for final simulation
params['kap'], params['v'], params['p_Am'], params['E_G'] = fitted_params
all_times = np.linspace(0, 200, 201)
sol = solve_ivp(lambda t, y: deb_odes(t, y, params, T_sim), (all_times[0], all_times[-1]), y0, t_eval=all_times)

plt.plot(sol.t, sol.y[1], label='Model mass')
plt.plot(sol.t, sol.y[3], label='Model reproduction buffer')
plt.scatter(times_growth, obs_mass, color='red', label='Growth data')
plt.scatter(times_repro, obs_repro, color='green', label='Reproduction data')
plt.xlabel('Time (days)')
plt.ylabel('Wet Mass (mg) / Repro Buffer (mg)')
plt.legend()
plt.show()