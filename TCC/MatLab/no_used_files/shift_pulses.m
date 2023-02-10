function [resp] = shift_pulses(shaper)
 A, T, name = shaper
    n = len(T)
    ts = (sum([A[i] * T[i] for i in range(n)])) / sum(A)
    for i in range(n):
        T[i] -= ts
end