%%
def get_zv_shaper(shaper_freq, damping_ratio):
    df = math.sqrt(1. - damping_ratio**2)
    K = math.exp(-damping_ratio * math.pi / df)
    t_d = 1. / (shaper_freq * df)
    A = [1., K]
    T = [0., .5*t_d]
    return (A, T)
%%
def get_zvd_shaper(shaper_freq, damping_ratio):
    df = math.sqrt(1. - damping_ratio**2)
    K = math.exp(-damping_ratio * math.pi / df)
    t_d = 1. / (shaper_freq * df)
    A = [1., 2.*K, K**2]
    T = [0., .5*t_d, t_d]
    return (A, T)
%%
def get_mzv_shaper(shaper_freq, damping_ratio):
    df = math.sqrt(1. - damping_ratio**2)
    K = math.exp(-.75 * damping_ratio * math.pi / df)
    t_d = 1. / (shaper_freq * df)

    a1 = 1. - 1. / math.sqrt(2.)
    a2 = (math.sqrt(2.) - 1.) * K
    a3 = a1 * K * K

    A = [a1, a2, a3]
    T = [0., .375*t_d, .75*t_d]
    return (A, T)
%%
def get_ei_shaper(shaper_freq, damping_ratio):
    v_tol = 1. / SHAPER_VIBRATION_REDUCTION # vibration tolerance
    df = math.sqrt(1. - damping_ratio**2)
    K = math.exp(-damping_ratio * math.pi / df)
    t_d = 1. / (shaper_freq * df)

    a1 = .25 * (1. + v_tol)
    a2 = .5 * (1. - v_tol) * K
    a3 = a1 * K * K

    A = [a1, a2, a3]
    T = [0., .5*t_d, t_d]
    return (A, T)
%%
def get_2hump_ei_shaper(shaper_freq, damping_ratio):
    v_tol = 1. / SHAPER_VIBRATION_REDUCTION # vibration tolerance
    df = math.sqrt(1. - damping_ratio**2)
    K = math.exp(-damping_ratio * math.pi / df)
    t_d = 1. / (shaper_freq * df)

    V2 = v_tol**2
    X = pow(V2 * (math.sqrt(1. - V2) + 1.), 1./3.)
    a1 = (3.*X*X + 2.*X + 3.*V2) / (16.*X)
    a2 = (.5 - a1) * K
    a3 = a2 * K
    a4 = a1 * K * K * K

    A = [a1, a2, a3, a4]
    T = [0., .5*t_d, t_d, 1.5*t_d]
    return (A, T)
%%
def get_3hump_ei_shaper(shaper_freq, damping_ratio):
    v_tol = 1. / SHAPER_VIBRATION_REDUCTION # vibration tolerance
    df = math.sqrt(1. - damping_ratio**2)
    K = math.exp(-damping_ratio * math.pi / df)
    t_d = 1. / (shaper_freq * df)

    K2 = K*K
    a1 = 0.0625 * (1. + 3. * v_tol + 2. * math.sqrt(2. * (v_tol + 1.) * v_tol))
    a2 = 0.25 * (1. - v_tol) * K
    a3 = (0.5 * (1. + v_tol) - 2. * a1) * K2
    a4 = a2 * K2
    a5 = a1 * K2 * K2

    A = [a1, a2, a3, a4, a5]
    T = [0., .5*t_d, t_d, 1.5*t_d, 2.*t_d]
    return (A, T)
    %%
% # min_freq for each shaper is chosen to have projected max_accel ~= 1500
    INPUT_SHAPERS = [
    InputShaperCfg('zv', get_zv_shaper, min_freq=21.),
    InputShaperCfg('mzv', get_mzv_shaper, min_freq=23.),
    InputShaperCfg('zvd', get_zvd_shaper, min_freq=29.),
    InputShaperCfg('ei', get_ei_shaper, min_freq=29.),
    InputShaperCfg('2hump_ei', get_2hump_ei_shaper, min_freq=39.),
    InputShaperCfg('3hump_ei', get_3hump_ei_shaper, min_freq=48.),
]



SHAPER_VIBRATION_REDUCTION=20.
DEFAULT_DAMPING_RATIO = 0.1



def estimate_shaper(shaper, freq, damping_ratio):
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

def shift_pulses(shaper):
    A, T, name = shaper
    n = len(T)
    ts = sum([A[i] * T[i] for i in range(n)]) / sum(A)
    for i in range(n):
        T[i] -= ts
        
        


def shift_pulses(shaper):
    A, T, name = shaper
    n = len(T)
    ts = (sum([A[i] * T[i] for i in range(n)])) / sum(A)
    for i in range(n):
        T[i] -= ts

def calc_shaper(shaper, positions):
    shift_pulses(shaper)
    A = shaper[0]
    inv_D = 1. / sum(A)
    n = len(A)
    T = [time_to_index(-shaper[1][j]) for j in range(n)]
    out = [0.] * len(positions)
    for i in indexes(positions):
        out[i] = sum([positions[i + T[j]] * A[j] for j in range(n)]) * inv_D
    return out

% # Ideal values
SMOOTH_TIME = (2./3.) / CONFIG_FREQ

def gen_updated_position(positions):
%     #return calc_weighted(positions, 0.040)
%     #return calc_spring_double_weighted(positions, SMOOTH_TIME)
%     #return calc_weighted4(calc_spring_raw(positions), SMOOTH_TIME)
    return calc_shaper(get_ei_shaper(), positions)

