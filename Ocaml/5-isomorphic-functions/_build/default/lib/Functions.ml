(* Coursework template

   Varun Senthil, H00332328          <--- so we know who you are
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

(* implement the function *)
let curry : (('a * 'b) -> 'c) -> 'a -> 'b -> 'c =
  fun f x y -> f (x,y);;                  (* Takes 2 input values and adds them in the function *)

(* implement the function *)
let uncurry : ('a -> 'b -> 'c) -> ('a * 'b) -> 'c =
  fun f p -> f (fst p)(snd p);;            (* Takes the function f with a tuple, and returns function with the first 
                                            and second element of the tuple *)