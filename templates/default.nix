{ pkgs }: 
with builtins;
let
  importTemplate = template: rec {
    value = import template { inherit pkgs; };
    # extract `name` from `{name}.latex.nix`
    name = elemAt (elemAt (split "^([^\.]+)" (parseDrvName value.name).name) 1) 0;
  };
in listToAttrs (map importTemplate [
  ./eisvogel.latex.nix
])
