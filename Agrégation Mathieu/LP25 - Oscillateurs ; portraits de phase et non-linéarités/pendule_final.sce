clear all

// Définition des paramètres
l = 1.         // m
g = 9.81       // m.s-2
m = 1.         // kg
Omega2 = g/l;  // pulsation du pendule

// Système différentiel
function du = Pendule(t,u)
  du(1) = u(2);
  du(2) = - Omega2*sin(u(1));
//  du(2) = - Omega2*u(1);
endfunction

// Conditions initiales
//theta0 = input("Angle initial (en rd): ");
//vtheta0 = input("Vitesse angulaire initiale (en rd/s): ");

//theta0  = [%pi/20;%pi/10;%pi/4;%pi/3;1.90;2.5 ; 3 ; 0 ;0 ];
//vtheta0 = [0    ;0    ;0   ;0   ;0   ;0   ; 0 ; 3*sqrt(2*g/l) ; -3*sqrt(2*g/l)];

theta0  = [-1.1*pi    ;1.1*pi      ;pi/20;pi/10;pi/4;pi/3;1.90;2.5 ; 3 ; 0 ;0 ; -1.1*pi ; 1.1*pi; -1.1*pi ; 1.1*pi];
vtheta0 = [sqrt(2*g/l);-sqrt(2*g/l);0    ;0    ;0   ;0   ;0   ;0   ; 0 ; 3*sqrt(2*g/l) ; -3*sqrt(2*g/l);2.5 ; -2.5 ; 7.8; -7.8];

for k = 1:length(theta0)
    
    E0 = (1/2)*m*(l^2)*(vtheta0(k))^2 + m*g*l*(1 - cos(theta0(k)));  // Energie mécanique totale du pendule = Energei initiale
    u0 = [theta0(k);vtheta0(k)];
    t0 = 0;
    //ck = sin(theta0(k)/2);
    
    period = 2*%pi/sqrt(Omega2);
    
    // Paramètres de calcul
    T = 100*period ; dt=200;
    pas = period/dt;
    t = t0:pas:T;
    
    // Intégration
    [u] = ode(u0,t0,t,Pendule);  // u(1): angle(t)  u(2): vitesse angulaire(t)   
    
    // Espace des phases
    figure(1)
    h = gca();
    plot2d(u(1,:)',u(2,:)'/sqrt(Omega2));
    h.data_bounds = [-1.1*%pi, -1.1*%pi ; 1.1*%pi, 1.1*%pi]; 
    h.x_label.text = "Angle (rad)";
    h.y_label.text = "Vitesse angulaire / Omega0 (rad)"; 
    h.tight_limits=["on","on"]; 
    xgrid(2);
end
