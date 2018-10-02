{ pkgs      ? import ./nixpkgs.pinned.nix
, mkPandoc  ? import ../default.nix { inherit pkgs; }
}:
mkPandoc.mkPandoc {
  name     = "withLatexTemplate.pdf";
  version  = "0.1.0";
  src      = ./withCodeBlocks.md;
  listings = true;
  template = mkPandoc.templates.eisvogel;
}

