import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt


# Systeme differentiel
def modele_duffing(y,t,r,a,b,f,omega):
    q, x = y
    dydt = [-r*q - a*x - b*x**3 + f*np.cos(omega*t), q ]
    return dydt

# Parametres
r = 0.1
a = -1.0
b = 1.0
f = 0.2
omega= 1.5

# Conditions initiales
q0 = [1.0, 1.001]
x0 = [1.0, 1.0]
colors = ['g', 'r']


# Echelle de temps
T = 2*np.pi/np.sqrt(omega)
t = np.linspace(0, 15*T, 10000)

# Resolution de l'equation differentielle
for i in range(len(x0)):
    y0 = [q0[i], x0[i]]
    # Resolution de l'equation differentielle
    sol = odeint(modele_duffing, y0, t, args=(r, a, b, f, omega))
    # Portrait de phases
    plt.gcf().subplots_adjust(wspace=0.5, hspace=0.5)
    plt.subplot(3, 1, 1)
    plt.plot(sol[:, 1], sol[:, 0], colors[i], label='phase %i' % i)
    plt.legend(loc='best')
    plt.xlabel('x')
    plt.ylabel(r'$\dot x$')
    # Position en fonction du temps
    plt.subplot(3, 1, 2)
    plt.plot(t , sol[:, 1], colors[i], label='phase %i' % i)
    plt.legend(loc='best')
    plt.xlabel('t')
    plt.ylabel('x')


# Energie potentielle
V = a/2 * sol[:,1]**2 + b/4 * sol[:,1]**4



# Plot potentiel
plt.subplot(3,1,3)
plt.plot(sol[:, 1], V, 'b')
plt.xlim(-1.5,1.5)
plt.legend(loc='best')
plt.xlabel('x')
plt.ylabel('Ep')
plt.grid()

plt.show()
