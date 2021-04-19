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
open Matrices
open OUnit2


(* unit tests *)

let matrix_empty = []

(* testing if empty matrix is a valid matrix (is_matrix) - should
   return `true` *)
let is_matrix_empty_test1 _test_ctxt =
  assert_bool "is_matrix should return true" (is_matrix matrix_empty)

(* testing the empty list - should return `true` *)
let matrix_one_row_zero_columns = [[]]

(* testing if matrix with one empty row is a valid matrix (is_matrix) -
   should return `true` *)
let is_matrix_empty_test2 _test_ctxt =
  assert_bool "is_matrix should return `true`" (is_matrix matrix_one_row_zero_columns)

let matrix_one_row = [[1]]

(* testing is_matrix - should return `true`, as one row is still of equal
   length *)
let is_matrix_one_row _test_ctxt =
  assert_bool "is_matrix should return `true`" (is_matrix matrix_one_row)

let matrix_two_rows = [[1];[2]]

(* testing is_matrix with is_matrix_two_rows - should return `true`, as two
   rows is still of equal length *)
let is_matrix_two_rows _test_ctxt =
  assert_bool "is_matrix should return `true`" (is_matrix matrix_two_rows)

let matrix_three_rows = [[1];[2];[3]]

(* testing is_matrix with is_matrix_three_rows - should return `true`, as two
   rows is still of equal length *)
let is_matrix_three_rows _test_ctxt =
  assert_bool "is_matrix should return `true`" (is_matrix matrix_three_rows)

let matrix_three_rows_two_columns = [[1;2];[2;3];[3;4]]

(* testing is_matrix with is_matrix_three_rows *)
let is_matrix_three_rows_two_columns _test_ctxt =
  assert_bool "is_matrix should return `true`" (is_matrix matrix_three_rows_two_columns)

let matrix_four_rows_four_columns = [[1;2;3;4];[2;3;4;5];[3;4;5;6];[1;2;3;4]]

(* testing is_matrix with is_matrix_four_rows *)
let is_matrix_four_rows_four_columns _test_ctxt =
  assert_bool "is_matrix should return `true`" (is_matrix matrix_four_rows_four_columns)

let not_a_matrix1 = [[1;2];[2;3];[3;4;5;6]]

(* testing is_matrix with not_a_matrix1 *)
let is_matrix_no1 _test_ctxt =
  assert_bool "is_matrix should return false" (not (is_matrix not_a_matrix1))

let not_a_matrix2 = [[1;2;3];[2;3;4;5];[3;4;5;6]]

(* testing is_matrix with not_a_matrix2 *)
let is_matrix_no2 _test_ctxt =
  assert_bool "is_matrix should return false" (not (is_matrix not_a_matrix2))

(* this tests whether every adjacent row is compared, rather than just
   row1 and row2, then row3 and row4, etc. *)
let not_a_matrix3 = [[1;2;3];[4;5;6];[3;4;5;6];[3;4;5;6]]

(* testing is_matrix with not_a_matrix3 *)
let is_matrix_no3 _test_ctxt =
  assert_bool "is_matrix should return false" (not (is_matrix not_a_matrix3))

let matrix_shape_empty _test_ctxt =
  assert_equal (0,0) (matrix_shape matrix_empty)

let matrix_two_rows_three_columns = [[2; 3; 4]; [1; 2; 3]]

(* test for the correct shape of matrix_two_rows_three_columns *)
let matrix_shape_two_rows_three_columns _test_ctxt =
  assert_equal (3,2) (matrix_shape matrix_two_rows_three_columns)

let matrix_one_row_one_column = [[1]]

(* test for the correct shape of matrix_one_row_one_column *)
let matrix_shape_one_row_one_column _test_ctxt =
  assert_equal (1,1) (matrix_shape matrix_one_row_one_column)

(* test for the correct shape of matrix_one_row_zero_columns *)
let matrix_shape_one_row_zero_columns _test_ctxt =
  assert_equal (0,1) (matrix_shape matrix_one_row_zero_columns)

let matrix_four_rows_four_columns = [[1; 2; 3; 4]; [2; 3; 4; 5]; [3;4;5;6]; [1; 2; 3; 4]]

(* test for the correct shape of matrix_four_rows_four_columns *)
let matrix_shape_four_rows_four_columns _test_ctxt =
  (* TODO *)
  assert_equal (4,4) (matrix_shape matrix_four_rows_four_columns)

(* test adding matrix_one_row_zero_columns to itself *)
let matrix_add_empties _test_ctxt =
  assert_equal ([[]]) (matrix_add matrix_one_row_zero_columns matrix_one_row_zero_columns)

let matrix_4x4_1 = [[1; 2; 3; 4]; [2; 3; 4; 5]; [3; 4; 5; 6]; [1; 2; 3; 4]]
let matrix_4x4_2  =[[1; 2; 3; 4]; [2; 3; 4; 5]; [3; 4; 5; 6]; [1; 2; 3; 4]]

(* test adding matrix_4x4_1 to matrix_4x4_2  *)
let matrix_add_4x4 _test_ctxt =
  assert_equal
    ([[2; 4; 6; 8]; [4; 6; 8; 10]; [6; 8; 10; 12]; [2; 4; 6; 8]])
    (matrix_add matrix_4x4_1 matrix_4x4_2)

let matrix_4x1_1 = [[2]; [2]; [-1]; [-1]]
let matrix_4x1_2 = [[-1]; [-1]; [1]; [1]]

(* test adding matrix_4x1_1 to matrix_4x1_2  *)
let matrix_add_4x1 _test_ctxt =
  assert_equal
    ([[1]; [1]; [0]; [0]])
    (matrix_add matrix_4x1_1 matrix_4x1_2)

let matrix_3x3_1 = [[5; 6; 7]; [1; 4; 6]; [6; 8; 3]]
let matrix_3x3_2 = [[4; 7; 8]; [3; 6; 8]; [1; 2; 3]]

(* test adding matrix_3x3_1 to matrix_3x3_2  *)
let matrix_add_3x3 _test_ctxt =
  assert_equal
    ([[9; 13; 15]; [4; 10; 14]; [7; 10; 6]])
    (matrix_add matrix_3x3_1 matrix_3x3_2)

(* multiplying matrix_empty to itself should be an empty matrix  *)
let matrix_mult_empty _test_ctxt =
  assert_equal
    ([])
    (matrix_mult matrix_empty matrix_empty)

let matrix_mult_zero_columns _test_ctxt =
  let matrix1 = [[]] in
  let matrix2 = [[]] in
  assert_equal
    ([[]])
    (matrix_mult matrix1 matrix2)

(* test multiplying two 3x3 matrices together *)
let matrix_mult_3x3 _test_ctxt =
  let matrix1 = [[5; 6; 7]; [1; 4; 6]; [6; 8; 3]] in
  let matrix2 = [[4; 7; 8]; [3; 6; 8]; [1; 2; 3]] in
  assert_equal
    ([[45; 85; 109]; [22; 43; 58]; [51; 96; 121]])
    (matrix_mult matrix1 matrix2)

(* test multiplying two 3x2 matrices together *)
let matrix_mult_3x2 _test_ctxt =
  let matrix1 = [[3; 4]; [4; 5]] in
  let matrix2 = [[2; 1; 4]; [4; 5; 2]] in
  assert_equal
    ([[22; 23; 20]; [28; 29; 26]])
    (matrix_mult matrix1 matrix2)

(* test multiplying two 2x4 matrices together *)
let matrix_mult_2x4 _test_ctxt =
  let matrix1 = [[3; 4]; [4; 5]; [3; 1]; [2; 3]] in
  let matrix2 = [[2; 1; 4]; [2; 3; 4]] in
  assert_equal
    ([[14; 15; 28]; [18; 19; 36]; [8; 6; 16]; [10; 11; 20]])
    (matrix_mult matrix1 matrix2)

(* list of unit tests *)
let unit_tests =
  [ "is_matrix_empty1"                 >:: is_matrix_empty_test1
  ; "is_matrix_empty2"                 >:: is_matrix_empty_test2
  ; "is_matrix_one_row"                >:: is_matrix_one_row
  ; "is_matrix_two_rows"               >:: is_matrix_two_rows
  ; "is_matrix_three_rows"             >:: is_matrix_three_rows
  ; "is_matrix_three_rows_two_columns" >:: is_matrix_three_rows_two_columns
  ; "is_matrix_four_rows_four_columns" >:: is_matrix_four_rows_four_columns
  ; "is_matrix_no1"                    >:: is_matrix_no1
  ; "is_matrix_no2"                    >:: is_matrix_no2
  ; "is_matrix_no3"                    >:: is_matrix_no3

  (* matrix shape tests *)
  ; "matrix_shape_empty"                  >:: matrix_shape_empty
  ; "matrix_shape_two_rows_three_columns" >:: matrix_shape_two_rows_three_columns
  ; "matrix_shape_one_row_one_column"     >:: matrix_shape_one_row_one_column
  ; "matrix_shape_one_row_zero_columns"   >:: matrix_shape_one_row_zero_columns
  ; "matrix_shape_four_rows_four_columns" >:: matrix_shape_four_rows_four_columns

  (* matrix addition tests *)
  ; "matrix_add_empties" >:: matrix_add_empties
  ; "matrix_add_4x4"     >:: matrix_add_4x4
  ; "matrix_add_4x1"     >:: matrix_add_4x1
  ; "matrix_add_3x3"     >:: matrix_add_3x3

  (* matrix multiplication tests *)
  ; "matrix_mult_empty"        >:: matrix_mult_empty
  ; "matrix_mult_zero_columns" >:: matrix_mult_zero_columns
  ; "matrix_mult_3x3"          >:: matrix_mult_3x3
  ; "matrix_mult_3x2"          >:: matrix_mult_3x2
  ; "matrix_mult_2x4"          >:: matrix_mult_2x4
  ]

(* property tests from
 https://en.wikibooks.org/wiki/Famous_Theorems_of_Mathematics/Algebra/Matrix_Theory
 *)

(* pretty printer for counter examples found by quick check *)
let string_of_matrices2 (m1, m2) =
  string_of_matrix m1
  ^ "\n"
  ^ string_of_matrix m2

let string_of_matrices3 (m1, m2, m3) =
  string_of_matrix m1
  ^ "\n"
  ^ string_of_matrix m2
  ^ "\n"
  ^ string_of_matrix m3

let matrix_gen =
  let open QCheck.Gen in
  (list_size
     (pure 8)
     (list_size (pure 8) nat))
  >>= (fun x -> pure x)

let matrix_zeros_gen =
  let open QCheck.Gen in
  (list_size
     (pure 8)
     (list_size (pure 8) (pure 0)))
  >>= (fun x -> pure x)

(* A + B = B + A
  (Commutative law of addition) *)
let commutative_addition =
  QCheck.Test.make ~name:"commutative_addition" ~count:10000
    QCheck.(make
              ~print:string_of_matrices2
              (Gen.pair matrix_gen matrix_gen))
    (fun (m1,m2) ->
       matrix_add m1 m2 = matrix_add m2 m1)

(* A + ( B + C ) = ( A + B ) + C
   (Associative law of addition) *)
let associative_addition =
  QCheck.Test.make ~name:"associative_addition" ~count:10000
    QCheck.(make
              ~print:string_of_matrices3
              (Gen.triple matrix_gen matrix_gen matrix_gen))
    (fun (m1,m2,m3) ->
       matrix_add m1 (matrix_add m2 m3) = matrix_add (matrix_add m1 m2) m3)

(* A( BC ) = ( AB )C
   (Associative law of multiplication) *)
let associative_multiplication =
  QCheck.Test.make ~name:"associative_multiplication" ~count:10000
    QCheck.(make
              ~print:string_of_matrices3
              (Gen.triple matrix_gen matrix_gen matrix_gen))
    (* TODO *)
    (fun (m1,m2,m3) -> matrix_mult m1 (matrix_mult m2 m3) = matrix_mult (matrix_mult m1 m2) m3);;

(* A( B + C ) = AB + AC
   (Distributive law of matrix algebra)
   Multiplication is distributive with respect to addition *)
let distributive_multiplication =
  QCheck.Test.make ~name:"distributive_multiplication" ~count:10000
    QCheck.(make
              ~print:string_of_matrices3
              (Gen.triple matrix_gen matrix_gen matrix_gen))
    (* TODO *)
    (fun (m1,m2,m3) -> matrix_mult m1 (matrix_add m2 m3) = (matrix_add (matrix_mult m1 m2) (matrix_mult m1 m3)));;

(* numeric property tests *)

(* adding a matrix to a matrix of zero values should return the same
 * matrix *)
let addition_identity =
  QCheck.Test.make ~name:"addition_identity" ~count:10000
    QCheck.(make
              ~print:string_of_matrices2
              (Gen.pair
                 matrix_gen (* m1 *)
                 matrix_zeros_gen (* m2 *)
  ))
    (fun (m1,m2) ->
       matrix_add m1 m2 = m1)

(* multiplying a matrix to a matrix of zero values should return the
   matrix containing zero values *)
let multiplcation_zeros =
  QCheck.Test.make ~name:"multiplication_zeros" ~count:10000
    QCheck.(make
              ~print:string_of_matrices2
              (Gen.pair
                 matrix_gen (* m1 *)
                 matrix_zeros_gen (* m2 *)
  ))
    (* TODO *)
    (fun (m1,m2) -> matrix_mult m1 m2 = m2);;


(* list of all property tests *)
let property_tests =
  List.map QCheck_ounit.to_ounit2_test
    [ commutative_addition
    ; associative_addition
    ; associative_multiplication
    ; distributive_multiplication
    ; addition_identity
    ; multiplcation_zeros
    ]

(* run the unit and property based tests *)
let () =
  run_test_tt_main
    ("matrices_tests" >:::
       (List.append unit_tests property_tests))
