function ut = u_t_interpolator(u1, u2, dt, t)
delta = u2-u1;

accx = delta(3)/dt;
accy = delta(4)/dt;
vxt = u1(3) + t*accx;
vyt = u1(4) + t*accy;
if accx == 0
    xt = u1(1) + vxt*t;
else
    xt = u1(1) + (vxt^2 - u1(3)^2)/(2*accx);
end
if accy == 0
    yt = u1(2) + vyt*t;
else
    yt = u1(2) + (vyt^2 - u1(4)^2)/(2*accy);
end
ut = [xt;yt;vxt;vyt];
end