{ pkgs     ? import ./nixpkgs.pinned.nix
, mkPandoc ? import ../default.nix { inherit pkgs; }
, texlive  ? pkgs.texlive
}:
mkPandoc {
  name    = "withAdditionalPackages.pdf";
  version = "0.1.0";
  src     = ./withAdditionalPackges.md;
  texlivePackages = { inherit (texlive) booktabs; };
}

