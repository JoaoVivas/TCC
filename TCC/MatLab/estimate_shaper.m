function [resp] = estimate_shaper(shaper, freq, damping_ratio)
    A, T, _ = shaper
    n = len(T)
    inv_D = 1. / sum(A)
    omega = 2. * math.pi * freq
    damping = damping_ratio * omega
    omega_d = omega * math.sqrt(1. - damping_ratio**2)
    S = C = 0
    for i in range(n):
        W = A[i] * math.exp(-damping * (T[-1] - T[i]))
        S += W * math.sin(omega_d * T[i])
        C += W * math.cos(omega_d * T[i])
    return math.sqrt(S*S + C*C) * inv_D
end