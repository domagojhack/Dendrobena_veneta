import pandas as pd
import numpy as np
from pathlib import Path

datafiles = list(Path().glob("Fayolle*"))

for i in datafiles:
    
    
    
    
    
    
    df = pd.read_csv(i, header=None, names=["time", "weight"])
    
    
    if len(df) == 12:
        times = [0, 10, 20, 30, 40, 60, 80, 100, 120, 140, 160, 190]
    elif len(df) == 13:
        times = [0, 10, 20, 30, 40, 50, 60, 80, 100, 120, 140, 160, 190]
    print(df)


    df["time"] = times
    df["weight"] = df["weight"].round(2)
        
    
    df.to_csv("proc"+ str(i), index=False)