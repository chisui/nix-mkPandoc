{ nixpkgs ? <nixpkgs> 
, pkgs ? import nixpkgs {}
}:

let
  eisvogel = import ./eisvogel.nix {};
  mkPandoc = import ./mkPandoc.nix {};
in
  mkPandoc {
    name     = "test.pdf";
    version  = "0.1.0";
    src      = ./test.md;
    template = eisvogel;
  }

