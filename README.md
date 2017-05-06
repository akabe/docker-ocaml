# akabe/ocaml

Minimum docker images for OCaml+OPAM

This docker image supplies small environment for a functional programming language
[OCaml](http://ocaml.org/) and package manager [OPAM](https://opam.ocaml.org/).

```
docker pull akabe/ocaml
```

For example, you can use OCaml REPL as follows:

```
$ docker run -it --rm akabe/ocaml ocaml
        OCaml version 4.04.1

# let x = 1 + 2;;
val x : int = 3
# let rec fact n = if n <= 1 then n else n * fact (n - 1);;
val fact : int -> int = <fun>
# fact 10;;
- : int = 3628800
# #quit;;
~ $
```


## Distributions

The default `latest` version is the following distribution:

| Distribution | OCaml | OPAM | Command |
| ------------ | ----- | ---- | ------- |
| Alpine 3.5 | 4.04.1 | 1.2.2 | `docker pull akabe/ocaml` |

### Alpine

| Distribution | OCaml | OPAM | Command |
| ------------ | ----- | ---- | ------- |
| Alpine 3.5 | 4.06.0+trunk | 1.2.2 | `docker pull akabe/ocaml:alpine3.5_ocaml4.06.0` |
| Alpine 3.5 | 4.05.0+trunk | 1.2.2 | `docker pull akabe/ocaml:alpine3.5_ocaml4.05.0` |
| Alpine 3.5 | 4.04.1 | 1.2.2 | `docker pull akabe/ocaml:alpine3.5_ocaml4.04.1` |
| Alpine 3.5 | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:alpine3.5_ocaml4.03.0` |
| Alpine 3.5 | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:alpine3.5_ocaml4.02.3` |
| Alpine 3.5 | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:alpine3.5_ocaml4.01.0` |
| Alpine 3.5 | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:alpine3.5_ocaml4.00.1` |
