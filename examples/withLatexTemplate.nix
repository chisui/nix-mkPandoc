{ pkgs      ? import ./nixpkgs.pinned.nix
, mkPandoc  ? import ../mkPandoc.nix { inherit pkgs; }
, templates ? import ../templates { inherit pkgs; }
}:
mkPandoc {
  name     = "withLatexTemplate.pdf";
  version  = "0.1.0";
  src      = ./withCodeBlocks.md;
  listings = true;
  template = templates.eisvogel;
}

