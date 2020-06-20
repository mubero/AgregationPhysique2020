//********************************************************************************
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
theta0 = input("Angle initial (en rd): ");
vtheta0 = input("Vitesse angulaire initiale (en rd/s): ");

//theta0  = [-1.1*%pi    ;1.1*%pi      ;%pi/20;%pi/10;%pi/4;%pi/3;1.90;2.5 ; 3 ; 0 ;0 ; -1.1*%pi ; 1.1*%pi; -1.1*%pi ; 1.1*%pi];
//vtheta0 = [sqrt(2*g/l);-sqrt(2*g/l);0    ;0    ;0   ;0   ;0   ;0   ; 0 ; 3*sqrt(2*g/l) ; -3*sqrt(2*g/l);2.5 ; -2.5 ; 7.8; -7.8];

theta = linspace(-2*%pi,2*%pi,2000);
EP = m*g*l*(1 - cos(theta));

for k = 1:length(theta0)
    
    E0 = (1/2)*m*(l^2)*(vtheta0(k))^2 + m*g*l*(1 - cos(theta0(k)));  // Energie mécanique totale du pendule = Energei initiale
    u0 = [theta0(k);vtheta0(k)];
    t0 = 0;
    ck = sin(theta0(k)/2);
    
    [r]=delip(1,ck) // Période exacte
    period = [r];
    //period = 2*%pi/sqrt(Omega2);
    
    // Paramètres de calcul
    T = 100*period ; dt=200;
    pas = period/dt;
    t = t0:pas:T;
    
    // Intégration
    [u] = ode(u0,t0,t,Pendule);  // u(1): angle(t)  u(2): vitesse angulaire(t)   
    
    // Section de Poincaré
    //for i=201:dt:length(t)
    //    n = (i-1)/dt;
    //    th1(n) = u(1,i);
    //    th2(n) = u(2,i);
    //end
    
//    // Espace des phases
//    figure(1)
//    h0 = gca();
//    plot2d(u(1,:)',u(2,:)'/sqrt(Omega2));
//    h0.data_bounds = [-1.1*%pi, -1.1*%pi ; 1.1*%pi, 1.1*%pi]; 
//    h0.x_label.text = "Angle (rad)";
//    h0.y_label.text = "Vitesse angulaire / Omega0 (rad)"; 
//    h0.tight_limits=["on","on"];  
//    xgrid(2);
end

Ene = EP; Ene(:) = E0;

figure(2)

// Potentiel
subplot(2,2,1);
h1=gca();
plot2d(theta,EP,style = 2, leg = " Aspect énergétique ");
plot2d(theta,Ene,style = 2);
h1.data_bounds = [-1.1*%pi, 0 ; 1.1*%pi, 10]; 
h1.x_label.text = "Angle (rad)";
h1.y_label.text = "Ep(theta)";
h1.tight_limits=["on","on"];
xgrid(2);

// Solution theta(t)
subplot(2,2,2);
h3=gca();
plot2d(t',u(1,:)', style = 2, leg = " Position ");
h3.x_label.text = "Temps";
h3.y_label.text = "Angle";
xgrid(2);

// Espace des phases
subplot(2,2,3);
h2=gca();
plot2d(u(1,:)',u(2,:)/sqrt(Omega2)', style = 2, leg = "Espace des phases");
h2.data_bounds = [-1.1*%pi, -1.1*%pi ; 1.1*%pi, 1.1*%pi]; 
h2.x_label.text = "Angle (rad)";
h2.y_label.text = "Vitesse angulaire / Omega0 (rad)";
h2.tight_limits=["on","on"];
xgrid(2);

////// Section de Poincaré
//////subplot(2,2,4);
//////h4=gca();
//////h4.data_bounds = [-1.1*%pi, -1.1*%pi ; 1.1*%pi, 1.1*%pi]; 
//////h4.x_label.text = "Angle";
//////h4.y_label.text = "Vitesse angulaire";
//////h4.tight_limits=["on","on"];
//////plot2d(th1',th2', style = -1, leg = "Section de Poincaré (x,dx/dt)");
//////xgrid(2);


//////    figure(2)
//////    
//////    h2 = gca();
//////    h2.data_bounds = [-2*pi, 0 ; 2*pi, 2];
//////    h2.tight_limits=["on","on"]; 
//////    h2.x_label.text = "Angle (rad)";
//////    h2.y_label.text = "Energie potentielle ((m+M/2)gl))"; 
//////    plot2d(theta,EP,style = 2);








