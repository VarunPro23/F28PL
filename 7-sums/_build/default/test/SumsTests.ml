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
open Sums
open OUnit2

(* unit tests
     these test specific inputs and outputs *)

let string_of_exp_test1 _test_ctxt =
  assert_equal (string_of_exp (Add (Add (Var "x", Var "y"), Zero))) "((x+y)+0)"

let string_of_exp_test2 _test_ctxt =
  assert_equal (string_of_exp (Add (Var "x", Add (Var "y", Var "z")))) "(x+(y+z))"

let eval_test1 _test_ctxt =
  assert_equal (eval [("x", 2); ("y", 3)] (Add (Add (Var "x", Var "y"), Var "x"))) 7

let eval_test2 _test_ctxt =
  assert_equal (eval [("x", 15); ("y", 3)] (Add (Var "x", Var "y"))) 18

let flatten_test1 _test_ctxt =
  assert_equal (flatten (Add (Add (Var "x", Var "y"), Add (Var "z", Var "x")))) ["x"; "y"; "z"; "x"]

let flatten_sorted_test1 _test_ctxt =
  assert_equal (flatten_sorted (Add (Add (Var "x", Var "y"), Add (Var "z", Var "x")))) ["x"; "x"; "y"; "z"]

(* TODO: write unit tests for `compare_exps'` and
   `compare_exps_sorted'` *)
let compare_exps'_test _test_ctxt =
  assert_equal (flatten' (Add (Add (Var "x", Var "y"), Add (Var "z", Var "x")))) (flatten' (Add (Var "x", Add (Var "y", Add (Var "z", Var "x")))))

let compare_exps_sorted'_test _test_ctxt =
  assert_equal (flatten_sorted' (Add (Add (Var "x", Var "y"), Add (Var "z", Var "x")))) (flatten_sorted' (Add (Var "x", Add (Var "y", Add (Var "z", Var "x")))))  
(* list of unit tests *)
let unit_tests =
    ["string_of_exp_test1"  >:: string_of_exp_test1;
     "string_of_exp_test2"  >:: string_of_exp_test2;
     "eval_test1"           >:: eval_test1;
     "eval_test2"           >:: eval_test2;
     "flatten_test1"        >:: flatten_test1;
     "flatten_sorted_test1" >:: flatten_sorted_test1;
    ]

(* property tests
     these check the laws for addition *)

(* helpers *)
let zero () = Zero
let var x   = Var x
let add a b = Add (a, b)

(* generate a random expression *)
let exp_gen =
  QCheck.Gen.(sized @@ fix
                (fun self n -> match n with
                   | 0 -> map zero unit
                   | n ->
                     oneof
                       [map zero unit;
                        map (fun n -> Var ("x" ^ string_of_int n)) (int_bound 9);
                        map2 add (self (n/2)) (self (n/2))]
                ))

(* pretty printers to show counter examples discovered by quick check *)

(* show a pair of expressions *)
let show_exps2 (a, b) =
  "Pair (" ^ string_of_exp a ^ ", " ^ string_of_exp b ^ ")"

(* show three expressions *)
let show_exps3 (a, b, c) =
  "Triple (" ^ string_of_exp a ^ ", " ^ string_of_exp b ^ ", " ^ string_of_exp c ^ ")"

(* TODO: write more property tests for right and left identity *)

(* associativity *)
let compare_assoc =
  QCheck.Test.make ~name:"compare_assoc" ~count:10000
    QCheck.(make
             ~print:show_exps3
             (Gen.triple exp_gen exp_gen exp_gen))
    (fun (a, b, c) -> compare_exps (Add (Add (a, b), c)) (Add (a, Add (b, c))))

(* commutativity *)
let compare_sorted_comm =
  QCheck.Test.make ~name:"compare_sorted_comm" ~count:10000
    QCheck.(make
             ~print:show_exps2
             (Gen.pair exp_gen exp_gen))
    (fun (a, b) -> compare_exps_sorted (Add (a, b)) (Add (b, a)))

let property_tests =
  List.map QCheck_ounit.to_ounit2_test
    [compare_assoc; compare_sorted_comm]

(* run the unit and property based tests *)
let () =
  run_test_tt_main
    ("algebra_tests" >::: List.append unit_tests property_tests)
