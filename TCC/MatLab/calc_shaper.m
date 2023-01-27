function [out] =  calc_shaper(shaper, positions)
    shift_pulses(shaper)
    A = shaper[0]
    inv_D = 1. / sum(A)
    n = len(A)
    T = [time_to_index(-shaper[1][j]) for j in range(n)]
    out = [0.] * len(positions)
    for i in indexes(positions):
        out[i] = sum([positions[i + T[j]] * A[j] for j in range(n)]) * inv_D
end