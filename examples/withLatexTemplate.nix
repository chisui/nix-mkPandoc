{ pkgs      ? import ./nixpkgs.pinned.nix
, mkPandoc  ? import ../default.nix { inherit pkgs; }
}:
mkPandoci.mkPandoc {
  name     = "withLatexTemplate.pdf";
  version  = "0.1.0";
  src      = ./withCodeBlocks.md;
  listings = true;
  template = mkPandoc.templates.eisvogel;
}

