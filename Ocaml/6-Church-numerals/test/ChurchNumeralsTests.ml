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
open ChurchNumerals
open OUnit2


(* test the output from: (c2i (i2c 0)) *)
let c2i_0 _cxt =
  assert_equal (c2i (i2c 0)) 0

(* test the output from: (c2i (i2c 5)) *)
let c2i_1 _cxt =
  (* TODO *)
  assert_equal (c2i (i2c 5)) 5

(* list of unit tests *)
let unit_tests =
    ["c2i_0">:: c2i_0;
     "c2i_1">:: c2i_1
    ]

(* c2i composed with i2c should be the identity function, i.e.

   forall x. c2i (i2c x) = x
*)
let c2i_i2c_identity =
  QCheck.Test.make ~name:"mult_distributive" ~count:10000
    QCheck.(make Gen.nat)
    (* TODO *)
    (fun x -> c2i (i2c x) = x )

(* list of all property tests *)
let property_tests =
  List.map QCheck_ounit.to_ounit2_test
    [
      c2i_i2c_identity
    ]

(* run the unit and property based tests *)
let () =
  run_test_tt_main
    ("church_numerals_tests" >:::
       (List.append unit_tests property_tests))
