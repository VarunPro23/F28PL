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
open ComplexNumbers
open OUnit2


(* unit tests
     these test add/mult with specific inputs and outputs *)

(* write a unit test for complex_add *)
let complex_add_test1 _test_ctxt =
  assert_equal (1, 1) (complex_add (1, 0) (0, 1))

(* write another unit test for complex_add *)
let complex_add_test2 _test_ctxt =
  (* TODO *)
  assert_equal (4, 5) (complex_add (1, 5) (3,0))

(* write a unit test for complex_mult *)
let complex_mult_test1 _test_ctxt =
  assert_equal (-11, 23) (complex_mult (3, 2) (1, 7))

(* write another unit test for complex_mult *)
let complex_mult_test2 _test_ctxt =
  (* TODO *)
  assert_equal (-5, 10) (complex_mult (1, 2) (3, 4))

(* write another unit test for complex_mult *)
let complex_mult_test3 _test_ctxt =
  (* TODO *)
  assert_equal (0, 16) (complex_mult (2, 2) (4, 4))

(* write another unit test for complex_mult *)
let complex_mult_test4 _test_ctxt =
  (* TODO *)
  assert_equal (6, 27) (complex_mult (3, 6) (4, 1))

(* list of unit tests *)
let unit_tests =
    ["complex_add_test1"  >:: complex_add_test1;
     "complex_add_test2"  >:: complex_add_test2;
     "complex_mult_test1" >:: complex_mult_test1;
     "complex_mult_test2" >:: complex_mult_test2;
     "complex_mult_test3" >:: complex_mult_test3;
     "complex_mult_test4" >:: complex_mult_test4;
    ]

(* property tests
 *   these check algebraic laws for complex numbers
 *
 * using some algebraic laws from
     https://proofwiki.org/wiki/Properties_of_Complex_Numbers *)

(* complex number generator *)
let complex_number_gen =
  (QCheck.Gen.map (fun (x, y) -> (x, y))
     QCheck.Gen.(pair small_nat small_nat))

(* complex number pretty printers to show counter examples discovered
 * by quick check *)

let show_complex_numbers1 (a, b) =
  "Pair (" ^ string_of_int a ^ "," ^ string_of_int b ^ ")\n"

let show_complex_numbers2 ((a, b), (c, d)) =
  "Pair (" ^ string_of_int a ^ ", " ^ string_of_int b ^ ")\n"
  ^ "Pair (" ^ string_of_int c ^ ", " ^ string_of_int d ^ ")\n"

let show_complex_numbers3 ((a, b), (c, d), (e, f)) =
  "Pair (" ^ string_of_int a ^ ", " ^ string_of_int b ^ ")\n"
  ^ "Pair (" ^ string_of_int c ^ ", " ^ string_of_int d ^ ")\n"
  ^ "Pair (" ^ string_of_int e ^ ", " ^ string_of_int f ^ ")\n"

(* add is commutative:
   z1 + z2 = z2 + z1 *)
let add_commutative =
  QCheck.Test.make ~name:"complex_add_commutative" ~count:10000
    QCheck.(make
              ~print:show_complex_numbers2
              (Gen.pair complex_number_gen complex_number_gen))
    (fun (ci1,ci2) -> complex_add ci1 ci2 = complex_add ci2 ci1)

(* mult is commutative:
   z1 * z2 = z2 * z1 *)
let mult_commutative =
  QCheck.Test.make ~name:"complex_mult_commutative" ~count:10000
    QCheck.(make
              ~print:show_complex_numbers2
              (Gen.pair complex_number_gen complex_number_gen))
    (* TODO *)
    (fun (ci1, ci2) -> complex_mult ci1 ci2 = complex_mult ci2 ci1);;

(* add is associative:
 * z1 + (z2 + z3) = (z1 + z2) + z3  *)
let add_associative =
  QCheck.Test.make ~name:"complex_add_associative" ~count:10000
    QCheck.(make
              ~print:show_complex_numbers3
              (Gen.triple complex_number_gen complex_number_gen complex_number_gen))
    (fun (ci1, ci2, ci3) ->
      (complex_add ci1 (complex_add ci2 ci3)) = (complex_add (complex_add ci1 ci2) ci3))

(* Associative law for multiplication:
 * z1 * (z2 * z3) = (z1 * z2) * z3 *)
let mult_associative =
  QCheck.Test.make ~name:"mult_associative" ~count:10000
    QCheck.(make
              ~print:show_complex_numbers3
              (Gen.triple complex_number_gen complex_number_gen complex_number_gen))
    (* TODO *)
    (fun (ci1, ci2, ci3) -> complex_mult ci1 (complex_mult ci2 ci3) = complex_mult (complex_mult ci1 ci2) ci3);;

(* Multiplication is distributive with respect to addition:
 * z1 * (z2 + z3) = z1 * z2 + z1 * z3 *)
let mult_distributive =
  QCheck.Test.make ~name:"mult_distributive" ~count:10000
    QCheck.(make
              ~print:show_complex_numbers3
              (Gen.triple complex_number_gen
                 complex_number_gen
                 complex_number_gen))
    (* TODO *)
    (fun (ci1, ci2, ci3) -> complex_mult ci1 (complex_add ci2 ci3) = complex_add (complex_mult ci1 ci2) (complex_mult ci1 ci3));;

(* numeric property tests *)

(* complex_mult of any complex number applied to (0,0) should be (0,0)
 * Check with operands in either order i.e.
 *   `complex_mult ci1 (0, 0)`  and `complex_mult ci1 (0, 0)`
 *)
let mult_zero =
  QCheck.Test.make ~name:"complex_mult_zero" ~count:10000
    QCheck.(make
              ~print:show_complex_numbers1
              (complex_number_gen))
    (fun ci1 ->
      complex_mult (0, 0) ci1 = (0, 0)
      && complex_mult ci1 (0, 0) = (0, 0))

(* complex_add of any complex number applied to (0, 0) should be that
 * complex number. Check with operands in either order i.e.
 *   `complex_add ci1 (0, 0)`  and `complex_add ci1 (0, 0)`
 *)
let add_identity =
  QCheck.Test.make ~name:"complex_add_identity" ~count:10000
    QCheck.(make
              ~print:show_complex_numbers1
              (complex_number_gen))
    (* TODO *)
    (fun ci1 -> complex_add ci1 (0,0) = ci1 && complex_add (0,0) ci1 = ci1);;

(* list of all property tests *)
let property_tests =
  List.map QCheck_ounit.to_ounit2_test
    [ add_commutative
    ; mult_commutative
    ; add_associative
    ; mult_associative
    ; mult_distributive
    ; mult_zero
    ; add_identity
    ]

(* run the unit and property based tests *)
let () =
  run_test_tt_main
    ("complex_number_tests" >:::
       (List.append unit_tests property_tests))
