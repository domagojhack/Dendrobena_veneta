import pandas as pd
import numpy as np


data = [
    0,6,7,7,7,10,8,9,7,8,12,10,8,8
]

time = np.arange(0, len(data)*4, 4)

df = pd.DataFrame({
    "time": time,
    "data": data
})


# histogram of the data
df["data"] = df["data"].round(2)
df.plot.hist(
    y="data",
    title="Histogram of Data",
    xlabel="Data", ylabel="Frequency"
)

df.plot(
    x="time", y="data",
    title="Data vs Time",
    xlabel="Time (weeks)", ylabel="Data"
)


data = [
    6,7,7,7,10,8,9,7,8,12,10,8,8
]

time = np.arange(4, (len(data)*4)+4, 4)

df = pd.DataFrame({
    "time": time,
    "data": data
})
np.mean(data)/28
np.median(data)/28


# histogram of the data
df["data"] = df["data"].round(2)
df.plot.hist(
    y="data",
    title="Histogram of Data",
    xlabel="Data", ylabel="Frequency"
)

df.plot(
    x="time", y="data",
    title="Data vs Time",
    xlabel="Time (weeks)", ylabel="Data"
)



# transform time data to days
df["time"] = df["time"] * 7
# Save the DataFrame to a CSV file

df.to_csv("podolak_data.csv", index=False)


# next dataset


df = pd.read_csv("podolak_data2_raw.csv", header=None, names=["time", "weight"])
df["time"] = np.arange(0, len(df)*4, 4) 

# transform time data to days
df["time"] = df["time"] * 7

df["weight"]= df["weight"].round(2)

df.plot(
    x="time", y="weight",
    title="Weight(g) vs Time",
    xlabel="Time (weeks)", ylabel="Data"
)

df.to_csv("podolak_data2.csv", index=False)