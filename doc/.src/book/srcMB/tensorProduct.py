import numpy as np
import matplotlib.pyplot as plt

def f(x):
    # if x<0:
    #     return (x+1) .* (x<0) 
    # else: 
    #     return 1-x
    return (x+1) * (x<0) + (1-x) * (x>=0)
    
xx = np.arange(-1,1, 0.001)  
yy = np.arange(-1,1, 0.001)


[XX, YY] = np.meshgrid(xx,yy)

fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(XX, YY, f(XX))


fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(XX, YY, f(YY))

fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(XX, YY, f(XX)*f(YY))


sfdsfds

print(f(0.5))

# # definition of the interval ends
# x = np.array([-1, 1]) 

# C = []  # list of polynomials stored as coefficients 
# B = []  # list of basis functions
# dB = [] # list of the derivatives of basis functions

# for k in np.arange(0,4):
#     A = np.array(  [[   x[0]**3,   x[0]**2, x[0], 1 ],
#                     [ 3*x[0]**2, 2*x[0],       1, 0 ],
#                     [   x[1]**3,   x[1]**2, x[1], 1 ],
#                     [ 3*x[1]**2, 2*x[1],       1, 0 ]])

#     b = np.zeros( (4,1) ); b[k] = 1 
    
#     c = np.linalg.solve(A, b); C.append( c )

#     B.append( lambda x:     C[k][0,0] * x**3 +   C[k][1,0] * x**2 + C[k][2,0] * x + C[k][3,0] )
#     dB.append( lambda x: 3* C[k][0,0] * x**2 + 2*C[k][1,0] * x + C[k][2,0] )
    
    
# # Check numerically that resulting cubic polynomial fulfills imposed requirements
# A = [1,       1,       2,      1]      # basis function coefficients 
# #    U(x[0])  dU(x[0]) U(x[1]) dU(x[1])

# xx = np.arange(-1,1, 0.001)  
# U = np.zeros(xx.shape)

# for k in np.arange(0,4):
#     U = U + A[k] * B[k](xx)

# # numerical approximation of derivatives at the ends of the interval
# dl = (U[1]-U[0])/(xx[1]-xx[0])
# dr = (U[-1]-U[-2])/(xx[-1]-xx[-2])

numericalApproximationOfA = [ U[0], dl, U[-1], dr]

print(numericalApproximationOfA)


# Plot basis functions and its derivatives
filename = '../figMB/cubicHermiteBasis'
plt.figure()
for k in np.arange(0,4):
    plt.plot(xx, B[k](xx))
plt.legend(['B1', 'B2', 'B3','B4'])
plt.title('Basis functions for cubic Hermite polynomial')
plt.savefig(filename + '.pdf')
plt.savefig(filename + '.png')

filename = '../figMB/cubicHermiteDerivs'
plt.figure()
for k in np.arange(0,4):
    plt.plot(xx, dB[k](xx))
plt.legend(['dB1', 'dB2', 'dB3','dB4'])
plt.title('Derivatives of basis functions for cubic Hermite polynomial')
plt.savefig(filename + '.pdf')
plt.savefig(filename + '.png')


filename = '../figMB/cubicHermiteResult'
plt.figure()
plt.plot(xx,U)
plt.title('Final approximation')
plt.savefig(filename + '.pdf')
plt.savefig(filename + '.png')
