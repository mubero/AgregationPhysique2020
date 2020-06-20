import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt

# Definition des parametres
l = 1.0         # m
g = 9.81        # m/s2
m = 1.0         # kg
Omega2 = g/l    # pulsation du pendule

# Definition modele
def modele_pendule(y, t, a, b):
    omega, theta = y
    dydt = [-a*np.sin(theta) -b*omega, omega]
    return dydt

# Parametres de l'equation
a = Omega2
b = 0.0


# Echelle de temps
T = 2*np.pi/np.sqrt(Omega2)
t = np.linspace(0, 10*T, 10000)


# Conditions initiales1
theta0 = [np.pi/4.0, np.pi/3.0, np.pi/1.5, np.pi - 0.001, -np.pi/8.0]
omega0 = [0.0, 0.0, 0.0, 0.0, 10.0]
colors = ['b', 'c', 'g', 'y', 'm']

for i in range(len(theta0)):
    y0 = [omega0[i], theta0[i]]
    # Resolution de l'equation differentielle
    sol = odeint(modele_pendule, y0, t, args=(a, b))

    # Affichage des solutions
    #plt.plot(t, sol[:, 1], 'b', label='theta(t)')
    #plt.plot(t, sol[:, 0], 'r', label='omega(t)')
    plt.plot(sol[:, 1], sol[:, 0]/np.sqrt(Omega2), colors[i], label='phase %i'%i)

#plt.ylim(-5,+5)
plt.xlim(-2*np.pi,+2*np.pi)
plt.legend(loc='best')
plt.xlabel(r'$\theta$')
plt.ylabel(r'$\dot\theta/\omega_0$')
plt.show()