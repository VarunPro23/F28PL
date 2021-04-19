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
open Essay
open OUnit2


(* unit tests *)

let add_test1 _test_ctxt =
  assert_equal 9 (add 5 4)

(* Unit tests for examples in the Signature part of the essay *)
let mult_test _test_ctxt =
  assert_equal 10 (mult 2 5)

let mult1_test _test_ctxt =
  assert_equal 49 (mult1 7 7)

let mult2_test _test_ctxt =
  assert_equal 80 (mult2 8 10)


(* Unit tests for examples in the Polymorphism part of the essay *)
let rev_test1 _test_ctxt =
  assert_equal (3,4) (rev (4,3))

let rev_test2 _test_ctxt = 
  assert_equal (false,true) (rev (true,false))

let rev_test3 _test_ctxt =
  assert_equal ("Hello","World") (rev("World","Hello"))

(* Unit tests for examples in the list and tuples part of the essay *)
let tuple_second_test1 _test_ctxt =
  assert_equal ("Lion") (tuple_second("Tiger","Lion"))

let tuple_second_test2 _test_ctxt =
  assert_equal (true) (tuple_second(false,true))

let append_test1 _test_ctxt =
  assert_equal [1;2;3] (append [][1;2;3])

let append_test2 _test_ctxt =
  assert_equal [10;20;30;40] (append [10;20][30;40])

(* Unit tests for examples in the Pattern-Matching part of the essay *)
let member_test1 _test_ctxt =
  assert_equal true (member 5 [5;3;7;9;1])

let member_test2 _test_ctxt =
  assert_equal false (member 3 [2;4;6;8])

let member_test3 _test_ctxt =
  assert_equal true (member "Name" ["My";"Name";"Is";"Varun"])

let member_test4 _test_ctxt =
  assert_equal false (member "Dog" ["Lion";"Tiger";"Elephant";"Zebra"])

(* Unit tests for examples in the named and anonymous functions part of the essay *)
let cube_test1 _test_ctxt =
  assert_equal 8 (cube 2)

let cube_test2 _test_ctxt =
  assert_equal 125 (cube 5)

(* Unit tests for examples in the Recursive functions part of the essay *) 
let length_test1 _test_ctxt =
  assert_equal 5 (length [10;11;32;1;45])

let length_test2 _test_ctxt =
  assert_equal 2 (length [true;false])

  (* list of unit tests *)
let unit_tests =
  [ "add_test1" >::add_test1;
  
    "mult_test" >::mult_test;
    "mult1_test" >::mult1_test;
    "mult2_test" >::mult2_test;

    "rev_test1" >::rev_test1;
    "rev_test2" >::rev_test2;
    "rev_test3" >::rev_test3;

    "tuple_second_test1" >::tuple_second_test1;
    "tuple_second_test2" >::tuple_second_test2;
    "append_test1" >::append_test1;
    "append_test2" >::append_test2;

    "member_test1" >::member_test1;
    "member_test2" >::member_test2;
    "member_test3" >::member_test3;
    "member_test4" >::member_test4;

    "cube_test1" >::cube_test1;
    "cube_test2" >::cube_test2;
  
    "length_test1" >::length_test1;
    "length_test2" >::length_test2;
  ]

(* property based tests *)

let add_zero =
  QCheck.Test.make ~name:"add_zero" ~count:1000
    QCheck.(make Gen.nat)
    (fun x ->
      add x 0 = x
      && add 0 x = x)


let mult_test_zero =                                              (* Property tests uses a library QCheck to perform randomised testing*)
  QCheck.Test.make ~name:"mult_test_zero" ~count:1000             (* Property is created, given a name and told how many tests to be generated *)              
    QCheck.(make Gen.nat)                                         (* Creating a generator of natural numbers *)
    (fun x ->                                                     (* Creating a function x to test *)
      mult x 0 = 0                                                (* Checks that x*0 = 0 *)
      && mult 0 x = 0)                                            (* Checks that 0*x = 0 *)


let mult1_test_zero = 
  QCheck.Test.make ~name:"mult1_test_zero" ~count:1000
    QCheck.(make Gen.nat)
    (fun x ->
      mult1 x 0 = 0                                               (* Checks that x*0 = 0 *)
      && mult1 0 x = 0)                                           (* Checks that 0*x = 0 *)  


let mult2_test_zero = 
  QCheck.Test.make ~name:"mult2_test_zero" ~count:1000
    QCheck.(make Gen.nat)
    (fun x ->
      mult2 x 0 = 0                                               (* Checks that x*0 = 0 *)
      && mult2 0 x = 0)                                           (* Checks that 0*x = 0 *)      


let append_test_empty =                                           
(* Tests that when an empty list is added to a non-empty list, the non-empty list is returned *)  
  QCheck.Test.make ~name:"append_test_empty" ~count:1000
    QCheck.(make Gen.nat)
    (fun x ->
      append [] [x] = [x]                                         (* Checks if []+[x] = [x] *)
      && append [x] [] = [x]);;                                   (* Checks if [x]+[] = [x] *)  


(* list of all property tests *)
let property_tests =
  List.map QCheck_ounit.to_ounit2_test
    [ add_zero;
      mult_test_zero;
      mult1_test_zero;
      mult2_test_zero;
      append_test_empty;
    ]

(* run the unit and property based tests *)
let () =
  run_test_tt_main
    ("sequence_arithmetic_tests" >:::
       (List.append unit_tests property_tests))
