import numpy as np
import numpy.random as ra
from matplotlib import pyplot as plt

print("Hello, World!")

def exp_dist(x, l):
    return x * (np.e ** (-l*x))


X = np.random.rand(1000000)
Y = exp_dist(X, 1.0)

pr = Y / float(sum(Y))
cum_pr = np.cumsum(pr)
