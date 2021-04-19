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
open SequenceArithmetic
open OUnit2

(* unit tests *)

(* test seq_add on two empty lists *)
let seq_add_test1 _test_ctxt =
  assert_equal ([]) (seq_add [] [])

(* test seq_add on two non-empty lists *)
let seq_add_test2 _test_ctxt =
  assert_equal [7; 5; 6] (seq_add [2; 3; 5] [5; 2; 1])

(* another test of seq_add on two non-empty lists *)
let seq_add_test3 _test_ctxt =
  (* TODO *)
  assert_equal [10; 10; 10] (seq_add [1;2;3] [9;8;7])

(* another test of seq_add on two non-empty lists *)
let seq_add_test4 _test_ctxt =
  (* TODO *)
  assert_equal [6; 5; 6] (seq_add [0;3;2] [6;2;4])

(* test of seq_mult on two empty lists *)
let seq_mult_test1 _test_ctxt =
  (* TODO *)
  assert_equal ([]) (seq_mult [] [])

(* test seq_mult on two non-empty lists *)
let seq_mult_test2 _test_ctxt =
  (* TODO *)
  assert_equal ([35;40;30]) (seq_mult [5;5;5] [7;8;6])

(* test seq_mult on two non-empty lists *)
let seq_mult_test3 _test_ctxt =
  (* TODO *)
  assert_equal ([0;0;0]) (seq_mult [0;0;0] [1;6;8])

(* test seq_mult on two non-empty lists *)
let seq_mult_test4 _test_ctxt =
  (* TODO *)
  assert_equal ([-16;54;-6]) (seq_mult [-8;9;2] [2;6;-3])

(* list of unit tests *)
let unit_tests =
  [ "seq_add_test1"  >::seq_add_test1
  ; "seq_add_test2"  >::seq_add_test2
  ; "seq_add_test3"  >::seq_add_test3
  ; "seq_add_test4"  >::seq_add_test4
  ; "seq_mult_test1" >::seq_mult_test1
  ; "seq_mult_test2" >::seq_mult_test2
  ; "seq_mult_test3" >::seq_mult_test3
  ; "seq_mult_test4" >::seq_mult_test4
  ]

(* property based tests *)

(* integer sequence generator of 100 elements *)
let integer_sequence_gen =
  QCheck.Gen.(list_size (return 100) nat)

(* zeros sequence generator of 100 elements *)
let zeros_gen =
  QCheck.Gen.(list_size (return 100) (return 0))

(* pretty printer to show counter examples of sequence property tests *)
let show_sequence (seq1,seq2) =
  String.concat "" (List.map string_of_int seq1) ^ "\n"
  ^ String.concat "" (List.map string_of_int seq2)

(* adding a sequence to an empty sequence should return an empty
 * e.g. seq_add [1;2;3] [] = [] *)
let seq_add_empty1 =
  QCheck.Test.make ~name:"seq_add_empty1" ~count:10000
    QCheck.(make integer_sequence_gen)
    (fun seq ->
      seq_add seq [] = [])

(* adding a sequence to an empty sequence should return an empty
 * e.g. seq_add [] [1;2;3] = [] *)
let seq_add_empty2 =
  QCheck.Test.make ~name:"seq_add_empty2" ~count:10000
    QCheck.(make integer_sequence_gen)
    (fun seq ->
      seq_add [] seq = [])

(* adding 0 to each element in a sequence result in the same sequence,
   and hence the input sequence should be the same as the output sequence
   e.g. seq_add [1; 2; 3] [0; 0; 0] => [1; 2; 3]
*)
let seq_add_zeros =
  QCheck.Test.make ~name:"seq_add_zeros" ~count:1000
    QCheck.(make
              ~print:show_sequence
              (Gen.pair integer_sequence_gen zeros_gen))
    (fun (seq,zeros) ->
      seq_add seq zeros = seq)

(* adding 0 to each element in a sequence result in the same sequence,
   and hence the input sequence should be the same as the output sequence
   e.g. seq_add [1; 2; 3] [0; 0; 0] => [1; 2; 3]
 *)
let seq_add_negate =
  let negate_list = List.map (fun x -> -x) in
  let sum = List.fold_left (+) 0
  in
  QCheck.Test.make ~name:"seq_add_negate" ~count:1000
    QCheck.(make integer_sequence_gen)
    (fun seq ->
      sum (seq_add seq (negate_list seq)) = 0)

(* multiplying all elements by 0 should result in a sequence of 0s,
   and hence the sum of these values should also be 0
   e.g. seq_mult [1; 2; 3] [0; 0; 0] => [0; 0; 0]
        sum [0; 0; 0] => 0
*)
let seq_mult_zeros =
  let sum = List.fold_left (+) 0 in
  QCheck.Test.make ~name:"seq_mult_zeros" ~count:1000
    QCheck.(make
              ~print:show_sequence
              (Gen.pair integer_sequence_gen zeros_gen))
    (* TODO *)
    (fun (seq,zeros) -> seq_mult seq zeros = zeros);;

(* list of all property tests *)
let property_tests =
  List.map QCheck_ounit.to_ounit2_test
    [ seq_add_empty1
    ; seq_add_empty2
    ; seq_add_zeros
    ; seq_mult_zeros
    ]

(* run the unit and property based tests *)
let () =
  run_test_tt_main
    ("sequence_arithmetic_tests" >:::
       (List.append unit_tests property_tests))
