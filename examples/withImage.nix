{ pkgs     ? import ./nixpkgs.pinned.nix
, mkPandoc ? import ../default.nix { inherit pkgs; }
}:
mkPandoc.mkPandoc {
  name         = "withImage.pdf";
  version      = "0.1.0";
  src          = ./.;
  documentFile = ./withImage.md;
}

