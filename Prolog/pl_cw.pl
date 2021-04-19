% Coursework template

% Varun Senthil , H00332328       <--- so we know who you are
% F28PL Coursework 3, Prolog    <--- sanity check

% Due: 11th December 2020
% Submit (this file) via GitLab as usual.

% You may assume variables, procedures, and functions defined in
% earlier questions in your answers to later questions, though you
% should add comments in code explaining this if any clarification
% might help read your code.

% For all questions, include testing in comments, so your marker can
% load this file as a database then cut-and-paste any testing into the
% command line.

% Testing on GitLab will NOT be provided for Prolog. Your own test
% will in this case be marked - note this is unlike the Python and
% OCaml coursework.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1   <--- Yes, so we know what question you think you're answering

% The complex numbers are explained here (and elsewhere):
%
%   http://www.mathsisfun.com/algebra/complex-number-multiply.html
%
% Represent a complex integer as a two-element list of integers, so
% [4,5] represents 4+5i.  Write Prolog predicates
%
%   cadd/3
%   cmult/3
%
% representing complex integer addition and multiplication. Thus for
% instance, cadd([X1,X2],[Y1,Y2],[Z1,Z2]) succeeds if and only if
% Z1=X1+Y1 and Z2=X2+Y2. Note that complex number multiplication is
% not just like complex number addition. Check the link and read the
% definition.
%
%   <--- always have the question under your nose

/*
Complex integer addition

(7+2i) + (2+i)
=> 7 + 2i + 2 + i
=> 9 + 3i

Test:
cadd([4,2],[1,4],[Z1,Z2]).
 => Z1 = 5
    Z2 = 6      
*/

cadd([X1,X2],[Y1,Y2],[Z1,Z2]) :- Z1 is X1+Y1 , Z2 is X2+Y2.

/*
Complex integer multiplication

(2+i) * (3+2i)
=> ((2*3) - (1*2)) + ((2*2) + (1*3))i
=> (6 - 2) + (4 + 3)i
=> 4+7i

Test:
cmult([2,1],[3,2],[Z1,Z2]).
=> Z1 = 4
   Z2 = 7 
*/

cmult([X1, X2], [Y1, Y2], [Z1,Z2]) :- Z1 is X1*Y1-X2*Y2, Z2 is X1*Y2+X2*Y1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END ANSWER TO Question 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2

% An integer sequence is a list of integers. Write a Prolog predicate
%
%   seqadd/3
%
% such that seqadd(Xs,Yy,Zs) succeeds when Xs and Ys are lists of
% integers of the same length and Zs is their sequence sum.

/*
Addition on two integer lists of same length

seqadd([1,2,3],[3,2,1],Z).
=> Xtail = [2,3] , Ytail = [2,1] , Zhead = Xhead + Yhead = 1 + 3 = 4
    => Z = [4]
seqadd([2,3],[2,1],Ztail).
=> Xtail =[3] , Ytail = [1] , Zhead = Xhead + Yhead = 2 + 2 = 4 
    => Z = [4,4]
seqadd([3],[1],Ztail).
=> Xtail = [] , Ytail = [] , Zhead = Xhead + Yhead = 3 + 1 = 4
    => Z = [4,4,4]
seqadd([],[],Ztail).
=> returns [] and thus, Z = [4,4,4] 

Test:
seqadd([1,2,3],[3,2,1],Z).
=> Z = [4,4,4]
*/

/* Base case for empty lists */
seqadd([],[],[]).

/* Split head and tail for X, Y and Z */
seqadd([Xhead | Xtail], [Yhead | Ytail], [Zhead | Ztail]) :-
/* Recursive call on the tails */
    seqadd(Xtail, Ytail, Ztail), Zhead is Xhead + Yhead.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END ANSWER TO Question 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3

% 3a. Explain what backtracking has to do with Prolog. You might find
% this webpage helpful:
%
%   https://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/search.html
%
% 3b. What is Cut in prolog and what does it have to do with
% backtracking? Explain your answer by giving examples of Cut used in
% at least one prolog rule, and explain how it affects the
% execution/resolution process.

/*
3a - BACKTRACKING

Backtracking is actually a way of searching in prolog.In prolog context, the interpreter tries to satisfy a sequence of goals. When the interpreter finds 
variables that can satisfy goal no. 1, it commits itself to goal no. 1 and then goes on to satisfy goal no. 2.
Only two situations can occur : goal no. 2 is satisfied or its not. After this, Prolog backtracks. It goes to goal no. 1 and tries to satisfy that goal
with different variable sets. if found, then it tries to satisfy goal no. 2 again. This is called backtracking.[1] 

Test:
likes(Alex, X). (Press "N" after to get results)
*/

likes(Alex, Pizza).     
likes(Alex, Burger).
likes(Alex, Donut).
likes(Alex, Taco). 

/*
3b - CUT

In Prolog, cut is a goal which succeeds, but cannot be backtracked past. It is used by the Prolog community to prevent unwanted backtracking, to prevent extra
solutions to be found.[2]

Test:
likes(Alex, Food), isFoodTasty(Answer, Food).   (Press "N" after running this in the terminal to get other answers)
likes(Alex, Food), !, isFoodTasty(Answer, Food).
*/

likes(Alex, Spinach).     
likes(Alex, Burger).

isFoodTasty(no, Spinach).
isFoodTasty(yes, Burger).

/*
References
[1]http://www.cse.unsw.edu.au/~billw/dictionaries/prolog/backtrack.html
[2]https://www.cpp.edu/~jrfisher/www/prolog_tutorial/3_2.html
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END ANSWER TO Question 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4

% Write a database for a predicate cycleoflife/1 such that the query
%
%   cycleoflife(X)
%
% returns the instantiations
%
%   X = eat
%   X = sleep
%   X = code
%   X = eat
%   X = sleep
%   X = code
%   ...
%
% in an endless cycle.
%
% (This question has a beautiful and simple answer. If you find
% yourself writing lines and lines of complex code, there’s probably
% something amiss.)

/*
Code to store the three words eat,sleep and code. Then we use recursion to store only the three words for ever.
After cycleoflife(X) is entered in the terminal, press "N" to get the next word. If we keep pressing "N", it will keep 
returning the next word.
*/

cycleoflife(eat).
cycleoflife(sleep).
cycleoflife(code).
cycleoflife(X) :- cycleoflife(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END ANSWER TO Question 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%