import numpy as np
from scipy.integrate import solve_ivp
from scipy.optimize import minimize
import matplotlib.pyplot as plt
from model import deb_odes, compute_derived, params

# Data
data_tW_viljoen = np.array([
    [0,   0.01],
    [30,  0.05],
    [60,  0.15],
    [90,  0.30],
    [120, 0.50],
    [150, 0.80],
    [180, 1.10],
    [200, 1.30]
])
obs_time = data_tW_viljoen[:, 0]
obs_weight = data_tW_viljoen[:, 1]

def model_wet_weight(L, E, d_V=1.0, w_E=0.2):
    return d_V * L**3 + w_E * E

def cost_function(free_params):
    v, kap = free_params
    params['v'] = v
    params['kap'] = kap
    L_m, E_m, g = compute_derived(params)
    L_0 = obs_weight[0] ** (1/3)
    E_0 = 0.01 * E_m * L_0**3
    E_H_0 = 0
    E_R_0 = 0
    y0 = [E_0, L_0, E_H_0, E_R_0]
    try:
        sol = solve_ivp(deb_odes, (obs_time[0], obs_time[-1]), y0, args=(params,), t_eval=obs_time, max_step=1.0)
        if not sol.success or np.any(np.isnan(sol.y)):
            return 1e6
        model_weight = model_wet_weight(sol.y[1], sol.y[0])
        return np.mean((model_weight - obs_weight) ** 2)
    except Exception:
        return 1e6

initial_guess = [0.015, 0.58]
bounds = [(0.005, 0.05), (0.4, 0.9)]
result = minimize(cost_function, initial_guess, bounds=bounds, method='L-BFGS-B')

print("Estimated parameters:")
print("v =", result.x[0])
print("kap =", result.x[1])

# Plot final fit
params['v'] = result.x[0]
params['kap'] = result.x[1]
L_m, E_m, g = compute_derived(params)
L_0 = obs_weight[0] ** (1/3)
E_0 = 0.01 * E_m * L_0**3
E_H_0 = 0
E_R_0 = 0
y0 = [E_0, L_0, E_H_0, E_R_0]
sol = solve_ivp(deb_odes, (obs_time[0], obs_time[-1]), y0, args=(params,), t_eval=obs_time, max_step=1.0)
model_weight = model_wet_weight(sol.y[1], sol.y[0])

plt.plot(obs_time, obs_weight, 'o', label='Observed')
plt.plot(obs_time, model_weight, '-', label='Model fit')
plt.xlabel('Time (d)')
plt.ylabel('Wet weight (g)')
plt.legend()
plt.title('Parameter estimation: DEB model fit to tW_viljoen')
plt.show()