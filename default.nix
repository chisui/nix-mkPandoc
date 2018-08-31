{ pkgs      ? import <nixpkgs> {}
, mkPandoc  ? import ./mkPandoc.nix { inherit pkgs; }
, csls      ? import ./csls.nix     { inherit pkgs; }
, templates ? import ./templates    { inherit pkgs; }
}:
{ inherit mkPandoc csls templates; }
