{ pkgs     ? import ./nixpkgs.pinned.nix
, mkPandoc ? import ../mkPandoc.nix { inherit pkgs; }
}:
mkPandoc {
  name         = "withImage.pdf";
  version      = "0.1.0";
  src          = ./.;
  documentFile = ./withImage.md;
}

