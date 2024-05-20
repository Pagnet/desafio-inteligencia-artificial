import pytest
from funcs import fact

def test_fact_funciona():
    assert fact(5) == 120
    assert fact(0) == 1

def test_fact_com_nao_inteiro():
    with pytest.raises(TypeError):
        fact(4.5)
    with pytest.raises(TypeError):
        fact("string")
    with pytest.raises(TypeError):
        fact([1, 2, 3])

def test_fact_com_inteiro_negativo():
    with pytest.raises(ValueError):
        fact(-1)
