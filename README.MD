[![build examples nixpkgs-unstable](https://github.com/chisui/nix-mkPandoc/actions/workflows/buildExamples.yml/badge.svg)](https://github.com/chisui/nix-mkPandoc/actions/workflows/buildExamples.yml)


# mkPandoc 

Provides a way to use [Nix](https://nixos.org/nix/) to call [pandoc](https://github.com/jgm/pandoc).

## usage

The basic usage is:

```nix
{ pkgs ? import <nixpkgs> { }
}@args:
let
  mkPandoc = import (builtins.fetchTarball {
    url = "https://github.com/chisui/nix-mkPandoc/archive/master.tar.gz";
  }) args;
in mkPandoc {
  name = "simple.pdf";
  src = builtins.toFile "doc.md" ''
    
    # Example

    This is a simple example.

  '';
}
```

For stuff like LaTex-templates, bibliography and filters take a look at the [examples](./examples/) directory.

An example that uses almost all supported features can be found [here](https://github.com/chisui/dakka/blob/master/thesis/default.nix).

