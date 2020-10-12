"""
Find the number of integers consisting of 4 digits from {1,2,3,4,5,6} which are less than threshold=3256.
For example,
- 1234 and 3255 are such integers
- 1979, 666 and 4123 are not

"""

threshold = 3256
interdits = [0,7,8,9]

## strict version
#def qualified(k):
#    if not isinstance(k, int):
#        return False
#    pass

## loose version
def qualified(k):
    for i in interdits:
        if str(i) in str(k):
            return False
    return True

#qualifiants = []
n_qualified = 0
for i in range(1000, threshold):
    if qualified(i):
        n_qualified += 1
        #qualifiants.append(i)

print(f"There are {n_qualified} such integers.")
