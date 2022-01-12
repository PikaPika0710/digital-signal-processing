
import numpy as np
from matplotlib import pyplot as plt


if __name__ == '__main__':
    print("Find x[n] = (u[n+1]-u[n-5])(nu[2-n])")

    def fu(n, *, sample_n=np.arange(-2, 4), sample_u=np.array((0, -1, 0, 1, 2, 3, 0))):
        n = np.searchsorted(sample_n, n)
        return sample_u[n]

    n = np.arange(-5, 7)
    u = fu(n)
    print(f"n    = {n}")
    print(f"u[n] = {u}")
    plt.figure(figsize=(10, 5))
    plt.stem(n, u)
    plt.show()

    n = np.arange(-4, 11)
    x1 = fu(n+1) - fu(n-5)
    print('set x1 = u[n+1]-u[n-5]')
    print(f"n    = {n}")
    print(f"x1   = {x1}")
    plt.figure(figsize=(10, 5))
    plt.stem(n, x1)
    plt.show()

    n = np.arange(-3, 6)
    x2 = n*fu(2-n)
    print('set x2 = nu[2-n]')
    print(f"n  = {n}")
    print(f"x2 = {x2}")
    plt.figure(figsize=(10, 5))
    plt.stem(n, x2)
    plt.show()

    n = np.arange(-3, 6)
    x = (fu(n+1) - fu(n-5)) * (n * fu(2-n))
    print('x = x1 * x2')
    print(f'n = {n}')
    print(f'x = {x}')
    plt.figure(figsize=(10, 5))
    plt.stem(n, x)
    plt.show()
