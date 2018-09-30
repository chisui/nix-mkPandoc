{ pkgs }: 
with builtins;
let
  importTemplate = t: 
    let
      value = import t { inherit pkgs; };
      # extract `name` from `{name}.latex.nix`
      name = elemAt (elemAt (split "^([^\.]+)" (parseDrvName value.name).name) 1) 0;
    in { inherit value name; };
in listToAttrs (map importTemplate [
  ./eisvogel.latex.nix
])
