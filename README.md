# Lamp.jl

![](https://user-images.githubusercontent.com/16760547/271754534-c773d508-0f06-4cb5-9612-f2b7743dd8d6.png)


- This package provides a web application that generates a random logo powered by [RandomLogos.jl](https://github.com/AtelierArith/RandomLogos.jl).
- It also gives an example how to use [Genie.jl (V5)](https://github.com/GenieFramework/Genie.jl) and [GenieFramework.jl](https://learn.genieframework.com/guides/).

# TL; DR

## For lazy Docker users

```console
$ git clone https://github.com/AtelierArith/Lamp.jl.git
$ cd Lamp.jl
$ make && make app
```

Go on to http://0.0.0.0:8080

## For lazy Julians

```console
$ git clone https://github.com/AtelierArith/Lamp.jl.git
$ cd Lamp.jl
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
$ julia --project=@. server.jl
```

Go on to http://127.0.0.1:8080

# How to setup Lamp.jl ?

Instead of rubbing the magic lamp, we're going to summon a web application using GenieFramework.jl.

## Install JuliaLang

- Install [JuliaLang](https://julialang.org/). We could do it with [juliaup](https://github.com/JuliaLang/juliaup) which is one of the famous Julia installer.
- Once you've installed JuliaLang, try to run `julia` command in your terminal.

```julia
$ julia --version
julia version 1.9.
$ julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.9.3 (2023-08-24)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> println("Hello World!")
Hello World!

julia> exit() # Going back to the current session.
```

Another way to evaluate code written in Julia is to use `-e` option.

```console
$ julia -e 'println("Hello World")'
```

See `julia --help` to learn more.

## Install dependencies

Like other programming languages, such as Python, Julia a package manager called [Pkg.jl](https://pkgdocs.julialang.org/v1/).

```console
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
```

See [what is `@.` in Julia `--project` command line option?](https://stackoverflow.com/questions/53613663/what-is-in-julia-project-command-line-option) to learn what `--project=@.` is.

Note that since `RandomLogos.jl` is not registered in Julia's default package registry, you may want to install/update `RandomLogos` manually via:

```console
$ julia --project=@. -e 'using Pkg; Pkg.add(PackageSpec(url="https://github.com/AtelierArith/RandomLogos.jl.git", rev="v0.1.1"))'
```

# How to run Lamp.jl

## Run Lamp.jl on your local machine.

```console
$ julia --project=@. server.jl
```

## Run Lamp.jl as Docker Container

### Build a Docker image

Build a Docker image named `lampjl` in accordance with `./Dockerfile`

```console
$ make
```

This is almost equivalent to the following commands:

```console
$ julia --project=@. -e 'using Genie; Genie.Generator.write_secrets_file()'
$ docker build -t lampjl .
```

### Run a Docker Container

Let's run a Docker Container from `lampjl`.

```console
$ make app
```

This is almost equivalent to the following commands:

```console
$ docker run --rm -it -p 8080:8080 lampjl
```

Then we will get

```console
docker-compose up app
[+] Running 2/2
 ✔ Network lampjl_default  Created                                                 0.1s
 ✔ Container lampjl-app    Created                                                 0.0s
Attaching to lampjl-app
lampjl-app  |
lampjl-app  |
lampjl-app  |  ██████╗ ███████╗███╗   ██╗██╗███████╗    ███████╗
lampjl-app  | ██╔════╝ ██╔════╝████╗  ██║██║██╔════╝    ██╔════╝
lampjl-app  | ██║  ███╗█████╗  ██╔██╗ ██║██║█████╗      ███████╗
lampjl-app  | ██║   ██║██╔══╝  ██║╚██╗██║██║██╔══╝      ╚════██║
lampjl-app  | ╚██████╔╝███████╗██║ ╚████║██║███████╗    ███████║
lampjl-app  |  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝╚══════╝    ╚══════╝
lampjl-app  |
lampjl-app  | | Website  https://genieframework.com
lampjl-app  | | GitHub   https://github.com/genieframework
lampjl-app  | | Docs     https://genieframework.com/docs
lampjl-app  | | Discord  https://discord.com/invite/9zyZbD6J7H
lampjl-app  | | Twitter  https://twitter.com/essenciary
lampjl-app  |
lampjl-app  | Active env: PROD
lampjl-app  |

lampjl-app  | Ready!
lampjl-app  |
lampjl-app  | ┌ Info: 2023-09-30 03:57:05
lampjl-app  | └ Web Server starting at http://0.0.0.0:8080 - press Ctrl/Cmd+C to stop the server.
lampjl-app  | [ Info: 2023-09-30 03:57:06 Listening on: 0.0.0.0:8080, thread id: 1
```

Thank you for trying Lamp.jl.

