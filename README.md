# [akabe/ocaml](https://hub.docker.com/r/akabe/ocaml/)

| Travis CI | MicroBadger |
| --- | --- |
| [![Build Status](https://travis-ci.org/akabe/docker-ocaml.svg?branch=master)](https://travis-ci.org/akabe/docker-ocaml) | [![Image Status](https://images.microbadger.com/badges/image/akabe/ocaml.svg)](https://microbadger.com/images/akabe/ocaml) |

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

The default images are built on Alpine 3.5:

| Tag | OCaml | OPAM | Command | Dockerfile |
| ------------ | ----- | ---- | ------- | ---------- |
| **latest** | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml` | [Dockerfile](dockerfiles/alpine_ocaml4.06.0/Dockerfile) |
| 4.07.0 | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:4.07.0` | [Dockerfile](dockerfiles/alpine_ocaml4.07.0/Dockerfile) |
| 4.06.1 | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:4.06.1` | [Dockerfile](dockerfiles/alpine_ocaml4.06.1/Dockerfile) |
| 4.06.0 | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:4.06.0` | [Dockerfile](dockerfiles/alpine_ocaml4.06.0/Dockerfile) |
| 4.05.0 | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:4.05.0` | [Dockerfile](dockerfiles/alpine_ocaml4.05.0/Dockerfile) |
| 4.04.2 | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:4.04.2` | [Dockerfile](dockerfiles/alpine_ocaml4.04.2/Dockerfile) |
| 4.03.0 | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:4.03.0` | [Dockerfile](dockerfiles/alpine_ocaml4.03.0/Dockerfile) |
| 4.02.3 | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:4.02.3` | [Dockerfile](dockerfiles/alpine_ocaml4.02.3/Dockerfile) |
| 4.01.0 | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:4.01.0` | [Dockerfile](dockerfiles/alpine_ocaml4.01.0/Dockerfile) |
| 4.00.1 | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:4.00.1` | [Dockerfile](dockerfiles/alpine_ocaml4.00.1/Dockerfile) |

### Alpine

| Distribution | OCaml | OPAM | Command | Dockerfile |
| ------------ | ----- | ---- | ------- | ---------- |
| Alpine | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.07.0` | [Dockerfile](dockerfiles/alpine_ocaml4.07.0/Dockerfile) |
| Alpine | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.06.1` | [Dockerfile](dockerfiles/alpine_ocaml4.06.1/Dockerfile) |
| Alpine | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.06.0` | [Dockerfile](dockerfiles/alpine_ocaml4.06.0/Dockerfile) |
| Alpine | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.05.0` | [Dockerfile](dockerfiles/alpine_ocaml4.05.0/Dockerfile) |
| Alpine | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.04.2` | [Dockerfile](dockerfiles/alpine_ocaml4.04.2/Dockerfile) |
| Alpine | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.03.0` | [Dockerfile](dockerfiles/alpine_ocaml4.03.0/Dockerfile) |
| Alpine | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.02.3` | [Dockerfile](dockerfiles/alpine_ocaml4.02.3/Dockerfile) |
| Alpine | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.01.0` | [Dockerfile](dockerfiles/alpine_ocaml4.01.0/Dockerfile) |
| Alpine | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:alpine_ocaml4.00.1` | [Dockerfile](dockerfiles/alpine_ocaml4.00.1/Dockerfile) |

### CentOS

| Distribution | OCaml | OPAM | Command | Dockerfile |
| ------------ | ----- | ---- | ------- | ---------- |
| CentOS | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.07.0` | [Dockerfile](dockerfiles/centos7_ocaml4.07.0/Dockerfile) |
| CentOS | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.06.1` | [Dockerfile](dockerfiles/centos7_ocaml4.06.1/Dockerfile) |
| CentOS | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.06.0` | [Dockerfile](dockerfiles/centos7_ocaml4.06.0/Dockerfile) |
| CentOS | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.05.0` | [Dockerfile](dockerfiles/centos7_ocaml4.05.0/Dockerfile) |
| CentOS | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.04.2` | [Dockerfile](dockerfiles/centos7_ocaml4.04.2/Dockerfile) |
| CentOS | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.03.0` | [Dockerfile](dockerfiles/centos7_ocaml4.03.0/Dockerfile) |
| CentOS | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.02.3` | [Dockerfile](dockerfiles/centos7_ocaml4.02.3/Dockerfile) |
| CentOS | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.01.0` | [Dockerfile](dockerfiles/centos7_ocaml4.01.0/Dockerfile) |
| CentOS | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:centos_ocaml4.00.1` | [Dockerfile](dockerfiles/centos7_ocaml4.00.1/Dockerfile) |
| CentOS 7 | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.07.0` | [Dockerfile](dockerfiles/centos7_ocaml4.07.0/Dockerfile) |
| CentOS 7 | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.06.1` | [Dockerfile](dockerfiles/centos7_ocaml4.06.1/Dockerfile) |
| CentOS 7 | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.06.0` | [Dockerfile](dockerfiles/centos7_ocaml4.06.0/Dockerfile) |
| CentOS 7 | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.05.0` | [Dockerfile](dockerfiles/centos7_ocaml4.05.0/Dockerfile) |
| CentOS 7 | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.04.2` | [Dockerfile](dockerfiles/centos7_ocaml4.04.2/Dockerfile) |
| CentOS 7 | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.03.0` | [Dockerfile](dockerfiles/centos7_ocaml4.03.0/Dockerfile) |
| CentOS 7 | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.02.3` | [Dockerfile](dockerfiles/centos7_ocaml4.02.3/Dockerfile) |
| CentOS 7 | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.01.0` | [Dockerfile](dockerfiles/centos7_ocaml4.01.0/Dockerfile) |
| CentOS 7 | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:centos7_ocaml4.00.1` | [Dockerfile](dockerfiles/centos7_ocaml4.00.1/Dockerfile) |
| CentOS 6 | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.07.0` | [Dockerfile](dockerfiles/centos7_ocaml4.07.0/Dockerfile) |
| CentOS 6 | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.06.1` | [Dockerfile](dockerfiles/centos7_ocaml4.06.1/Dockerfile) |
| CentOS 6 | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.06.0` | [Dockerfile](dockerfiles/centos7_ocaml4.06.0/Dockerfile) |
| CentOS 6 | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.05.0` | [Dockerfile](dockerfiles/centos6_ocaml4.05.0/Dockerfile) |
| CentOS 6 | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.04.2` | [Dockerfile](dockerfiles/centos6_ocaml4.04.2/Dockerfile) |
| CentOS 6 | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.03.0` | [Dockerfile](dockerfiles/centos6_ocaml4.03.0/Dockerfile) |
| CentOS 6 | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.02.3` | [Dockerfile](dockerfiles/centos6_ocaml4.02.3/Dockerfile) |
| CentOS 6 | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.01.0` | [Dockerfile](dockerfiles/centos6_ocaml4.01.0/Dockerfile) |
| CentOS 6 | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:centos6_ocaml4.00.1` | [Dockerfile](dockerfiles/centos6_ocaml4.00.1/Dockerfile) |

### Debian

| Distribution | OCaml | OPAM | Command | Dockerfile |
| ------------ | ----- | ---- | ------- | ---------- |
| Debian | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.07.0` | [Dockerfile](dockerfiles/debian8_ocaml4.07.0/Dockerfile) |
| Debian | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.06.1` | [Dockerfile](dockerfiles/debian8_ocaml4.06.1/Dockerfile) |
| Debian | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.06.0` | [Dockerfile](dockerfiles/debian8_ocaml4.06.0/Dockerfile) |
| Debian | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.05.0` | [Dockerfile](dockerfiles/debian8_ocaml4.05.0/Dockerfile) |
| Debian | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.04.2` | [Dockerfile](dockerfiles/debian8_ocaml4.04.2/Dockerfile) |
| Debian | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.03.0` | [Dockerfile](dockerfiles/debian8_ocaml4.03.0/Dockerfile) |
| Debian | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.02.3` | [Dockerfile](dockerfiles/debian8_ocaml4.02.3/Dockerfile) |
| Debian | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.01.0` | [Dockerfile](dockerfiles/debian8_ocaml4.01.0/Dockerfile) |
| Debian | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:debian_ocaml4.00.1` | [Dockerfile](dockerfiles/debian8_ocaml4.00.1/Dockerfile) |
| Debian 8 | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.07.0` | [Dockerfile](dockerfiles/debian8_ocaml4.07.0/Dockerfile) |
| Debian 8 | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.06.1` | [Dockerfile](dockerfiles/debian8_ocaml4.06.1/Dockerfile) |
| Debian 8 | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.06.0` | [Dockerfile](dockerfiles/debian8_ocaml4.06.0/Dockerfile) |
| Debian 8 | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.05.0` | [Dockerfile](dockerfiles/debian8_ocaml4.05.0/Dockerfile) |
| Debian 8 | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.04.2` | [Dockerfile](dockerfiles/debian8_ocaml4.04.2/Dockerfile) |
| Debian 8 | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.03.0` | [Dockerfile](dockerfiles/debian8_ocaml4.03.0/Dockerfile) |
| Debian 8 | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.02.3` | [Dockerfile](dockerfiles/debian8_ocaml4.02.3/Dockerfile) |
| Debian 8 | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.01.0` | [Dockerfile](dockerfiles/debian8_ocaml4.01.0/Dockerfile) |
| Debian 8 | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:debian8_ocaml4.00.1` | [Dockerfile](dockerfiles/debian8_ocaml4.00.1/Dockerfile) |

### Ubuntu

| Distribution | OCaml | OPAM | Command | Dockerfile |
| ------------ | ----- | ---- | ------- | ---------- |
| Ubuntu | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.07.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.07.0/Dockerfile) |
| Ubuntu | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.06.1` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.06.1/Dockerfile) |
| Ubuntu | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.06.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.06.0/Dockerfile) |
| Ubuntu | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.05.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.05.0/Dockerfile) |
| Ubuntu | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.04.2` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.04.2/Dockerfile) |
| Ubuntu | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.03.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.03.0/Dockerfile) |
| Ubuntu | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.02.3` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.02.3/Dockerfile) |
| Ubuntu | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.01.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.01.0/Dockerfile) |
| Ubuntu | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:ubuntu_ocaml4.00.1` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.00.1/Dockerfile) |
| Ubuntu 16.04 | 4.07.0+trunk | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.07.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.07.0/Dockerfile) |
| Ubuntu 16.04 | 4.06.1+trunk | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.06.1` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.06.1/Dockerfile) |
| Ubuntu 16.04 | 4.06.0 | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.06.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.06.0/Dockerfile) |
| Ubuntu 16.04 | 4.05.0 | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.05.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.05.0/Dockerfile) |
| Ubuntu 16.04 | 4.04.2 | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.04.2` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.04.2/Dockerfile) |
| Ubuntu 16.04 | 4.03.0 | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.03.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.03.0/Dockerfile) |
| Ubuntu 16.04 | 4.02.3 | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.02.3` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.02.3/Dockerfile) |
| Ubuntu 16.04 | 4.01.0 | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.01.0` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.01.0/Dockerfile) |
| Ubuntu 16.04 | 4.00.1 | 1.2.2 | `docker pull akabe/ocaml:ubuntu16.04_ocaml4.00.1` | [Dockerfile](dockerfiles/ubuntu16.04_ocaml4.00.1/Dockerfile) |
