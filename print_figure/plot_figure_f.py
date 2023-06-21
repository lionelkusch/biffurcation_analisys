#  Copyright 2023 Aix-Marseille Université
# "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
import os
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy.io.matlab import loadmat


path = os.path.dirname(__file__) + '/../matlab/'
H_LP = True
cmap = plt.get_cmap('jet')
norm = mpl.colors.Normalize(vmin=-100, vmax=100)
limit_circle = True

# b_data = loadmat(path + '/b_30/EQ_Low/EQ_Low.mat', chars_as_strings=True, simplify_cells=True)
# b_data = loadmat(path + '/b_60/EQ_Low/EQ_Low.mat', chars_as_strings=True, simplify_cells=True)
b_data = loadmat(path + '/EQ_Low/EQ_low.mat', chars_as_strings=True, simplify_cells=True)
b_data['x'][:2] *= 1000
b_data['x'][-1] *= 1000

plt.figure()
plt.plot(np.flip(b_data['h'][-3:, :].T), '.')
plt.plot(np.flip(b_data['h'][-3:, :].T), alpha=0.2)
plt.hlines(0.0, 0.0, b_data['h'].shape[1])
plt.figure()
plt.plot(b_data['x'][0], b_data['h'][-3:, :].T, '.')
plt.plot(b_data['x'][0], b_data['h'][-3:, :].T, alpha=0.2)
plt.hlines(0.0, 0.0, np.max(b_data['x'][0]))
plt.figure()
plt.plot(b_data['f'].T, '.')
plt.plot(b_data['f'].T, alpha=0.2)
plt.hlines(0.0, 0.0, b_data['f'].shape[1])
plt.figure()
plt.plot(b_data['x'][0], b_data['f'].T, '.')
plt.plot(b_data['x'][0], b_data['f'].T, alpha=0.2)
plt.hlines(0.0, 0.0, np.max(b_data['x'][0]))
plt.show()
