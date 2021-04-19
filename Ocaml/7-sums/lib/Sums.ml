(* Coursework template

   Varun Senthil , H00332328          <--- so we know who you are
   F28PL Coursework 2, OCaml        <--- sanity check

   Deadline is 27 November 2020 (end week 11).

   You may assume variables and functions defined in earlier questions
   in your answers to later questions, though you should add comments
   in code explaining this if any clarification might help read your
   code.

   To do this coursework, FORK, THEN CLONE the gitlab project.

   If you do it the other way around, then you'll have cloned *my*
   project (which you can't `git push` to), rather than cloned *your
   fork* of the project (which you can `git push` to).

   Any questions, don't guess: ask.

   This coursework is live exam material so KEEP YOUR ANSWERS PRIVATE. *)

(* data type of addition expressions:

   a, b ::= 0 | x | a + b
*)
type exp = Zero | Var of string | Add of exp * exp

(* Write a pretty-printer that turns an expression into a string. It
   should not output any spaces. It should always place parentheses
   ('(' and ')') around an addition.
*)
let rec string_of_exp : exp -> string =
  function
  | Zero       -> "0"                                       (* Returns "0" if the expression contains 'Zero' *)
  | Var x      -> "" ^ x                                    (* Returns "x" if the expression conatins 'Var x' *)
  | Add (a, b) -> "(" ^ string_of_exp a ^ "+" ^ string_of_exp b ^ ")"     (* Places brackets and calls itself recursively by passing 'a' and 'b',while inserting a '+' between 'a' and 'b' *)

(* An environment is a list mapping variable names to integers *)
type env = (string * int) list

(* Write an expression evaluator that takes an environment and an
   expression and evaluates it to an integer.
*)
let rec eval : env -> exp -> int =
  fun env ->
  function
  | Zero       -> 0                                         (* Returns 0 if the expression contains 'Zero' *)      
  | Var x      -> List.assoc x env                          (* list.assoc maps x to its integer in the environment and returns the integer associated with x*)
  | Add (a, b) -> eval env a + eval env b                   (* Calls itself recursively *)


(* The standard laws that hold of expressions:

   (Left identity)       (0+a) == a
   (Right identity)      (a+0) == a
   (Associativity)   ((a+b)+c) == (a+(b+c))
   (Commutativity)       (a+b) == (b+a)
*)
(*

   - The identity laws tell us that zero doesn't matter.

   - The associativity law tells us that the way in which additions
   are nested doesn't matter.

   - The commutativity law tells us that the order of arguments to
   additions don't matter.

   Taken together identity and associativity mean that we can
   represent every expression as the sum of a sequence of variables:

   (x1+(x2+(x3+(...+xn)))

   This means we can represent any expression as a list of variables:

   [x1; x2; x3; ...; xn]

*)

(* expressions as lists of variables *)
type var_list = string list

(* Write a function that interprets a list of variables as an expression.

   inject [x1; x2; ...; xn] = Add (x1, Add (x2, ..., Add (xn, Zero)))
 *)
let rec inject : var_list -> exp =
  function
  | []        -> Zero                                   (* Returns 'Zero' if empty list is passed *)
  | (x :: xs) -> Add(Var (x),inject xs)                 (* Returns 'x' as an expression and calls itself recursively by passing xs *)

(* Write a function that flattens an expression to a list of variables *)
let rec flatten : exp -> var_list =
  function
  | Zero       -> ["0"]                               (* Returns ["0"] if the expression contains 'Zero' *)
  | Var x      -> ["" ^ x]                            (* Returns ["x"] if the expression contains 'Var x' *)
  | Add (a, b) -> flatten a @ flatten b               (* Calls itself recursively for 'a' and 'b' and appends them as one list *)  

(* We can now compare expressions for equivalence by checking whether
   their flattenings are equal *)
let compare_exps : exp -> exp -> bool =
  fun a b -> (flatten a = flatten b)


(*
   The compare_exps function should return `true` if two expressions are
   equivalent by the identity and associativity laws.

   To account for commutativity we need to do more.

   flatten (Add (Var "x", Var "y")) = [x; y]
   flatten (Add (Var "y", Var "x")) = [y; x]

   But [x; y] <> [y; x]

   Now write a new version of flatten that produces sorted
   variable lists (variables are strings so they can be sorted
   alphabetically):

   flatten_sorted (Add (Var "x", Var "y")) = [x; y]
   flatten_sorted (Add (Var "y", Var "x")) = [x; y]

   Hint: you may find it helpful to first implement a function for
   merging two sorted lists

   merge : 'a list -> 'a list -> 'a list

   (c.f. merge sort in f28pl-2020-21-ocaml-exercises)
*)
let rec merge : 'a list -> 'a list -> 'a list =
  fun xs ys ->
    match xs,ys with 
     xs,[] -> xs                      (* Returns the first list if the second list is empty *)
     |[],ys -> ys                     (* Returns the second list if the first list is empty *)
     |x::xs,y::ys -> if x < y         (* Checks if the head of the first list is less than the head of the second list *)  
                     then x::merge xs (y::ys)       
                     else y::merge (x::xs) ys;;       

let rec flatten_sorted : exp -> var_list =
  function
  | Zero       -> ["0"]              (* Returns ["0"] if the expression contains 'Zero' *) 
  | Var x      -> ["" ^ x]           (* Returns ["x"] if the expression conatins 'Var x' *)   
  | Add (a, b) -> failwith "not impl"


(* compare expressions for equivalence (taking into account
   commutativity) *)
let compare_exps_sorted : exp -> exp -> bool =
  fun a b -> (flatten_sorted a = flatten_sorted b)


(* Folding over addition expressions *)

(* The functions `eval`, `string_of_exp`, `flatten`, `flatten_sorted`,
   should all traverse the expression data type in the same way.

   Just as we can write a fold function, which abstracts over list
   traversal, we can also write a fold function that abstracts over
   the traversal of any algebraic data type.

   Write a fold function for addition expressions.

   fold : 'a -> (string -> 'a) -> ('a -> 'a -> 'a) -> exp -> 'a

   The first three arguments explain how to handle each constructor
   (Zero, Var, and Add). The last argument is the expression itself.
   *)
let rec fold : 'a -> (string -> 'a) -> ('a -> 'a -> 'a) -> exp -> 'a =
  fun zero var add ->
  function
  | Zero       -> failwith "not implemented yet"
  | Var x      -> failwith "not implemented yet"
  | Add (a, b) -> failwith "not implemented yet"

(* Now use fold to concisely re-express eval, string_of_exp, flatten,
   and flatten_sorted. Each definition should be a one-liner. *)

let eval' : env -> exp -> int =
  fun env -> failwith "not implemented yet"

let string_of_exp' : exp -> string =
  fun a -> failwith "not implemented yet"

let flatten' : exp -> var_list =
  fun a -> failwith "not implemented yet"

let compare_exps' : exp -> exp -> bool =
  fun a b -> (flatten' a = flatten' b)

let flatten_sorted' : exp -> var_list =
  fun a -> failwith "not implemented yet"

let compare_exps_sorted' : exp -> exp -> bool =
  fun a b -> (flatten_sorted' a = flatten_sorted' b)

(* NOT MARKED *)
(* Feel free to ignore everything that follows *)

(* (Optional) Hughes lists *)

(* Your flatten function (not the sorted version) requires two lists
   to be appended. In functional programming languages lists are
   internally represented as linked lists. This means that the append
   operation does not take constant time (in fact it is linear in the
   first argument) and algorithms that do a lot of appending can be
   slow.

   Hughes lists are a clever alternative functional encoding of
   lists. (They are named after John Hughes, a Haskell programmer, who
   made good use of them.)

   The idea is to represent a list as a function

   var_list -> var_list

   where the argument represents an opportunity to append an arbitrary
   list to the end of the current one. To obtain the standard
   representation of the list we just apply a Hughes list to the empty
   list. *)

(* the type of Hughes lists of variables *)
type var_list_fun = var_list -> var_list

(* empty Hughes list *)
let empty_fun                                        : var_list_fun = fun xs -> xs
(* singleton Hughes list *)
let singleton_fun (x : string)                       : var_list_fun = fun xs -> x :: xs
(* append two Hughes lists *)
let append_fun (f : var_list_fun) (g : var_list_fun) : var_list_fun = fun xs -> f (g xs)

(* Write a function that flattens an expression to a Hughes list. Your
   implementation should be a call to fold and should be a
   one-liner. *)
let flatten_fun : exp -> var_list_fun =
  fun a -> failwith "not implemented yet"

(* If you have implemented flatten_fun correctly, then
   compare_exps_fun should be much more efficient than compare_exps,
   as the append operation for Hughes lists takes constant time. *)
let compare_exps_fun : exp -> exp -> bool =
  fun f g -> (flatten_fun f [] = flatten_fun g [])


(* If you enjoyed this exercise then you might like to think about how
   to extend the expression data type with other features such as
   multiplication and the power function. The problem of deciding
   whether two expressions involving addition, multiplication, and
   powers, are equivalent is related to a famous problem in
   mathematics called Tarski's high school algebra problem:

   https://en.wikipedia.org/wiki/Tarski%27s_high_school_algebra_problem

   This kind of algebra problem has important practical applications,
   for instance, in generating efficient code for GPUs. *)
