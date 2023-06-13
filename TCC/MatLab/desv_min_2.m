function s = desv_min_2(x)
    global x_entr
    s = (x(1,:) - x_entr(1,:))*(x(1,:) - x_entr(1,:))'+(x(2,:) - x_entr(2,:) )*(x(2,:) - x_entr(2,:))';
end