function env = env_detector(signal,window)

env_in = hilbert(signal);
env_signal = abs(env_in);
env = conv(env_signal,ones(1,window)/window);