import numpy as np
import matplotlib.pyplot as plt

x = np.arange(0,2, 0.01)
Y = np.zeros( (4, len(x)) )

filename = '../figMB/comparison_parabola_err'


A = [1, 2, 3]

A = np.array([[9      , 9.62    , 5.57      ,  8.98  ],
              [-20    , -23.39  , -7.65     , -19.93 ],
              [10     , 17.74   , -4.50     ,  9.96  ],
              [0      , -9.19   , 4.13      , -0.26  ],
              [0      , 5.25    , 2.99      ,  0.72  ],
              [0      , 0.18    , -1.21     , -0.93  ],
              [0      , -2.48   , -0.41     ,  0.73  ],
              [0      , 1.81    , -0.013    , -0.36  ],
              [0      , -0.66   , 0.08      ,  0.11  ],
              [0      , 0.12    , 0.04      , -0.02  ],
              [0      , -0.001  , -0.02     ,  0.002 ]] )

A = A.T 

rows,cols = A.shape

for j in np.arange(0,cols):
    print(j)
    for i in np.arange(0, 4):
        Y[i,:] = Y[i,:] + A[i,j] * x**j
    

plt.plot(x,Y[0], 'k')
plt.plot(x,Y[1], 'r')
plt.plot(x,Y[2], 'g')
plt.plot(x,Y[3], 'b')

plt.legend(["u", "sp", "np32", "np64"])


plt.savefig(filename + '.pdf')
plt.savefig(filename + '.png')