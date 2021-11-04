{ pkgs      ? import <nixpkgs> { }
, mkPandoc  ? import ../default.nix { inherit pkgs; }
, pandoc-citeproc ? pkgs.haskellPackages.pandoc-citeproc
}:
mkPandoc {
  name         = "withCsl.pdf";
  version      = "0.1.0";
  src          = ./withBibliography.md;
  bibliography = ./bibliography.bib;
  csl          = mkPandoc.csls.journal-of-computer-information-systems;
  filters      = [ pandoc-citeproc ];
}

