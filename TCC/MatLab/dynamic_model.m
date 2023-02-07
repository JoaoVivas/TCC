function xdot = dynamic_model(x, u, A, B)
xdot = (A*x)+(B*u);
