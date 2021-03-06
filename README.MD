
[![Build Status](https://travis-ci.org/chisui/nix-mkPandoc.svg?branch=master)](https://travis-ci.org/chisui/nix-mkPandoc)

# mkPandoc 

Provides a way to use [Nix](https://nixos.org/nix/) to call [pandoc](https://github.com/jgm/pandoc).

## usage

The basic usage is:

```nix
let
  mkPandoc = import (builtins.fetchTarball {
    url = "https://github.com/chisui/nix-mkPandoc/archive/master.tar.gz";
  }) {};
in mkPandoc {
  name    = "doc.pdf";
  version = "0.1.0";
  src     = ./simple.md;
}
```

For stuff like LaTex-templates, bibliography and filters take a look at the [examples](./examples/) directory.

An example that uses almost all supported features can be found [here](https://github.com/chisui/dakka/blob/master/thesis/default.nix).

