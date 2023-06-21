#  Copyright 2023 Aix-Marseille Université
# "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
import os
import numpy as np
from scipy.io.matlab import loadmat
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

def function_fit_exponential(x, a, b, c, d, e, f):
    return a * np.exp(d + b * x + e * x**2 + f * x**3) + c


def function_fit_factor(x, a, b, c, d, e, f):
    return a / (d + b * x + e * x**2 + f * x**3) + c

path = os.path.dirname(__file__) + '/../../matlab/Polynomial/'
data_0 = np.concatenate([loadmat(path + '/P_e_1/P_e_1_b.mat')['x'], loadmat(path + '/P_e_1/P_e_1_f.mat')['x']], axis=1)
data_1 = np.concatenate([loadmat(path + '/P_e_1/P_e_1_b.mat')['x'], loadmat(path + '/P_e_1/P_e_1_f.mat')['x']], axis=1)
data_2 = np.concatenate([loadmat(path + '/P_e_2/P_e_2_b.mat')['x'], loadmat(path + '/P_e_2/P_e_2_f.mat')['x']], axis=1)
data_3 = np.concatenate([loadmat(path + '/P_e_3/P_e_3_b.mat')['x'], loadmat(path + '/P_e_3/P_e_3_f.mat')['x']], axis=1)
data_4 = np.concatenate([loadmat(path + '/P_e_4/P_e_4_b.mat')['x'], loadmat(path + '/P_e_4/P_e_4_f.mat')['x']], axis=1)

# p0 =[100, -1000, 0.0, -10.0], # exponential P_1
# p0 = [1, -1000.0, 0.0, -1.5], # 1/x P_1
# p0=[1, -10000.0, 0.0, 100.0], # 1/x P2
# p0=[1, 100, 0, -4.5],         # exponential P2
for data, P_ex, P_fa in [
    (data_0, [100, -1000, 0.0, -10.0, 0.0, 0.0], [1, -1000.0, 0.0, -1.5, 0.0, 0.0]),
    (data_1, [100, -1000, 0.0, -10.0, 0.0, 0.0], [1, -1000.0, 0.0, -1.5, 0.0, 0.0]),
    (data_2, [1, 100, 0, -4.5, 0.0, 0.0], [1, -10000.0, 0.0, 100.0, 0.0, 0.0]),
    (data_3, [1, 100, 0, -4.5, 0.0, 0.0], [1, -10000.0, 0.0, 100.0, 0.0, 0.0])]:
    x = data[5, :]
    y = data[0, :]

    # plt.figure()
    # plt.scatter(x, y, label='Raw data')
    for function_fit, p_0 in [(function_fit_factor, P_fa), (function_fit_exponential, P_ex)]:
        popt, pcov = curve_fit(function_fit, x, y, p_0, maxfev=50000)
        x_fitted = np.linspace(np.min(x), np.max(x), 1000)
        y_fitted = function_fit(x_fitted, *popt)

        # plt.figure()
        # plt.plot(x_fitted, y_fitted, label='fit')

        plt.figure()
        plt.scatter(x, y, label='log raw data', s=0.1)
        plt.plot(x_fitted, y_fitted, label='fit')
        plt.legend()

plt.show()