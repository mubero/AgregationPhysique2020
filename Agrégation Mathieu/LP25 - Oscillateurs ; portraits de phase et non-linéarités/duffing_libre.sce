// ******************* Oscillateur de Duffing ********************
clear all

// Paramètres
diss = 0.1; //Dissipation
a = -1;
b = 1;
f = 1.5; //0.29; //1.5;
omega = 2; 1.4; //2;
pi = 3.141592654;

// Système différentiel
function du = Duffing(t,u)
    du(1) = u(2);                                           // dx/dt
    du(2) = -diss*u(2) -a*u(1) -b*(u(1))^3 + f*cos(omega*t);// d²x/dt²
endfunction

// Conditions initiales
x0 = input("Position initiale : ");
v0 = input("Vitesse initiale  : ");

    u0 = [x0;v0];
    t0 = 0;
    
// Energie potentielle
    x = linspace(-2,2,1000);
    V = (a/2)*x.^2 + (b/4)*x.^4;
    
    Energie = (v0*v0/2 + (a/2)*(x0)^2 + (b/4)*(x0)^4);
    Ene = V;
    Ene(:) = Energie;
    
// Paramètres de calcul
    T = 15000; dt = 1000;
    pas = 2*%pi/omega/dt;
    t = t0:pas:T;
    
// Intégration
[u] = ode(u0,t0,t,Duffing);  // u(1): position(t)  u(2): vitesse(t)   

//for i=5000:dt:100000
//    n=(i-4000)/dt;
//    x1(n)=u(1,i);
//    x2(n)=u(2,i);
//end

// Potentiel
subplot(2,2,1);
h1=gca();
h1.x_label.text = "Position";
h1.y_label.text = "Ep(x)";
plot2d(x',V',style = 2, leg = " Aspect énergétique ");
if f == 0 then
   plot2d(x',Ene',style = 2);
end
xgrid(2);

// Solution x(t)
subplot(2,2,2);
h3=gca();
plot2d(t(1:15000),u(1,1:15000)', style = 2, leg = " Position ");
h3.data_bounds = [0, -2 ; 50, 2]; 
h3.x_label.text = "Temps";
h3.y_label.text = "Position";
xgrid(2);

// Espace des phases
subplot(2,2,3);
h2=gca();
plot2d(u(1,1:10000)',u(2,1:10000)', style = 2, leg = "Espace des phases");
h2.data_bounds = [-2, -3 ; 2, 3]; 
h2.x_label.text = "Position";
h2.y_label.text = "Vitesse";
h2.tight_limits=["on","on"];
xgrid(2);

// Section de Poincaré
//subplot(2,2,4);
//h4=gca();
//h4.data_bounds = [-2, -2 ; 2, 2]; 
//h4.x_label.text = "Position";
//h4.y_label.text = "Vitesse";
//h4.tight_limits=["on","on"];
//plot2d(x1',x2', style = -1, leg = "Section de Poincaré (x,dx/dt)");
//xgrid(2);
