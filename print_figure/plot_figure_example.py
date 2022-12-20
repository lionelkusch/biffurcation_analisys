from scipy.io.matlab import loadmat
import os
from print_stability import print_stability
import matplotlib.pyplot as plt
import numpy as np


path = os.path.dirname(__file__) + '/../matlab/'

T_20 = loadmat(path + '/T_20/EQ_High/EQ_high.mat', chars_as_strings=True, simplify_cells=True)
T_20['x'][:2] *= 1000  # rescale the values
T_20['x'][-1] *= 1000  # rescale the values


fig = plt.figure()
line_T_20 = print_stability(T_20['x'], T_20['f'], T_20['s'], 6, 0, color='b')
plt.legend([ line_T_20], ['T=50', 'T=20', 'T=5'])
plt.ylim(ymax=200.0, ymin=0.0)
plt.xlim(xmax=200.0, xmin=-30.0)
plt.xlabel("external input")
plt.ylabel("firing rate of excitatory population Hz")
cax = plt.axes([0.05, 0.1, 0.9, 0.02])
plt.subplots_adjust(bottom=0.22, top=0.98)


plt.figure()
line_T_20 = print_stability(T_20['x'], T_20['f'], T_20['s'], 6, 1, color='b')
plt.legend([line_T_20], ['T=50', 'T=20', 'T=5'])
plt.ylim(ymax=200.0, ymin=0.0)
plt.xlim(xmax=200.0, xmin=-30.0)
plt.xlabel("external input")
plt.ylabel("firing rate of inhibitory population Hz")
cax = plt.axes([0.05, 0.1, 0.9, 0.02])
plt.subplots_adjust(bottom=0.22, top=0.98)

plt.figure()
line_T_20 = print_stability(T_20['x'], T_20['f'], T_20['s'], 0, 1, color='b')
plt.legend([line_T_20], ['T=50', 'T=20', 'T=5'])
plt.ylim(ymax=200.0, ymin=0.0)
plt.xlim(xmax=200.0, xmin=0.0)
plt.xlabel("firing rate of excitatory population Hz")
plt.ylabel("firing rate of inhibitory population Hz")
plt.subplots_adjust(bottom=0.22, top=0.98)

# print eigen values
plt.figure()
for i in range(6):
    plt.plot(np.real(T_20['f'][i]), np.imag(T_20['f'][i]),'.')

# print function for detecting bifurcation see matcont documentation
for i in range(3):
    plt.figure()
    plt.plot(T_20['h'][-i],'.',label='T_20')
    plt.legend()
plt.show()
