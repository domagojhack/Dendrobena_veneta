import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
df = pd.read_csv('viljoen_growth.csv', header=None)


np.round(df.values[:, 0], 0)

t = np.arange(5, 205, 5)

t - df.values[:, 0]

Ww = np.round(df.values[:, 1], 2)


new_df = pd.DataFrame({'t': t, 'Ww': Ww})
new_df.to_csv('data_tW_viljoen.csv', index=False)
# draw the data
plt.plot(new_df['t'], new_df['Ww']/1000, 'o-', label='Viljoen et al. (2019)')
plt.xlabel('Time (days)')
plt.ylabel('Ww (g)')
plt.title('Growth of Ww over Time')
plt.legend()

df = pd.read_csv('kovacevic_Ww.csv', header=None)



t = [0, 14, 28, 42, 63, 84, 105, 126, 197]

Ww = np.round(df.values[:, 1], 2)
new_df = pd.DataFrame({'t': t, 'Ww': Ww})
new_df.to_csv('data_tW_kovacevic.csv', index=False)


# draw the data
import matplotlib.pyplot as plt
plt.plot(new_df['t'], new_df['Ww'], 'o-', label='Kovacevic et al. (2019)')
plt.xlabel('Time (days)')
plt.ylabel('Ww (g)')
plt.title('Growth of Ww over Time')
plt.legend()