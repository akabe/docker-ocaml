#!/bin/bash -eu

red_echo() {
    echo -e "\033[31m$@\033[0m"
}

green_echo() {
    echo -e "\033[32m$@\033[0m"
}

test_ocaml() {
     cat test_compile.ml | ocaml | grep 1dfde4ba-3fd3-417b-b8c2-002092f1e42e >/dev/null
}

sudo chmod 777 $(pwd)

if test_ocaml; then
    green_echo "[Passed] ocaml is ok"
else
    red_echo "[Failed] ocaml is not ok"
    exit 1
fi

if ocamlc test_compile.ml; then
    green_echo "[Passed] ocamlc is ok"
else
    red_echo "[Failed] ocamlc is not ok"
    exit 1
fi

if ocamlopt test_compile.ml; then
    green_echo "[Passed] ocamlopt is ok"
else
    red_echo "[Failed] ocamlopt is not ok"
    exit 1
fi

if ocamldoc test_compile.ml; then
    green_echo "[Passed] ocamldoc is ok"
else
    red_echo "[Failed] ocamldoc is not ok"
    exit 1
fi

green_echo "***** All tests have been passed! *****"
