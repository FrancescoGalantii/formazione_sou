import redis
import math

def is_prime(num):
    if num < 2:
        return False
    for i in range(2, int(math.sqrt(num)) + 1):
        if num % i == 0:
            return False
    return True

def generate_primes(count):
    primes = []
    num = 2
    while len(primes) < count:
        if is_prime(num):
            primes.append(num)
        num += 1
    return primes


def main():
    r = redis.Redis(host="localhost", port=6379, decode_responses=True)

    primes = generate_primes(1000)

    for idx, prime in enumerate(primes, start=1):
        key = f"prime:{idx}" 
        r.set(key, prime)
        r.expire(key, 1000)

    for idx in range(1, 1001):
        key = f"prime:{idx}"
        value = r.get(key)
        ttl = r.ttl(key)
        print(f"GET {key} -> {value} -> {ttl}")

if __name__ == "__main__":
    main()
