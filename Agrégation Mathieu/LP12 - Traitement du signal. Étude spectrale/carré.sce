// ******************* Signal carré *******************
clear all

// Paramètres

N = 1; // Nombre de modes
t = linspace(-5,5,1000);

s = 0;

for k = 1:N
    s = s + (4/%pi)*(sin((2*k-1)*%pi*t))/(2*k-1);
end

h=gca();
plot2d(t,s, style = 2);
h.data_bounds = [-5, -2 ; 5, 2]; 
h.x_label.text = "Temps";
h.y_label.text = "s(t)";
