# delimcc_of_fxhandler

Delimcc primitives from OCaml 5 effect handlers. See [lib/delimcc_of_fxhandler.mli](lib/delimcc_of_fxhandler.mli).

## Usage

You can install the library for OCaml 5 as follows:

```bash
$ git clone https://github.com/kayceesrk/delimcc_of_fxhandler
$ cd delimcc_of_fxhandler
$ opam pin .
```

There is a test in `tests/`, which can be run as follows:

```bash
$ dune exec ./test/test1.exe
```

## Note

Delimited control operators such as shift/reset and control/prompt are presented
in a setting where the continuations may be resumed more than once. OCaml 5
delimited continuations may not be resumed more than once. This library uses
[ocaml-multicont](https://github.com/dhil/ocaml-multicont) to support multi-shot
continuations. Hence, the same
[caveats](https://github.com/dhil/ocaml-multicont#cautionary-tales-in-programming-with-multi-shot-continuations-in-ocaml)
that applies to `ocaml-multicont` applies to this library.
