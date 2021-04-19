"""
These are NOT property-based tests, and as such, passing them does not mean that your code is fully correct.
Your mark will ultimately depend on how you have coded your answers.

You can and probably should write your own additional test code to test your answers.  Such additional test code will not be marked and it's fine if they are submitted to your fork, whether as part of the py_cw.py file or in a separate file.

To run these tests, type `pytest-3` within this directory.
"""
import py_cw
from random import randint


def test_q1a():
	s = py_cw.cadd((1, 0), (0, 1))
	p = py_cw.cmult((3, 2), (9, 6))
	assert s == (1, 1) and p == (15, 36)


def test_q1b():
	assert py_cw.tocomplex(1, 2) == (1 + 2j) and py_cw.fromcomplex(1 + 1j) == (1, 1)


def test_q2a():
	assert py_cw.seqaddi([1, 2, 3, 4], [2, 3, 4, 5]) == [3, 5, 7, 9] and py_cw.seqmulti([1, 2, 3, 4], [2, 3, 4, 5]) == [2, 6, 12, 20]


def test_q2b():
	assert py_cw.seqaddr([1, 2, 3, 4], [5, 4, 3, 2]) == [6, 6, 6, 6] and py_cw.seqmultr([1, 2, 3, 4], [5, 4, 3, 2]) == [5, 8, 9, 8]


def test_q2c():
	assert py_cw.seqaddlc([1, 2, 3, 4], [5, 4, 3, 2]) == [6, 6, 6, 6] and py_cw.seqmultlc([1, 2, 3, 4], [5, 4, 3, 2]) == [5, 8, 9, 8]


def test_q3_ismatrix():
	assert (not py_cw.ismatrix([[2,3,4], [3,2,6,7], [2,3,4]])) and py_cw.ismatrix([[], []])


def test_q3_matrixshape():
	m = [[1,2,3], [3,4,6]]
	assert py_cw.matrixshape(m) == (2, 3)


def test_q3_matrixadd():
	m1 = [[1,2,3], [3,4,6]]
	m2 = [[5,6,7], [7,6,4]]
	assert py_cw.matrixadd(m1, m2) == [[6, 8, 10], [10,10,10]]


def test_q3_matrixmult():
	m1 = [[2,3,4], [7,8,9]]
	m2 = [[1,0], [3,6], [8,2]]
	assert py_cw.matrixmult(m1, m2) == [[43,26], [103,66]]


def test_q5():
	assert py_cw.encdat(-10)== '-10' and py_cw.encdat(10.4) == '10.4'and py_cw.encdat(5+4.5j)=='5+4.5j' and py_cw.encdat(345)=='345' and py_cw.encdat(5+5j)=='5+5j' and py_cw.encdat('(5+5j)')=='(5+5j)' and py_cw.encdat('({))') == '({))'



def test_q6_fenc():
	assert py_cw.fenc(4)==[[[[[], [[]]], [[[], [[]]]]], [[[[], [[]]], [[[], [[]]]]]]], [[[[[], [[]]], [[[], [[]]]]], [[[[], [[]]], [[[], [[]]]]]]]]]


def test_q6_fdec():
	assert py_cw.fdec([[[[[], [[]]], [[[], [[]]]]], [[[[], [[]]], [[[], [[]]]]]]], [[[[[], [[]]], [[[], [[]]]]], [[[[], [[]]], [[[], [[]]]]]]]]])==4


def test_q7():
	n = randint(100, 1000)
	li = ['eat', 'sleep', 'code']
	g = py_cw.cycleoflife()
	y = None
	for _ in range(n):
		y = next(g)
	assert y == li[(n % 3) - 1]


def test_q8():
	assert py_cw.gendat([5,5,[5,[]],[],[5],[[5]]]) == [5,5,5,5,5]


def test_q9():
	p = None
	e = py_cw.eratosthenes()
	for _ in range(22):
		p = next(e)
	assert p == 79

def test_q10_determinant():
        m = [[8,4,2], [2,-3,5], [1,4,9]]
        assert py_cw.matrixdeterminant(m) == -406

def test_q10_minors():
        m = [[8,4,2], [2,-3,5], [1,4,9]]
        assert py_cw.matrixminors(m) == [[-47, 13, 11], [28, 70, 28], [26, 36, -32]]

def test_q10_cofactors():
        m = [[8,4,2], [2,-3,5], [1,4,9]]
        assert py_cw.matrixcofactors(m) == [[-47, -13, 11], [-28, 70, -28], [26, -36, -32]]

def test_q10_adjoint():
        m = [[8,4,2], [2,-3,5], [1,4,9]]
        assert py_cw.matrixadjoint(m) == [[-47, -28, 26], [-13, 70, -36], [11, -28, -32]]

def test_q10_inverse():
        m = [[8,4,2], [2,-3,5], [1,4,9]]
        assert round(py_cw.matrixdeterminant(py_cw.matrixmult(m, py_cw.matrixinverse(m)))) == 1
