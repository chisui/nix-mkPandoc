{ pkgs ? import <nixpkgs> { }
, mkPandoc ? import ../default.nix { inherit pkgs; }
}:
mkPandoc {
  name = "withLatexTemplate.pdf";
  version = "0.1.0";
  src = ./withCodeBlocks.md;
  listings = true;
  template = mkPandoc.template.latex.eisvogel;
}
