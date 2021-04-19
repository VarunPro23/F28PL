(* Coursework template

   My Name here, My UserID          <--- so we know who you are
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

(* type aliases for integer sequences and integer matrices *)
type int_seq = int list
type int_matrix = int_seq list


(* useful for debugging *)
let string_of_row row =
  String.concat ""
    (List.map (fun x -> string_of_int x ^ " ") row)

(* useful for debugging *)
let rec string_of_matrix m =
  match m with
      | []            -> ""
      | [[]]          -> ""
      | (row :: rest) ->
         string_of_row row ^ "\n" ^
         string_of_matrix rest

(* Helper function to retrieve the body the matrix which is int_seq list*)
let retbody x = x;;

(* Helper function to get the length of each row in a matrix (taken from lectures) *)         
let rec length: 'a list -> int =
  fun xs ->
  match xs with
  [] -> 0
  | (x::rest) -> 1 + length rest;;

(* Helper function to add the rows of the matrix. This is the same function as seq_add. *)
let rec row_add : int_seq -> int_seq -> int_seq =
  fun xs ys ->
  match xs ,ys with
  | [],_ -> []                        (* Returns an empty list if either of the rows are empty *)
  | _,[] -> []
  | h1::rest1 , h2::rest2 -> (h1+h2)::(row_add rest1 rest2);;    (* Adds the heads of both rows, and calls itself recursively by passing the rows's tails as argument *)

(* Helper function to multiply the rows of the matrix. This is the same function as seq_mult *)
let rec row_mult : int_seq -> int_seq -> int_seq =
  fun xs ys ->
  match xs ,ys with
  | [],_ -> []                        (* Returns an empty list if either of the rows are empty *)
  | _,[] -> []
  | h1::rest1 , h2::rest2 -> (h1*h2)::(row_mult rest1 rest2);;   (* Multiplies the heads of both rows, and calls itself recursively by passing the rows's tails as argument *) 

(* test whether a list of lists of integers represents a matrix.  The
   length of each row should be equal.*)
   let is_matrix x =
    let rec is_matrix_step : int list list -> bool =                      (* Inner function to implement recursion*)
      fun x ->
        match x with                                                      (* Pattern matching *)
          [] -> true                                                      (* Returns true if empty list is passed *)
          |[[]] -> true                                                   (* Returns true if empty matrix is passed *)  
          |h::[] -> true                                                  (* Returns true if there is a list at the head and empty rest *) 
          |h::y::t -> if (length h == length y)                           (* Checking if the length of head and the next row are equal *)
                         then is_matrix_step (y::t)                       (* If the first 2 rows are equal, then the function is called recursively to check if the other rows are equal as well*)
                         else false                                       (* If not equal, then false *)
      (* Implement the above in is_matrix_step with x *)                   
      in is_matrix_step x;; 

(* function matrixshape takes the matrix, and calculates the number of
   columns and rows *)
let matrix_shape x =
  match x with
  [] -> (0,0)                                                   (* Returns (0,0) if empty list *)
  | [[]] -> (0,1)                                               (* Returns (0,1) if empty matrix because since 1 row is present *)    
  | (x::rest) -> (length x, length rest + 1);;                  (* Else returns the length of rows and columns *)

(* matrix addition *)
let [@warning "-8"] rec matrix_add x y =                        (*'[@warning "-8"] is added to suppress warnings*)
  match x,y with
    [],[] -> []                                                 (* Returns an empty matrix if two matrices are added *)    
    | [[]],[[]] -> [[]]
    | (x::tail1),(y::tail2) -> (row_add x y) :: ((matrix_add tail1 tail2))    (* Calls row_add with the heads of both matrices and calls itself recursively 
                                                                              using the tails of both matrices *)

(* helper function to get the sum of all elements in a int_seq*)
let rec sum_of_seqlist : int_seq -> int =
  fun xs ->
    match xs with
      [] -> 0                                                   (* Returns sum as 0 if its an empty list *)
      | (h::t) -> h + sum_of_seqlist t;;                        (* Adds the head to the output of its recursive call passing the tail *)

(* raising ListError exceptions *)
exception ListError of string;;

(* helper function to get the head of a list *)
let head (xy:'a list) : 'a = 
  match xy with 
    [] -> raise (ListError "Cannot get head of an empty list")        (* Raises an error if its an empty list *)  
    | (x::rest) -> x;;                                                (* Otherwise, returns the head of the list *) 

(* helper function to get the tail of a list *)    
let tail xy =
  match xy with 
    [] -> raise (ListError "Cannot get tail of an empty list")        (* Raises an error if its an empty list *)
    | (x::rest) -> rest;;                                             (* Otherwise, returns the tail of the list *)

(* helper function to get the transpose of a matrix*)
let rec transpose : int_seq list -> int_seq list =
  (* int_seq list is used in order to apply map function *)                        
  fun xy ->
    match xy with
      [] -> []                                                        (* Returns an empty list if an empty matrix is passed *)
      | []::_ -> []
      (* For the rows in int_seq list, we are mapping head to the rows and cons it to the transpose of
      the mapping of tail to the rows *)
      | xy_rows -> (List.map head xy_rows) :: transpose (List.map tail xy_rows);;   

(* helper function to get the dotproduct of two matrices *)
let [@warning "-8"] rec dot_product : int_matrix -> int_matrix -> int_seq =      (*'[@warning "-8"] is added to suppress warnings*)
  fun m1 m2 ->
    match m1,m2 with
      |(m1_rows),(m2_rows) ->                         (* Rows of the matrix are taken as matrices *)
        match (m1_rows), (transpose m2_rows) with     (* Pattern matching using the rows of m1 and the transpose of rows of m2 *) 
          [],[] -> []                                 (* Empty list is returned if both are empty *)
          | m1_rows ,[] -> []                         (* Empty list is returned if the transpose of rows of m2 is empty *)
          
          (* 1. Calculate the sum of the list returned by multiplying the rows of m1 and columns of m2
             2. Cons this with the dot product of rows of m1 and the transpose of the rest of the colmns of m2  *)
          |[m1_rows], m2_col::m2_col_rest -> sum_of_seqlist (row_mult m1_rows m2_col) :: dot_product (([m1_rows])) (transpose m2_col_rest);;

(* matrix multiplication *)
let matrix_mult x y =
  (* Inner function to implement recursion *)
  let rec matrix_mult_step : int_seq list -> int_matrix -> int_matrix -> int_matrix =
    fun acc mat1 mat2 ->                              (* Accumulator is used to return 3 matrices*)
      match mat1,mat2 with                            (* Pattern matching *)
        |(mat1_rows),(mat2_rows) ->                   
        (* For the rows of the matrices, perform pattern-matching *)  
          match mat1_rows , mat2_rows with
            [],[] -> acc                              (* If they are empty, return the accumulator*)
            | [],mat2_rows -> acc                     (* If row of mat1 is empty but row of mat2 is not empty, then return the accumulator *)    
            | mat1_rows,[] -> []                      (* If row of mat1 is not empty but row of mat2 is empty, then return empty since this is multiplying by 0 *)   
            (* 1. We are calling matrix_mult_step recursively
               2. Appending the accumulator to 3 matrices, which are:  
                2a. the dot product of row of mat1 and columns of mat 2
                2b. the rest of the rows in m1
                2c. the rest of the columns in m2  *)   
            | (mat1_rows::mat1_rows_rest),(mat2_col) -> matrix_mult_step (acc @ ([dot_product (([mat1_rows])) ((mat2_col))])) (mat1_rows_rest) (mat2_col)
    (* Implement the above in matrix_mult_step on empty accumulator ,x and y *)
    in matrix_mult_step [] x y;;
