from math import factorial, exp

def aprox_func(x, N):
    result = 0
    for i in range(N):
        f = (x**i)/factorial(i)
        result += f
    return result

elements_to_test = [5, 15, 20, 30]

for element in elements_to_test:
     print(f"Usando N={element}, o erro da aproximação foi de {exp(4)-aprox_func(4, element)}")