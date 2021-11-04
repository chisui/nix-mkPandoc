{ pkgs ? import <nixpkgs> { }
, mkPandoc ? import ../default.nix { inherit pkgs; }
, pandoc-citeproc ? pkgs.haskellPackages.pandoc-citeproc
}:
mkPandoc {
  name = "withBibliography.pdf";
  version = "0.1.0";
  src = ./withBibliography.md;
  bibliography = ./bibliography.bib;
  filters = [ pandoc-citeproc ];
}
