function s = desv_min(x)
    global x_entr
    s = (x(1,:) - x_entr(1,:))*(x(1,:) - x_entr(1,:))'+(x(5,:) - x_entr(5,:) )*(x(5,:) - x_entr(5,:))';
end