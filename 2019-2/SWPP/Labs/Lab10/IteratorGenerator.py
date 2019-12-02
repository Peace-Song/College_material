def prime_number_generator():
    def is_prime(num):
        for i in range(2, num):
            if num % i == 0:
                return False
        return True
    
    number = 2
    while True:
        if is_prime(number):
            yield number
        
        number += 1

if __name__ == "__main__":
    num_primes = int(input())
    generator = prime_number_generator()
    for i in range(num_primes):
        number = next(generator)
        print("get prime number", number)
