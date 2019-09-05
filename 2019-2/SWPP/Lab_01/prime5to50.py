def wannaGoHome():
    for n in range(5, 51):
        isPrime = True
        for probe in range(2, n):
            if n % probe == 0:
                isPrime = False

        if isPrime:
            print(str(n) + " is a prime number")



wannaGoHome()
