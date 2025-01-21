# `obiettivo`
Installare un redis master/slave tramite [helm chart di Bitnami](https://github.com/bitnami/charts/tree/main/bitnami/redis) in Kubernetes. 
Scrivere uno script in Python che faccia il SET di 1000 chiavi che rappresentano la posizione dei  numeri primi (1 => 2, 2 => 3, 3 => 5, 4 => 7, ...) e poi il GET delle chiavi.

---
## Spiegazione script python
1. Importare le librerie necessarie
- **import redis**
- **import math**
2. Verificare se il numero è primo
```python
def is_prime(num):
    if num < 2: # se il numero è minore di 2
        return False #restituisce false
    for i in range(2, int(math.sqrt(num)) + 1): # iteration su tutti i numeri interi da 2 fino alla radice quadrata di num
        if num % i == 0: # operatore % calcola la divisione tra num e l'indice se il resto non da zero la condizione  altrimenti ritorna true 
            return False 
    return True
```
3. generazione numeri primi
```python
def generate_primes(count):
    primes = [] --> lista vuota che conterrà i numeri primi memorizzati
    num = 2 --> contatore inizializzato a 2
    while len(primes) < count: --> il ciclo continua finchè la lunghezza della lista primes è inferiore a count
        if is_prime(num): 
            primes.append(num) --> dopo ogni controllo num viene incrementato di 1 per testare il numero successivo 
        num += 1 --> incrementa di 1
    return primes --> quando la lista primes contiene un numero desiderato di numeri primi viene restituita
```
4. funzione main
```python
def main():
    r = redis.Redis(host="localhost", port=6379, decode_responses=True) --> connessione a un' istanza di Redis locale

    primes = generate_primes(1000) --> chiamata della funzione generate_primes per ottenere una lista dei primi 1000 numeri primi 

    for idx, prime in enumerate(primes, start=1):  
        key = f"prime:{idx}" --> creazione chiave con formato prime: indice es: prime:2
        r.set(key, prime) --> associazione tra chiave e numero primo
        r.expire(key, 1000) --> assegnazione TTL di 1000 secondi 

    for idx in range(1, 1001):
        key = f"prime:{idx}"
        value = r.get(key)
        ttl = r.ttl(key)
        print(f"GET {key} -> {value} -> {ttl}")

if __name__ == "__main__":
    main()
```
---
## requisiti
- [python](https://www.python.org)

