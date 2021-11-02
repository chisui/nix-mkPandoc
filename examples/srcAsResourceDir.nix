{ pkgs     ? import <nixpkgs> { }
, mkPandoc ? import ../default.nix { inherit pkgs; }
}:
mkPandoc {
  name         = "srcAsResourceDir.pdf";
  version      = "0.1.0";
  src          = ./resources;
  documentFile = ./srcAsResourceDir.md;
}

