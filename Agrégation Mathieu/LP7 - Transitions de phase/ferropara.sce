//Enthalpie libre - transition ferro-para à B_0 = 0

a = 1;
beta_c = 1;
T_c = 5;
T = [1;5;10];

M = linspace(-4,4,1000);

for k =1:length(T)
  
    G = 1 + a*(T(k)-T_c)*M.^2 + 0.5*beta_c*M.^4;
    G = G/max(G);
    
    u = M/max(M);
    
    h1=gca();
    h1.x_label.text = "$M/M_{max}$";
    h1.y_label.text = "$G/G_{max}$";
    plot2d(u',G',style = k);
end

