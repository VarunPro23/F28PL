# Jamie's coursework template

# Varun Senthil, H00332328                           <--- so we know who you are
# F28PL Coursework 2, Python                         <--- sanity check

# Deadline is 17 October 2020 (end week 5)

# You may assume variables, procedures, and functions defined in earlier questions
# in your answers to later questions, though you should add comments in code explaining
# this if any clarification might help read your code.

# To do this coursework, FORK the repo on gitlab and work with that fork.  Any questions, don't guess: ask.

# This coursework is live exam material so KEEP YOUR ANSWERS PRIVATE.  

################################################################################
# Question 1   <--- Yes, so we know what question you think you're answering
import math

"""
The complex numbers are explained here (and elsewhere):
 http://www.mathsisfun.com/algebra/complex-number-multiply.html
Represent a complex integer as a pair of integers, so (4,5) represents 4+5i (or 4+5j, depending on the complex numbers
notation you use).
1a. Using def, define functions cadd and cmult representing complex integer addition and
multiplication.
For instance,
 cadd((1,0),(0,1))
should compute
 (1,1).
1b. Python has its own native implementation of complex numbers. Write translation functions
* tocomplex and 
* fromcomplex 
that map the pair (x1,y1) to the complex number x1+(y1)j and vice 
versa. You may use the python methods real and imag without comment, but not complex 
(use j directly instead).
"""
#  <--- always have the question under your nose

#####################################
# Question 1a


def cadd(c1, c2):
   return (c1[0] + c2[0] , c1[1] + c2[1])                               # The complex numbers image and real parts are being added


def cmult(c1,c2):
    return ((c2[0] - c2[1] + c1[1]) * c1[0]), (c1[0] * c2[1] * c1[1])   # The complex number's image and real parts are being multiplied.

#####################################
# Question 1b

def tocomplex(x1, y1):
    return x1 + y1 * 1j                                                  # Returns the integers pased as the real and image of the complex number  


def fromcomplex(c):
    x = int(c.real)                                                      # Converting the real part of the complex number into an integer   
    y = int(c.imag)                                                      # Converting the image part of the complex number into an integer      
    return x,y                                                           # Returns the converted integers   

# END ANSWER TO Question 1
################################################################################


################################################################################
# Question 2


"""
2a. Using def, write iterative functions 
* seqaddi and 
* seqmulti 
that implement pointwise
addition and multiplication of integer sequences.
For instance
 seqaddi([1,2,3],[~1,2,2])
should compute
 [0,4,5]
You need not write error-handling code to handle the cases that sequences have different
lengths.
2b. Do as for 2a, but make your functions recursive (like OCaml).
Call them seqaddr and seqmultr.
2c. Do it again. This time use list comprehensions instead of iteration or recursion.
Call them seqaddlc and seqmultlc.
"""

#####################################
# Question 2a

def seqaddi(l1, l2):                                                     
    sum = []                                                             # Initializing a empty list to store the sum of corresponding elements of two lists   
    for x in range(len(l1)):                                             # for loop to iterate through the list   
        sum.append(l1[x] + l2[x])                                        # Appends the sum of the corresponding elements of two lists into the list 'sum'
    return sum                                                           # Returns the list containing the sum


def seqmulti(l1, l2):
    product = []                                                         # Initializing a empty list to store the product of corresponding elements of two lists      
    for x in range(len(l1)):                                             # for loop to iterate through the list      
        product.append(l1[x] * l2[x])                                    # Appends the sum of the corresponding elements of two lists into the list 'sum'   
    return product                                                       # Returns the list containing the product

#####################################
# Question 2b

def seqaddr(l1, l2):
    if not l1:                                                           
        return []
    else:
        recur_sum = [(l1[0] + l2[0])]                                    # Adds the sum of the corresponding elements of two lists into the list 'recur_sum'   
        recur_sum.extend(seqaddr(l1[1:],l2[1:]))                         # Recursion   
        return recur_sum


def seqmultr(l1, l2):
    if not l1:
        return []
    else:
        recur_product = [(l1[0] * l2[0])]                                # Adds the product of the corresponding elements of two lists into the list 'recur_product'   
        recur_product.extend(seqmultr(l1[1:],l2[1:]))                    # Recursion   
        return recur_product

#####################################
# Question 2c

def seqaddlc(l1,l2):
    sum = [l1[x] + l2[x] for x in range(len(l1))]                        # Adds the sum of the corresponding elements of two lists into the list 'sum'
    return sum                                                           # List comprehension is used           


def seqmultlc(l1,l2):
    product = [l1[x] * l2[x] for x in range(len(l1))]                    # Adds the product of the corresponding elements of two lists into the list product       
    return product                                                       # List comprehension is used


# END ANSWER TO Question 2
################################################################################

################################################################################
# Question 3

"""
Write functions
● ismatrix
This should input a list of list of integers (henceforth an intmatrix) and test whether a list
of lists of integers represents a matrix (so the length of each row should be equal).
● matrixshape
This should input an intmatrix and return the size of the matrix, which is the number of rows and the number of columns 
(traditionally the number of rows is given first, but if you have done it the other way around that’s fine; 
just make sure to clearly explain your code). 

● matrixadd
Matrix addition, which is simply pointwise addition.
● matrixmult
Similarly for matrix multiplication.
You do not need to write error-handling code, e.g. for the cases that inputs do not represent
matrices or represent matrixes of the wrong shapes; so for instance your matrixshape may 
assume that the argument has successfully passed the test ismatrix.
Your answer can use iteration, recursion, list comprehension, or anonymous functions. You
should not appeal to any libraries, e.g. for matrix processing.  Don't use zip.
"""

def ismatrix(m):
    for row in m:                                               # Loops through the matrix
        if len(row) != len(m[1]):                               # Checks if the length of two rows are not equal 
            return False                                        # Returns false
    return True                                                 # Returns true if the lengths are equal


def matrixshape(m):
    return len(m),len(m[0])                                     # Returns the no. of rows and columns in the matrix to determine the shape of the matrix


def matrixadd(m1,m2):
    sum = [ [0,0,0] , [0,0,0] ]                                 # Initializing an empty matrix        
    for i in range(len(m1)):                                    # Loops through the matrix's rows
        for j in range(len(m1[0])):                             # Loops through the matrix's columns    
            sum[i][j] = m1[i][j] + m2 [i][j]                    # Adds the corresponding elements of the matrix and stores in the matrix 'sum'
    return sum


def matrixmult(m1,m2):
    product = [[0 for i in range(len(m1))] for j in range(len(m2[0]))]          # Initializing an empty matrix 
    
    for x in range (len(m1)):                                                   # Loops through the first matrix's rows    
        for y in range (len(m2[0])):                                            # Loops through the second matrix's columns    
            for z in range (len(m2)):                                           # Loops through the second matrix's rows
               product[x][y] += m1[x][z] * m2[z][y]                             # Stores the product in the empty matrix 
    return product
              
# END ANSWER TO Question 3
################################################################################


###############################################################################
# Question 4


"""
Write an essay on Python data representation. Be clear, to-the-point, and concise. Convince
your marker that you understand:
● Mutable vs immutable types. Give at least two examples of each, with explanation.
● Integer vs float types.
● Assignment = vs equality == vs identity is.
● The computational effects of a call to list on an element of range type, as in
list(range(5**5**5)).
● Slices, with examples. Including an explanation of the difference in execution between
 list(range(10**10)[10:10]) and
 list(range(10**10))[10:10]
Include short code-fragments where appropriate (as I do when lecturing) to illustrate your
observations.
"""
"""
Python like any other programming language, has different data types. Inn, float, string, double are just examples from a vast list.
Lets begin with mutable and immutabe data types. When an object is initialised, a unique id is assigned to it. This id is the instance of the object.
The difference between a mutable and an immutable object is that, this unique id can be changed for a mutable object while it cannot be changed for immutable data types.
Mutable data types inlcude list,dictionary and sets. Immutable data types inlcude int,float,string and tuples. Let us look at an example of each type.For example,
if an int is intialized and given an identifier, when the value of the int variable changes, the identifier changes as well. But in the case of a list, the identifier
does not change if any changes are made to the list.  Immutabale objects dont allow for modification after the creation of the object[1].

Integer data type refers to the data with no decimal point. They are whole numbers and can be either poistive or negative. On the other hand, float
data type refers to real numbers and can contain decimal points."""

x = 10          #Integer data type
y = 3.14        #Float data type
"""
A single '=' sign refers to assignment. This sign is used to show that some value is being assigned to an object. Double '==' sign refers to equality. This sign is used
to check if two objects contain the same value. The identity 'is' is used to check if two variables are pointing to the same value.[2]  """

x = 10          #This is assignment
if(x==10):      #This is equality    
    pass       

"""
list(range()) is used to generate a computation for the given range. Here, the condition in the range is 5**5**5, which means the range is from 0 to 5 to power of 
5 to the power of 5. It roughly translates to 3125 to the power of 5, which is a very huge number. This means that a list with index 0 to 3125^5 is created.

Python makes use of lists,arrays,tuples etc. To get a specific subset from these data structures, we use slices. Lets look at different examples of slicing with an 
array a = [1,2,3,4,5,6,7].

a[1:4] --> This slicing gives elements from index 1 upto index 4, excluding the value at index 4.
a[1:4:2] --> This slicing gives elements from index 1 upto index, excluding the value at index 4 and the slicing increment is 2. This skips every 2nd index value.
             By default, the slicing increment is 1.
If there is no value before the colon, it means start from the first element. If there is no value after the colon, it means go till the end of the list.
a[-5:-2] --> This slicing gives elements from index 5 to index 2, whhere the value at index 2 is excluded. This is called negative slicing.
list(range(10)[2:4]) --> This gives out a list with values from index 2 to index 4, where index 4 is excluded.
list(range(10**10))[10:10] --> This is a slow and inefficient way of slicing. Here, the range is calculated and a list of that range is created first and then the 
                                slicing takes place.
list(range(10**10)[10:10]) --> This slicing gives the same output as above, but much faster and efficiently.Here, the range is calculated and the slicing takes place,
                               only then is the list created. 

[1]https://medium.com/@meghamohan/mutable-and-immutable-side-of-python
[2]https://www.blog.pythonlibrary.org/2017/02/28/python-101-equality-vs-identity/"""
# END ANSWER TO Question 4
################################################################################


###############################################################################
# Question 5
#print('Question 5')

"""
Write a general encoding function encdat that will input an integer, float, complex number, or
string, and return it as a string.

So
• encdat(-5) should return '-5'
• encdat(5.0) should return '5.0'
• encdat(5+5j) should return '5+5j' (not '(5+5j)'; see hint below).
• encdat('5') should return '5'


"""
def convert_to_string(i):                                                                 # Helper function to convert int or float to string
    if type(i) == int:
        new_string = ""                                                                   # Initialize a new empty string to store the converted string     
        if i == 0:                                                                        # Checks if the int passed is 0  
             return '0'                                                                   # Returns 0      
             
        while i > 0:                                                                      # Condition to check if int is a positve number  
            #ord() returns an integer representing the unicode character
            #chr() returns the character that represents the unicode.
            new_string = chr((i%10) + ord('0')) + new_string                              # ord('0') will return 48, so the unicode of 5 will be 48+5=53. 
            #The empty string stores the new converted string 
            i //= 10  
        
        return new_string
    
    elif type(i) == float:
        length_of_dec = len(str(i).split('.')[1])                                         # Gets the number of decimal places in the float.  
        # split('.') splits the float converted to string using str()
        # after the decimal point
    
        decimal = round(i * pow(10,length_of_dec)) - (int(i) * pow(10,length_of_dec))     
        # Converts float to int and subtracts the whole number part of 
        # the float and then rounds it off to maintain precision  
        return convert_to_string(decimal)

def complex_to_string(z):
    real1 = 0
    imag1 = 0
    
    if (z.real.is_integer()):                     # Checking if the real part of the complex is an integer
        real1 = int(z.real)
    else:
        real1 = z.real
        
    if (z.imag.is_integer()):                     # Checking if the image part of the complex is an integer  
        imag1 = int(z.imag)
    else:
        imag1 = z.imag
        
    if(z.imag >= 0):                              # Checking if the image is greater than 0 
        sign = "+"
    else:
        sign = ""
    return encdat(real1) + sign + encdat(imag1) + 'j' 
    # Returns the complex number as string by passing the real and image parts of the
    # complex number as integers into the main function, where it will convert the integer into string


def encdat(dat):
    sign = ""                                                                         # Empty string that stores the sign  
  

    # If loop to find out the data type of the arguement
    if type(dat) == str:                                # If data type is string, it returns the arguement itself                                    
        return dat

    elif type(dat) == int:                              # If data type is int        
        if (dat < 0):                                   # It checks if the integer is negative    
            sign = "-"                                  # If negative, the 'sign' string stores a '-'
        else:
            sign = ""                                   # Otherwise it leaves the 'sign' string empty        
        return sign + convert_to_string(abs(dat))       # Calls the helper function by passing the arguement as an absolute value    
    
    elif type(dat) == float:                            # If data type is float,
        bf_dec = encdat(int(dat))                       # bf_dec stores the part before the decimal which is converted from int to string using recursion
        af_dec = convert_to_string(abs(dat))            # af_dec stores the part after the decimal which is converted to string using the helper function
        return bf_dec + "." + af_dec                    # Returns both the strings into one concatenated string

    elif type(dat) == complex:                          # If data type is complex,       
        return complex_to_string(dat)
    
    else:                                               # If none of the types,                                  
        return None                                     # Returns none

# END ANSWER TO Question 5
################################################################################


###############################################################################
# Question 6

"""
An encoding f of numbers in lists is as follows:
• f(0) = [] (0 maps to the empty list)
• f(n+1) = [f(n),[f(n)]] (n+1 maps to the list that contains f(n) and singleton f(n))
Implement encode and decode functions in Python, that map correctly between nonnegative
integers and this representation. Call them fenc and fdec.
"""

def fenc(i):
    if i == 0:                                              # Checks if the arguement is zero
        return []                                           # Returns an empty list if the arguement is 0    
    else:
        return [fenc(i-1), [fenc(i-1)]]                     # Otherwise encodes the input as f(i+1) = [f(n),[f(n)]]        

def fdec(l):
    if not l:                                               # Checks if the arguement is not a list    
        return 0                                            # Returns 0 if the arguement passed is not a list
    else:
        return 1 + fdec(l[0])                               # Otherwise the list is decoded using recursion

# END ANSWER TO Question 6
################################################################################


###############################################################################
# Question 7


"""
Implement a generator cycleoflife such that if we assign
 x = cycleoflife()
then repeated calls to
 next(x)
return the values
 eat
 sleep
 code
 eat
 sleep
 code
 ...
in an endless cycle. If you can’t manage an endless cycle, do a program that runs for 1000
cycles then stops.
Note that this question is not asking you to program an endless loop that prints these values.
In effect, I am asking you to implement what is called a stream (infinite list)
 x = [eat, sleep, code, eat, sleep, code, ...].
This does not mean the whole infinite datastructure is in memory at any time (which is 
impossible for a machine with finite memory), but for any finite but unbounded number of calls 
to next your generator behaves as if it were the infinite datastructure illustrated above.
"""


def cycleoflife():
    x = ["eat","sleep","code"]                                                       # List containing the activities           
    i = 0                                                                               
    while True:                                                                      # Creates an infinte loop   
        yield x[i % len(x)]                                                                 
        i = i + 1                                                                    # Increments i to keep going through the list   


# END ANSWER TO Question 7
################################################################################


#################################################################################
# Question 8

"""
Call a *datum* something that is either an integer, or a list of data (datums).

Write a flatten function gendat that converts a datum to a list of integers.

So
- gendat(5) should return [5]
- gendat([])should return []
- gendat([5,[5,[]],[],[5]]) should return [5,5,5]

Do not use str.  You may find it useful to consider isinstance or the following code fragment
   type(5) == type([]) 
"""


def gendat(datum):      
        if type(datum) is list:                                                 # Checks if arguement passed is of type 'list'
           return [elements for lists in datum for elements in gendat(lists)]   # Uses recursion to flatten the list by passign the list again through the same function     
        else:
            return [datum]                                                      # If not of type 'list', stores it
    

# END ANSWER TO Question 8
################################################################################


##########################################################
# Question 9

"""
Implement the Sieve of Eratosthenes
 https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
as a Python generator eratosthenes such that if we assign
 x = eratosthenes()
then repeated calls to
 next(x)
return the primes, starting from 2.
"""

def eratosthenes():
    x = 2                                                                               # The number that is being processed
    prime_numberlist = [True] * x                                                       # Creating a boolean list with no. of elements being the number in process

    while True:                                                                         
        prime_numberlist.append(True)                                                   # Adds a new element

        for a in range(2, math.ceil(len(prime_numberlist) ** 0.5)):                     # Loops through each value till the square of the length of the boolean list
            if prime_numberlist[a]:                                                     # Checks if the element at the iteration has a true value            
                for b in range(a * 2,len(prime_numberlist),a):                          # Loops from a*2 till the length of the boolean list in jumps of a                
                    prime_numberlist[b] = False                                         # Sets anything in that range as False
        
        if prime_numberlist[x]:                                                         # If the value is true at that index, then its a prime number
            yield x                                                                     # Yields the current location 
        x+=1                                                                            # Increments the iterator value


"""
# For reference, here is an implementation of the sieve of Eratosthenes, 
# whose argument acts as a bound on the returned generator (40000, by default). 
# Your answer should take no argument, and should return an unbounded generator.
def eratosthenes(z=40000):
    # create an array of true values the size of z
    A = [True] * z
    # iterate over each value to z squared
    for x in range(2, int(z ** 0.5)):
        # if A[x] has a true value
        if A[x]:
            # iterate over a range starting from x*2 ending at z in jumps of x
            for z in range(x * 2, z, x):
                # set anything in the range to false
                A[z] = False
    # iterate over the array
    for y in range(2, len(A)):
        # if a value is true that index is a prime number
        if A[y]:
            # yield the current iterator location as it is a prime
            yield y"""




# END ANSWER TO Question 9
################################################################################


################################################################################
# Question 10

"""
Following on from Question 3, invertible matrices are explained here:
   https://en.wikipedia.org/wiki/Invertible_matrix
   https://en.wikipedia.org/wiki/Minor_(linear_algebra)#Inverse_of_a_matrix

Write and test an algorithm to calculate the inverse of an n x n matrix (i.e. a square matrix) using Cramer's rule, for n>=1.

* Your answer should include helper functions (and tests for them) to calculate the
* *determinant*,
* *minors*,
* *cofactors*, and
* *adjoint* of a matrix, all of which are described here:
   https://en.wikipedia.org/wiki/Minor_(linear_algebra)
   https://www.mathsisfun.com/algebra/matrix-inverse-minors-cofactors-adjugate.html
* Your code will be marked on clarity as well as correctness.  Code that is "correct" but unreadable, is bad code and therefore may get bad marks.

Writing, documenting, and testing helper functions is generally good practice, and you will likely find other helper functions are required, such as for matrix transpose, computing a sub-matrix, multiplying a matrix by a scalar, and perhaps others.  

Whatever you do, just make sure you explain what you're doing and why. 
"""

def matrixdeterminant(m):
    det = 0                                                             # Variable to store the determinant                                       
    for i in range(len(m)):                                             # Looping through the rows of the matrix
        p = 1                                                               
        n = 1
        for j in range(len(m)):
            p *= m[j][(i+j) % len(m)]                                   
            n *= m[j][(i-j) % len(m)]
        det += (p - n)
    return det                                                          # Returns the determinant

def matrixminors(m):
    pass   

def matrixcofactors(m):
   pass


def matrixadjoint(m):
    pass

def matrixinverse(m):
    pass
               

# END ANSWER TO Question 10
################################################################################


###############################################################################
# Question 11

"""
Write a brief but comprehensive essay that:
1. Surveys the modern uses and applications of Python.
2. Speculates on what it is about Python that has led to its popularity.
3. Speculates on the evolution of Python into the future.  

Your essay should not be long.  

For full marks your answer should demonstrate both factual and technical understanding of the programming languages landscape in general, and of Python's role --- technically, economically, and socially --- within it.
"""


"""
Here's a very brief example answer to Q11 above where "Python" is replaced by "Eggs".  Enjoy:

A chicken is cheap to keep, can produce an egg a day, and eggs come prepackaged and naturally resist spoilage.  For instance, eggs come out of a chicken with a natural antibacterial coating on their shells so that they can be stored at room temperature, which keeps transport costs low --- in the US eggs are washed, which stops them smelling of chickens' bottoms but removes this coating, which is why US eggs require refrigeration and UK eggs don't. 
[note now this combines *factual* and *technical* elements; an awareness of the egg as a thing, but also of supply chain economics, food safety, and a nice factoid which really proves I went beyond the first page of Google results -mjg] 

Eggs are nutritious, tasty, and filling.  They are easy to cook and are culturally well-established in the UK.  A proper superfood, in fact.  

Eggs do have dangers: when improperly handled they can carry salmonella.  More information at [hyperlink].  Eggs can crack, and then spoil quickly.  Occasionally eggs go invisibly bad, or the embryo incubates prematurely (nowadays, sophisticated scanning machines eliminate these from the food chain). 

Eggs also have applications in vaccine development, and unfortunately also in biological warfare as incubators for germs, and [more stuff here -mjg].

For the future, [stuff about vegans, changes in food preferences, vat-grown protein, environmental costs of keeping chickens, etc etc].

[I could keep this up for pages, I won't: we've gone beyond the shell of an answer, we've cracked it, and if we allow our enthusiasm to egg us on then it would over-egg the pudding and we'd get egg on our faces for writing a not-eggsactly-concise answer:  we stuffed enough eggs in this basket and should stop, before the reader finds it eggscrutiating.   
Now your turn please, with "Python" instead of "Egg".  Make me proud.  -mjg]
""" 
"""
Python is making its way to the top of the list of widely used programming languages. Some of the reasons include ease of learning, cost (its free) and the main reason, its a high level programming langauge. Its a dynamic and interpreted language which makes debugging of errors easy. These factors allow for speedy and error-free development of web applications.
Python also supports cross platform operating systems, which makes application building easy. Youtube, Dropbox etc are some of applications that make use of python. But why is python able to create applications at a rapid rate? Its beacuse of the frameworks in python which is used to create applications. Multiple frameworks and libraries are inbuilt in python to
help integrate various protocols such as HTML, FTP and even JSON. This makes it a highly demanded programming language. Python is also used in interactive game development. PySoy is a library that aids in creating 3D game environments.
Machine Learning and Artificial Intelligence are promising careers of the future. Inbuilt libraries like NumPy, Pandas can be used to support the development of machine algorithm. These are some of the reasons why knowledge of python is in such high demand nowadays.[1]

Why has Python shot to fame so suddenly? Its because its simple and easy to learn. When the language was designed, the designers gave less importance to conventional syntax, so that newcomers can learn the language easily. Also, it has been considered universal since it gives a lot of options to programmers in general. Various industries make use of Python, so
programmers can change careers to an unrealted industry as well. Another reason for its popularity is that the python developer community is an actve community, so programmers can always find support. The libraries that python offer is a major reason for its popularity. It helps to cut down development time of a project significantly. Python is also reliable and
efficient. It can be used in almost every environment and depoly applications for all platforms, making it a one stop solution for the IT department. This makes it a highly popular language.[2] 

With the development of Artificial Intelligence and Machine Learning, python has a strong future. Speech and facial recognition, data interpretation, neural networking are some examples of where python is useful. The cost of python enables small and mid-sized companies to enter the AI market. Ease of learning, libraries and tools help python have a strong foothold 
in Machine Learning and Big Data. With big companies like Google, Facebook using Python for AI, the developer community has seen a significant increase in python learners. No other language has shown such a growth in the last 15 years or has been able to compete with python in terms of growth. Some say python has the potential to spawn new programming languages in the future.
Python is also capable of frontend and backend development, which aids in the development of Machine Learning. This shows that python has a strong future. 

[1]https://www.edureka.co/blog/python-applications/
[2]https://www.kdnuggets.com/2017/07/6-reasons-python-suddenly-super-popular.html
"""
# END ANSWER TO Question 11 
###############################################################################
