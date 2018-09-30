{ pkgs     ? import ./nixpkgs.pinned.nix
, mkPandoc ? import ../default.nix { inherit pkgs; }
}:
mkPandoc.mkPandoc {
  name       = "simple.html";
  standalone = true;
  version    = "0.1.0";
  src        = ./simple.md;
}

