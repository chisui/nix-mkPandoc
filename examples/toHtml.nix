{ pkgs ? import <nixpkgs> { }
, mkPandoc ? import ../default.nix { inherit pkgs; }
}:
mkPandoc {
  name = "toHtml.html";
  standalone = true;
  version = "0.1.0";
  src = ./simple.md;
}
