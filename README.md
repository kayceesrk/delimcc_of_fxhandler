# delimcc_of_fxhandler

Delimcc primitives from OCaml 5 effect handlers. See [lib/delimcc_of_fxhandler.mli](lib/delimcc_of_fxhandler.mli).

## Install

You can install the library for OCaml 5 as follows:

```bash
$ opam install delimcc_of_fxhandler
```

## Hack

There is a test in `tests/`, which can be run as follows:

```bash
$ dune exec ./test/test1.exe
```

## Note

Delimited control operators such as shift/reset and control/prompt are presented
in a setting where the continuations may be resumed more than once whereas OCaml
5 delimited continuations may not be resumed more than once. To support
multi-shot continuations, this library uses
[ocaml-multicont](https://github.com/dhil/ocaml-multicont). Hence, the same
[caveats](https://github.com/dhil/ocaml-multicont#cautionary-tales-in-programming-with-multi-shot-continuations-in-ocaml)
that applies to `ocaml-multicont` applies to this library.
