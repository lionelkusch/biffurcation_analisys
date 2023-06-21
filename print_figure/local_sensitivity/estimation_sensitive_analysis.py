import os
import matplotlib.pyplot as plt
import numpy as np
from scipy.io.matlab import loadmat

path = os.path.dirname(__file__) + '/../../matlab/Polynomial/'
result = {}
sensibility = [1e-2, 1e-3, 1e-4]
for path_res in ['P_e_0', 'P_e_1', 'P_e_2', 'P_e_3', 'P_e_4', 'P_e_5', 'P_e_6', 'P_e_7', 'P_e_8', 'P_e_9',
                 'P_i_0', 'P_i_1', 'P_i_2', 'P_i_3', 'P_i_4', 'P_i_5', 'P_i_6', 'P_i_7', 'P_i_8', 'P_i_9', ]:
    data = [loadmat(path + '/' + path_res + '/' + path_res + '_b.mat')['x'],
            loadmat(path + '/' + path_res + '/' + path_res + '_f.mat')['x']]
    result[path_res] = []
    for sensibility_firing_rate in sensibility:
        for index_data in [0, 1]:  # 0 : excitatory, 1 : inhibitory
            default_value = data[0][:, index_data]
            up = data[0][index_data, 0] - sensibility_firing_rate
            down = data[0][index_data, 0] + sensibility_firing_rate

            # # check values if the same :
            # print(data[0][index_data, 0], data[1][index_data, 0])
            # # check sensibility
            # print(up, down)
            # # test figure
            # plt.figure()
            # # plt.plot(data[0][index_data, :], '.')
            # plt.plot(data[1][index_data, :], '.')
            # plt.hlines(up, 0.0, data[1][index_data, :].shape[0])
            # plt.hlines(down, 0.0, data[1][index_data, :].shape[0])
            # plt.show()

            # detect index
            index_up = None
            index_up_0 = np.argmin(np.abs(up - data[0][index_data, :]))
            index_up_1 = np.argmin(np.abs(up - data[1][index_data, :]))
            if index_up_0 != 0:
                index_up = (0, index_up_0)
            if index_up_1 != 0:
                if index_up is not None:
                    raise Exception('bad indexing')
                else:
                    index_up = (1, index_up_1)
            index_down = None
            index_down_0 = np.argmin(np.abs(down - data[0][index_data, :]))
            index_down_1 = np.argmin(np.abs(down - data[1][index_data, :]))
            if index_up_0 != 0:
                index_down = (0, index_down_0)
            if index_up_1 != 0:
                if index_down is not None:
                    raise Exception('bad indexing')
                else:
                    index_down = (1, index_down_1)
            result[path_res].append([index_data, sensibility_firing_rate * 1e3, data[0][5, 0],
                                     np.abs(data[index_up[0]][5, index_up[1]] - data[index_down[0]][5, index_down[1]])])

data = [[[], []] for i in range(len(sensibility))]
for index, sensibility_firing_rate in enumerate(sensibility):
    for key, value in result.items():
        data[index][0].append([value[index * 2][3], value[index * 2][2]])
        data[index][1].append([value[index * 2 + 1][3], value[index * 2][2]])

data = np.concatenate([data], axis=2)
for index, sensibility_firing_rate in enumerate(sensibility):
    plt.figure()
    plt.plot(np.log10(data[index, 0, :, 0]), label='excitatory')
    plt.plot(np.log10(data[index, 1, :, 0]), label='inhibitory')
    plt.plot(np.log10(np.abs(data[index, 0, :, 1])), label='excitatory reference')
    plt.plot(np.log10(np.abs(data[index, 1, :, 1])), label='inhibitory reference')
plt.legend()

data = np.concatenate([data], axis=2)
for index, sensibility_firing_rate in enumerate(sensibility):
    plt.figure()
    print(np.ceil(-np.log10(data[index, 0, :, 0])), np.ceil(-np.log10(np.abs(data[index, 0, :, 1]))))
    plt.plot((np.ceil(-np.log10(data[index, 0, :, 0])) - np.ceil(-np.log10(np.abs(data[index, 0, :, 1])))),
             label='excitatory')
    plt.plot((np.ceil(-np.log10(data[index, 1, :, 0])) - np.ceil(-np.log10(np.abs(data[index, 1, :, 1])))),
             label='inhibitory')
plt.legend()
plt.show()
