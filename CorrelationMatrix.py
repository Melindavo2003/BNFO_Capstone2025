import warnings
warnings.filterwarnings('ignore')

import statsmodels.api as sm
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from statsmodels.multivariate.manova import MANOVA

# Load data
df = pd.read_csv(r'c:\\Users\\melin\\Downloads\\CorrelationMatrix.csv')
print(df.head)
df['Covid_Deaths'] = df['Covid_Deaths'].astype(str).str.replace(',', '').astype(float)

# create correlation matrix
corr = df.corr()
sm.graphics.plot_corr(corr, xnames=list(corr.columns))
plt.show()

print(corr)

