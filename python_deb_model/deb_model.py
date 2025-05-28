import numpy as np
from scipy.integrate import solve_ivp
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import least_squares

# Example DEB parameters (to be estimated from your data)
params = {
    'kap': 0.8,
    'v': 0.02,
    'p_Am': 50,
    'E_G': 0.5,
    'E_m': 200,
    'k_J': 0.002,
    'E_Hb': 10,    # Maturity at birth/hatching
    'E_Hp': 100,   # Maturity at puberty
    'kappa_R': 0.95,
}

def temp_correction(T, T_A=8000, T_ref=293.15):
    """Arrhenius temperature correction (T in Kelvin)."""
    return np.exp(T_A * (1/T_ref - 1/T))

def deb_odes(t, y, p, T=293.15):
    E, W, E_H, E_R = y
    TC = temp_correction(T)
    p_A = p['p_Am'] * TC if E_H >= p['E_Hb'] else 0  # No assimilation before hatching
    p_C = E * (p['v'] * TC / W) if W > 0 else 0
    p_G = p['kap'] * p_C - p['E_G'] * (W ** (2/3)) if W > 0 else 0
    p_J = p['k_J'] * TC * E_H

    # Stage logic
    if E_H < p['E_Hb']:
        # Cocoon: only maturation, no assimilation or growth
        dE = 0
        dW = 0
        dE_H = p_C - p_J
        dE_R = 0
    elif E_H < p['E_Hp']:
        # Juvenile: growth and maturation
        dE = p_A - p_C
        dW = p_G / p['E_G']
        dE_H = (1 - p['kap']) * p_C - p_J
        dE_R = 0
    else:
        # Adult: growth and reproduction
        dE = p_A - p_C
        dW = p_G / p['E_G']
        dE_H = 0
        dE_R = (1 - p['kap']) * p_C - p_J
    return [dE, dW, dE_H, dE_R]

# Initial conditions (estimate from your data)
E0 = 10   # mg

# --- Load additional datasets ---
df_maturation = pd.read_csv('data/viljoen_2.csv')
times_maturation = df_maturation['Time_or_Condition'].str.replace('_days','').astype(float).values
obs_maturation = df_maturation['Value'].values / 100.0  # Convert % to fraction

df_hatch_mass = pd.read_csv('data/kovacevic_2.csv')
hatch_mass = df_hatch_mass[df_hatch_mass['Time_or_Condition'] == '0_mg/kg']['Value'].mean()  # mg

# --- Update initial conditions based on hatchling mass ---
W0 = hatch_mass if not np.isnan(hatch_mass) else 23.9
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

# --- Add a function to convert E_R to cocoons/worm/day ---
def reproduction_rate(E_R, dt, cocoon_cost=100):
    # E_R: array of reproduction buffer values
    # dt: array of time intervals (should be len(E_R)-1)
    cocoons = np.diff(E_R) / cocoon_cost
    cocoons = np.maximum(cocoons, 0)
    return cocoons / dt  # dt matches the length of np.diff(E_R)

# --- Update model_mass_and_repro to also return maturation and cocoons ---
def model_outputs(params_vec):
    p = params.copy()
    p['kap'], p['v'], p['p_Am'], p['E_G'] = params_vec
    y0 = [E0, W0, E_H0, E_R0]
    all_times = np.unique(np.concatenate([times_growth, times_repro, times_maturation]))
    sol = solve_ivp(lambda t, y: deb_odes(t, y, p, T_sim), (all_times[0], all_times[-1]), y0, t_eval=all_times)
    mass_interp = np.interp(times_growth, all_times, sol.y[1])
    repro_buffer = np.interp(times_repro, all_times, sol.y[3])
    # Convert E_R to cocoons/worm/day
    dt = np.diff(times_repro)  # length = len(times_repro) - 1
    cocoons = reproduction_rate(repro_buffer, dt)
    # Maturation: fraction mature (E_H >= E_Hp)
    E_H_interp = np.interp(times_maturation, all_times, sol.y[2])
    frac_mature = (E_H_interp >= p['E_Hp']).astype(float)
    return mass_interp, cocoons, frac_mature

def residuals(params_vec):
    pred_mass, pred_cocoons, pred_mature = model_outputs(params_vec)
    res_mass = (pred_mass - obs_mass) / max(obs_mass)
    res_repro = (pred_cocoons - obs_repro[1:]) / max(obs_repro)
    res_mature = (pred_mature - obs_maturation)  # already 0-1
    return np.concatenate([res_mass, res_repro, res_mature])

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

# --- Separate plots for each output ---
fig, axs = plt.subplots(3, 1, figsize=(8, 12), sharex=True)

# Growth
axs[0].plot(sol.t, sol.y[1], label='Model mass')
axs[0].scatter(times_growth, obs_mass, color='red', label='Growth data')
axs[0].set_ylabel('Wet Mass (mg)')
axs[0].legend()

# Reproduction
dt = np.diff(sol.t)
cocoons = reproduction_rate(sol.y[3], dt)
axs[1].plot(sol.t[1:], cocoons, label='Model cocoons/worm/day')
axs[1].scatter(times_repro[1:], obs_repro[1:], color='green', label='Reproduction data')
axs[1].set_ylabel('Cocoons/worm/day')
axs[1].legend()

# Maturation
E_H_traj = sol.y[2]
frac_mature = (E_H_traj >= params['E_Hp']).astype(float)
axs[2].plot(sol.t, frac_mature, label='Model fraction mature')
axs[2].scatter(times_maturation, obs_maturation, color='purple', label='Maturation data')
axs[2].set_ylabel('Fraction mature')
axs[2].set_xlabel('Time (days)')
axs[2].legend()

plt.tight_layout()
plt.show()