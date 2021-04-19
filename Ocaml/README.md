# f28pl-2020-21-ocaml-coursework

F28PL, 2020-2021, OCaml Coursework
This is coursework and counts towards your final grade.

The instructions are in `ocaml-coursework-sheet.pdf`.

To test all seven coursework questions, run `dune runtest --profile
release` within this directory.

To test a particular question, change into the appropriate directory
and then run `dune runtest --profile release`.

If you are seeing errors about missing libraries then install them
using opam. Running

    $ opam install . --deps-only -t -y

from inside this directory should install all of the required
dependencies.

If you see errors about inconsistent assumptions between .cmi files
for some libraries, then upgrade your opam libraries:

    $ opam update
    $ opam upgrade
