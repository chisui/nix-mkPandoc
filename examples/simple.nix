{ pkgs     ? import ./nixpkgs.pinned.nix
, mkPandoc ? import ../default.nix { inherit pkgs; }
}:
mkPandoc {
  name    = "simple.pdf";
  version = "0.1.0";
  src     = ./simple.md;
}

