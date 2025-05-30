import pandas as pd
import numpy as np

df = pd.read_csv("viljoen2_1.csv", header=None, names=["days", "weight"])

df1 = df.iloc[0:41, :]
df2 = df.iloc[42:, :]

# df1 contains a duplicate row
df1 = df1.drop_duplicates(subset=["days", "weight"])
df2 = df2.drop_duplicates(subset=["days", "weight"])


df1.plot(
    x="days", y="weight",
    title="Weight vs Days (First 41 Rows)",
    xlabel="Days", ylabel="Weight"
    )

df2.plot(
    x="days", y="weight",
    title="Weight vs Days (Last Rows)",
    xlabel="Days", ylabel="Weight"
    )

df1["days"] = np.arange(5, 205, 5)
df2["days"] = np.arange(5, 205, 5)

df1["weight"] = df1["weight"].round(2)
df2["weight"] = df2["weight"].round(2)

#df1 is at 15°C
#df2 is at 25°C

df1.to_csv("viljoen2_1_15C.csv", index=False)
df2.to_csv("viljoen2_1_25C.csv", index=False)

df1.plot(
    x="days", y="weight",
    title="Weight vs Days (First 41 Rows) - 15°C",
    xlabel="Days", ylabel="Weight"
    )
df2.plot(
    x="days", y="weight",
    title="Weight vs Days (Last Rows) - 25°C",
    xlabel="Days", ylabel="Weight"
    )
