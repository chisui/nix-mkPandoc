{ pkgs     ? import <nixpkgs> { }
, mkPandoc ? import ../default.nix { inherit pkgs; }
}:
mkPandoc {
  name         = "withImage.pdf";
  version      = "0.1.0";
  src          = ./.;
  documentFile = ./withImage.md;
}

