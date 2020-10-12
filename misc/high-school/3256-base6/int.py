"""
Find the number of integers consisting of 4 digits from {1,2,3,4,5,6} which are less than threshold=3256.
For example,
- 1234 and 3255 are such integers
- 1979, 666 and 4123 are not

int.py and str.py differs only at the function qualified()

"""
import math

threshold = 3256
interdits = [0,7,8,9]

## strict version
#def qualified(k):
#    if not isinstance(k, int):
#        return False
#    pass

#def decompose(k):
#    """
#    e.g. decompose(1974) will return [4,7,9,1]
#    """
#    n_digits = int(math.log10(k)) + 1
#    reversed_ = []
#    for i in range(n_digits):
#        remainder = k % 10
#        reversed_.append(remainder)
#        k = k // 10
#    #return reversed(reversed_)
#    return reversed_

#def decompose(k):
#    """
#    e.g. decompose(1974) will return [4,7,9,1]
#    """
#    reversed_ = []
#    while True:
#        remainder = k % 10
#        reversed_.append(remainder)
#        k = k // 10
#        if k == 0:
#            break
#    #return reversed(reversed_)
#    return reversed_

def decompose(k):
    """
    e.g. decompose(1974) will return [4,7,9,1]

    In [1]: def gen():
       ...:     yield 1
       ...:     yield 2
       ...:     yield 3
       ...:
    
    In [2]: 3 in gen()
    Out[2]: True
    
    In [3]: 1 in gen()
    Out[3]: True
    
    In [4]: 0 in gen()
    Out[4]: False
    
    In [5]: 100 in gen()
    Out[5]: False

    """
    while True:
        remainder = k % 10
        yield remainder
        k = k // 10
        if k == 0:
            break

## loose version
def qualified(k):
    for i in interdits:
        if i in decompose(k):
            return False
    return True


if __name__ == "__main__":
    #qualifiants = []
    n_qualified = 0
    for i in range(1000, threshold):
        if qualified(i):
            n_qualified += 1
            #qualifiants.append(i)
    
    print(f"There are {n_qualified} such integers.")
