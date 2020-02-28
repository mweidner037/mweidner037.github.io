# SageMath script (python will work but is 100x slower)

# See M. Weidner, "Making Explicit a Constant Appearing in an Impossible
# Equation of Carl and Moroz", submitted to SIGBOVIK 2020.
# Page numbers reference M. Carl and B. Z. Moroz, "ON A DIOPHANTINE
# REPRESENTATION OF THE PREDICATE OF PROVABILITY", Journal of Mathematical
# Sciences, Vol. 199, No. 1, May 2014, pages 36-52,
# https://link.springer.com/article/10.1007/s10958-014-1830-2


# Page 37
def p(x1, x2):
    return (x1+x2-2)*(x1+x2-1)//2 + x2


# Returns the tuple \vec{a} defined at the end of page 49 and
# computed in the appendix.  For clarity, it is 1-indexed, i.e.,
# ret[i] = a_i while ret[0] is undefined.
def computeAs():
    v0 = lambda u, v: 4*p(4*v-2, u)
    v1 = lambda u, v: 4*v0(4*u-2, 4*v-2) - 2
    v2 = lambda u, v: v1(4*p(u, v), 4*p(v, u))
    v3 = lambda i, u: 16*p(i, 4*u-2) - 6
    v4 = lambda i: v3(1, 4*p(i,1)-3)
    v5 = lambda i: 4*p(1, 16*p(1, i)-14) - 1
    v6 = lambda i, j: 4*p(1, v2(4*p(1, i)-3, 4*p(1, j)-3)) - 1
    v7 = lambda i, u: 4*p(i, 4*p(v4(i), u)) - 1
    v8 = lambda i, u: 4*v7(i, 4*u-2) - 2
    
    v9u5 = lambda i, j, k: 4*v1(v4(j), v4(k)) - 2
    v9u4 = lambda i, j, k: v0(4*p(1, j)-3, 4*p(1,k)-3)
    v9u3 = lambda i, j, k: 4*p(1, v2(4*p(1,i)-3, v9u4(i,j,k))) - 1
    v9u2 = lambda i, j, k: v1(v9u5(i,j,k), v5(i))
    v9u1 = lambda i, j, k: v1(v1(v4(j), v4(k)), v9u3(i,j,k))
    v9 = lambda i, j, k: v0(v9u1(i,j,k), v9u2(i,j,k))
    
    v10u1 = lambda i, j, k: i + j + k
    v10u2 = lambda i, j, k: v10u1(i,j,k) + 1
    v10u4 = lambda i, j, k: v1(v9(v10u1(i,j,k), j, j), v9(v10u2(i,j,k), j, k))
    v10u3 = lambda i, j, k: v2(v10u4(i,j,k), v9(i, v10u1(i,j,k), v10u2(i,j,k)))
    v10 = lambda i, j, k: v3(v10u1(i,j,k), v3(v10u2(i,j,k), v10u3(i,j,k)))
    
    v11u1 = lambda i, j, k, l: i + j + k + l
    v11u2 = lambda i, j, k, l: v1(v10(v11u1(i,j,k,l), j, k), v10(i, v11u1(i,j,k,l), k))
    v11 = lambda i, j, k, l: v3(v11u1(i,j,k,l), v11u2(i,j,k,l))
    
    aVec = [0] * 16
    
    aVec[1] = 4*p(v6(2,3), v2(4*p(2,4)-3, 4*p(3,4)-3))
    print("a1")
    
    a2u = v2(4*p(1,4)-3, v0(v6(1,2), v6(1,3)))
    aVec[2] = v7(2, v7(3, v8(4, v7(1,a2u))))
    print("a2")
    
    aVec[3] = v8(2, v7(1, 4*p(1,2)-3))
    print("a3")
    
    a4u2 = v1(v10(5,3,4), 4*p(5,2)-3)
    a4u1 = v2(v3(5,a4u2), 4*p(3,4)-3)
    aVec[4] = v3(2, v7(3, v7(4, a4u1)))
    print("a4")
    
    a5u3 = v1(4*p(4,1)-3, 4*p(4,2)-3)
    a5u2 = 4*p(4,3)-3
    a5u1 = v3(3, 4*p(4, v2(a5u2, a5u3))-1)
    aVec[5] = 4*p(1, 4*p(2, a5u1)-1)-1
    print("a5")
    
    a6u3 = 16*p(3,1)-14
    a6u2 = 4*p(3,2)-3
    a6u1 = v7(3, v2(a6u2, a6u3))
    aVec[6] = 4*p(1,v3(2,a6u1))-1
    print("a6")
    
    a7u4 = v3(5, v1(v10(5,3,4), 4*p(5,1)-3))
    a7u3 = v8(4,a7u4)
    a7u2 = 4*p(3,2)-3
    a7u1 = v7(3,v2(a7u2, a7u3))
    aVec[7] = 4*p(1,v3(2,a7u1))-1
    print("a7")
    
    a8u3 = v3(5,v1(v10(5,3,4), 4*p(5,2)-3))
    a8u2 = v2(a8u3, 4*p(3,1)-3)
    a8u1 = v7(3,v7(4,a8u2))
    aVec[8] = 4*p(1,v3(2,a8u1))-1
    print("a8")
    
    a9u4 = v2(4*p(6,2)-3, 4*p(7,1)-3)
    a9u3 = v1(v11(6,3,4,5), v11(7,4,5,3))
    a9u2 = v3(6,v3(7,v1(a9u3, a9u4)))
    a9u1 = v7(3,v7(4,v7(5,a9u2)))
    aVec[9] = 4*p(1,v3(2,a9u1))-1
    print("a9")
    
    a10u4 = v2(4*p(6,2)-3, 4*p(7,1)-3)
    a10u3 = v1(v11(6,3,4,5), v11(7,3,5,4))
    a10u2 = v3(6,v3(7,v1(a10u3, a10u4)))
    a10u1 = v7(3,v7(4,v7(5,a10u2)))
    aVec[10] = 4*p(1, v3(2,a10u1))-1
    print("a10")
    
    a11u2 = v1(4*p(3,4)-3, 4*p(4,1)-3)
    a11u1 = v2(4*p(3,2)-3, v8(4,a11u2))
    aVec[11] = v7(1,v8(2,v7(3,a11u1)))
    print("a11")
    
    a12u3 = 4*p(4*p(4,3)-3, 4*p(4,1)-3)
    a12u2 = 4*p(4,a12u3)-1
    a12u1 = v2(4*p(3,2)-3, a12u2)
    aVec[12] = v7(1,v8(2,v7(3,a12u1)))
    print("a12")
    
    a13u3 = v1(4*p(4,1)-3, 4*p(4,2)-3)
    a13u2 = v2(4*p(4,3)-3, a13u3)
    a13u1 = v8(3,v7(4,a13u2))
    aVec[13] = v7(1,4*p(2,a13u1)-1)
    print("a13")
    
    a14v10 = v3(6,v1(v10(6,5,4), 4*p(6,1)-3))
    a14v9 = v8(5,v1(a14v10, 4*p(5,2)-3))
    a14v8 = v2(4*p(4,3)-3, a14v9)
    a14u2 = v7(2,v8(3,v7(4,a14v8)))
    a14v7 = v3(5,v1(v10(5,2,4), 4*p(5,1)-3))
    a14v6 = v3(5,v1(v10(5,2,3), 4*p(5,1)-3))
    a14v5 = 4*p(v1(a14v6, a14v7), v6(3,4))
    a14v2 = v7(2,v7(3,v7(4,a14v5)))
    a14v4 = v3(3, v3(4, v10(2,3,4)))
    a14v3 = 4*p(2,1)-3
    a14v1 = 4*p(2,v2(a14v3, a14v4))
    a14u1 = v1(a14v1, a14v2)
    aVec[14] = 4*p(a14u1, a14u2)
    print("a14")
    
    a15u4 = v2(4*p(5,4)-3, v0(v6(5,3), v9(5,3,3)))
    a15u3 = v3(4,v1(4*p(4,2)-3, 4*p(5,a15u4)-1))
    a15u2 = v7(3,4*p(4*p(3,2)-3, a15u3))
    a15u1 = v3(4,v1(4*p(4,2)-3, v5(4)))
    aVec[15] = v8(2,v1(a15u1, a15u2))
    print("a15")
    
    return aVec

def f(j, aVec, y):
    if j == 1:
        print("At j = " + str(j))
        return 4*p(aVec[1], y)
    else:
        rec = f(j-1, aVec, y)
        print("At j = " + str(j))
        return 4*p(aVec[j], rec)

import sys
if len(sys.argv) != 2:
    print("Wrong argument format, aborting")
    print("Usage: sage diophantine_impossibly.py <output file>")
    print("WARNING: the output file will be 878 MB!")
    exit()

print("Writing to file " + sys.argv[1])
with open(sys.argv[1], 'w+') as outfile:
    aVec = computeAs()
    # Sort to keep the final magnitude down.
    # This does not change the meaning of the formula, just reorders
    # the axioms.
    aVec.sort()
    print("Computed a's.")
    C = f(15, aVec, 3)
    print("Computed value.")
    outfile.write(str(C))

