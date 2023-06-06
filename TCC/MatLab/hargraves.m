function [delta] = hargraves(x_i,u_i,x_n,u_n,dt,dynamic_model)
    global A_model B_model
    
    A = A_model;
    B = B_model;
        
    f_i = dynamic_model(x_i,u_i,A,B);  
    f_n = dynamic_model(x_n,u_n,A,B);
        
    x_c =(x_i+x_n)/2+dt*(f_i-f_n)/8;
    u_c = (u_i+u_n)/2;
        
    x_ca=-3*(x_i-x_n)/(2*dt)-(f_i+f_n)/4;
        
    f_c = dynamic_model(x_c,u_c,A,B);
        
    delta = f_c-x_ca;
end