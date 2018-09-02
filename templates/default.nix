{ pkgs ? import <nixpkgs> {} }:
with builtins;
let
  importTemplate = t: 
    let
      value = import t { inherit pkgs; };
      name = elemAt (elemAt (split "^([^\.]+)" (parseDrvName value.name).name) 1) 0;
    in { inherit value name; };
in listToAttrs (map importTemplate [
  ./eisvogel.latex.nix
])
