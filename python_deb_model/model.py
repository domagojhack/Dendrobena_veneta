import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt

# Parameters from pars_init_Dendrobena_veneta.m
params = {
    'kap': 0.58,         # allocation fraction to soma
    'kap_R': 0.475,      # reproduction efficiency (hermaphroditic)
    'v': 0.015,          # cm/d, energy conductance
    'p_M': 4800,         # J/d.cm^3, vol-spec somatic maint
    'p_T': 0,            # J/d.cm^2, surf-spec somatic maint
    'k_J': 0.002,        # 1/d, maturity maintenance rate coefficient
    'E_G': 4200,         # J/cm^3, spec cost for structure
    'E_Hb': 5.2,         # J, maturity at birth
    'E_Hp': 1050,        # J, maturity at puberty
    'del_M': 0.13,       # shape coefficient
    'f': 1.0,            # scaled functional response
    'z': 0.35,           # zoom factor
    'F_m': 6.5,          # l/d.cm^2, max spec searching rate
    'kap_X': 0.8,        # digestion efficiency of food to reserve
    'kap_P': 0.1,        # faecation efficiency of food to faeces
    'h_a': 1.6e-08,      # 1/d^2, Weibull aging acceleration
    's_G': 0.0001,       # Gompertz stress coefficient
    # Add more as needed
}

# Derived parameters (simplified for this example)
def compute_derived(params):
    # Maximum structural length (cm)
    L_m = params['z'] * params['v'] / (params['kap'] * params['p_M'])
    # Reserve capacity [E_m] (J/cm^3)
    E_m = params['p_M'] / params['kap'] / params['v']
    # Energy investment ratio (g)
    g = params['E_G'] / params['kap'] / E_m
    return L_m, E_m, g

L_m, E_m, g = compute_derived(params)

def deb_odes(t, y, params):
    # State variables: [E, L, E_H, E_R]
    E, L, E_H, E_R = y

    # Unpack parameters
    kap = params['kap']
    kap_R = params['kap_R']
    v = params['v']
    p_M = params['p_M']
    p_T = params['p_T']
    k_J = params['k_J']
    E_G = params['E_G']
    E_Hb = params['E_Hb']
    E_Hp = params['E_Hp']
    f = params['f']
    del_M = params['del_M']

    # Derived
    L_m, E_m, g = compute_derived(params)
    # Surface area
    SA = L**2
    # Volume
    V = L**3

    # Assimilation (J/d)
    p_Am = E_m * v
    p_A = f * p_Am * SA

    # Mobilization (J/d)
    p_C = E * (v / L + p_M) / (E + E_G * V)

    # Somatic maintenance (J/d)
    p_S = p_M * V + p_T * SA

    # Growth (J/d)
    p_G = kap * p_C - p_S

    # Maturity maintenance (J/d)
    p_J = k_J * E_H

    # ODEs
    dE = p_A - p_C
    dL = p_G / (3 * E_G * L**2) if L > 0 else 0
    if E_H < E_Hp:
        dE_H = (1 - kap) * p_C - p_J
        dE_R = 0
    else:
        dE_H = 0
        dE_R = (1 - kap) * p_C - p_J

    return [dE, dL, dE_H, dE_R]

# Initial conditions (example, adjust as needed)
E_0 = 0.01 * E_m * L_m**3  # Initial reserve
L_0 = 0.1                  # Initial length (cm)
E_H_0 = 0                  # Initial maturity
E_R_0 = 0                  # Initial reproduction buffer

y0 = [E_0, L_0, E_H_0, E_R_0]
t_span = (0, 200)
t_eval = np.linspace(*t_span, 500)

sol = solve_ivp(deb_odes, t_span, y0, args=(params,), t_eval=t_eval)

# Plot results
plt.plot(sol.t, sol.y[0], label='Reserve (E)')
plt.plot(sol.t, sol.y[1], label='Length (L)')
plt.plot(sol.t, sol.y[2], label='Maturity (E_H)')
plt.plot(sol.t, sol.y[3], label='Reproduction buffer (E_R)')
plt.legend()
plt.xlabel('Time (d)')
plt.ylabel('State variables')
plt.title('DEB Model for Dendrobena veneta')
plt.show()