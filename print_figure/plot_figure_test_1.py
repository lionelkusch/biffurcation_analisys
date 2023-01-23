import os
import matplotlib.pyplot as plt
import numpy as np
from scipy.io.matlab import loadmat
from parameter_analyse.analyse_dynamic.print_figure.print_stability import print_stability


path_init = os.path.dirname(os.path.realpath(__file__)) + "/../../static/simulation/master_seed_0/"
path = os.path.dirname(__file__) + '/../../analyse_dynamic/matlab/'
# load bifurcation
b_30 = loadmat(path + '/b_30/EQ_Low/EQ_Low.mat', chars_as_strings=True, simplify_cells=True)
b_30['x'][:2] *= 1e3
b_30['x'][-1] *= 1e3
b_30['x'][2:5] *= 1e6

b_60 = loadmat(path + '/b_60/EQ_Low/EQ_Low.mat', chars_as_strings=True, simplify_cells=True)
b_60['x'][:2] *= 1e3
b_60['x'][-1] *= 1e3
b_60['x'][2:5] *= 1e6

b_0 = loadmat(path + '/EQ_Low/EQ_low.mat', chars_as_strings=True, simplify_cells=True)
b_0['x'][:2] *= 1e3
b_0['x'][-1] *= 1e3
b_0['x'][2:5] *= 1e6
b_0['x'] = np.vstack((b_0['x'][:5], np.zeros((1, b_0['x'].shape[1]), ), b_0['x'][5]))
# b_0['f'] = np.vstack((b_0['f'], np.zeros((1, b_0['f'].shape[1]))))

# get network result
network_0 = np.concatenate([np.expand_dims(range(100), axis=1), np.load(path_init + '/0.0_mean_var.npy')], axis=1)
network_30 = np.concatenate([np.expand_dims(range(100), axis=1), np.load(path_init + '/30.0_mean_var.npy')], axis=1)
network_60 = np.concatenate([np.expand_dims(range(100), axis=1), np.load(path_init + '/60.0_mean_var.npy')], axis=1)

fig, axs = plt.subplots(1, 5, figsize=(20, 10))
plt.sca(axs[0])
line_b_0 = print_stability(b_0['x'], b_0['f'], b_0['s'], 6, 1, color='k', letter=True, linewidth=1.0)
line_b_30 = print_stability(b_30['x'], b_30['f'], b_30['s'], 6, 1, color='b', letter=True, linewidth=1.0)
line_b_60 = print_stability(b_60['x'], b_60['f'], b_60['s'], 6, 1, color='g', letter=True, linewidth=1.0)
plt.legend([line_b_60, line_b_30, line_b_0], ['b=60', 'b=30', 'b=0'], loc='lower right')
plt.ylim(ymax=200.0, ymin=-1.0)
plt.xlim(xmax=200.0, xmin=-1.0)
plt.vlines(0.0, ymin=-30.0, ymax=200.0, color='m')
plt.xticks([-30.0, 0.0, 50.0, 100.0])
plt.yticks([0.0, 100.0, 200.0])
plt.xlabel("external input")
plt.ylabel("firing rate of excitatory population Hz")

plt.sca(axs[1])
plt.plot(network_0[:, 0], network_0[:, 3], 'xk', ms=5.0, label='b=0')
plt.plot(network_30[:, 0], network_30[:, 3], 'xb', ms=5.0, label='b=30')
plt.plot(network_60[:, 0], network_60[:, 3], 'xg', ms=5.0, label='b=60')
plt.legend(loc='lower right')
plt.ylim(ymax=200.0, ymin=-1.0)
plt.xlim(xmax=100.0, xmin=-1.0)
plt.vlines(0.0, ymin=-30.0, ymax=200.0, color='m')
plt.xticks([0.0, 50.0, 100.0])
plt.yticks([0.0, 100.0, 200.0], labels=[])
plt.xlabel("external input")

plt.sca(axs[2])
line_b_0 = print_stability(b_0['x'], b_0['f'], b_0['s'], 6, 1, color='k', letter=False, linewidth=1.0)
line_network_0, = plt.plot(network_0[:, 0], network_0[:, 3], 'xk', ms=5.0)
plt.legend([line_network_0, line_b_0], ['network', 'mean field'], loc='lower right')
plt.ylim(ymax=200.0, ymin=-1.0)
plt.xlim(xmax=100.0, xmin=-1.0)
plt.vlines(0.0, ymin=-30.0, ymax=200.0, color='m')
plt.xticks([0.0, 50.0, 100.0])
plt.yticks([0.0, 100.0, 200.0], labels=[])
plt.xlabel("external input")

plt.sca(axs[3])
line_b_30 = print_stability(b_30['x'], b_30['f'], b_30['s'], 6, 1, color='b', letter=False, linewidth=1.0)
line_network_30, = plt.plot(network_30[:, 0], network_30[:, 3], 'xb', ms=5.0)
plt.legend([line_network_30, line_b_30], ['network', 'mean field'], loc='lower right')
plt.ylim(ymax=200.0, ymin=-1.0)
plt.xlim(xmax=100.0, xmin=-1.0)
plt.vlines(0.0, ymin=-30.0, ymax=200.0, color='m')
plt.xticks([0.0, 50.0, 100.0])
plt.yticks([0.0, 100.0, 200.0], labels=[])
plt.xlabel("external input")

plt.sca(axs[4])
line_b_60 = print_stability(b_60['x'], b_60['f'], b_60['s'], 6, 1, color='g', letter=False, linewidth=1.0)
line_network_60, = plt.plot(network_60[:, 0], network_60[:, 3], 'xg', ms=5.0)
plt.legend([line_network_60, line_b_60], ['network', 'mean field'], loc='lower right')
plt.ylim(ymax=200.0, ymin=-1.0)
plt.xlim(xmax=100.0, xmin=-1.0)
plt.vlines(0.0, ymin=-30.0, ymax=200.0, color='m')
plt.xticks([0.0, 50.0, 100.0])
plt.yticks([0.0, 100.0, 200.0], labels=[])
plt.xlabel("external input")

plt.subplots_adjust(top=0.95, bottom=0.05, left=0.05, right=0.98, wspace=0.1)

plt.show()