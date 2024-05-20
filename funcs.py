def fact(N):
    if not isinstance(N, int):
        raise TypeError("O argumento deve ser um inteiro")
    if N < 0:
        raise ValueError("O argumento deve ser um inteiro não-negativo")    
    if (N==0):
        return(1)
    else:
        return(N*fact(N-1))

def expo(x,N):
    if (N==0):
        return(1)
    else:
        return(x**N/fact(N) + expo(x,N-1))
  