{ pkgs      ? import ./nixpkgs.pinned.nix
, mkPandoc  ? import ../mkPandoc.nix { inherit pkgs; }
, csls      ? import ../csls.nix { inherit pkgs; }
, pandoc-citeproc ? pkgs.haskellPackages.pandoc-citeproc
}:
mkPandoc {
  name         = "withCsl.pdf";
  version      = "0.1.0";
  src          = ./withBibliography.md;
  bibliography = ./bibliography.bib;
  csl          = csls.journal-of-computer-information-systems;
  filters      = [ pandoc-citeproc ];
}

