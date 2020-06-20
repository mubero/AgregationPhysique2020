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
b = 2

# Conditions initiales
theta0 = np.pi/4.0
omega0 = 0.0
y0 = [omega0, theta0]

# Echelle de temps
T = 2*np.pi/np.sqrt(Omega2)
t = np.linspace(0, 10*T, 1000)

# Resolution de l'equation differentielle
sol = odeint(modele_pendule, y0, t, args=(a, b))

# Affichage des solutions
#plt.plot(t, sol[:, 1], 'b', label='theta(t)')
plt.gcf().subplots_adjust(wspace = 0.5, hspace = 0.5)
plt.subplot(2,1,1)
plt.plot(t,sol[:, 1],'b')
plt.plot(t,sol[:, 0],'r')
plt.xlabel('theta')
#plt.plot(t, sol[:, 0], 'r', label='omega(t)')

#plt.plot(sol[:, 1], sol[:, 0], 'g', label='phase')
plt.subplot(2,1,2)
plt.plot(sol[:, 1], sol[:, 0],'g')
plt.legend(loc='best')
plt.xlabel('t')
plt.grid()
plt.show()