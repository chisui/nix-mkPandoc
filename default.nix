{ nixpkgs ? <nixpkgs>
, pkgs ? import nixpkgs {}
, mkPandoc ? import ./mkPandoc.nix { inherit pkgs; }
, eisvogel ? import ./eisvogel.nix { inherit pkgs; }
, pandoc-citeproc ? pkgs.haskellPackages.pandoc-citeproc
}:
mkPandoc {
  name     = "test.pdf";
  version  = "0.1.0";
  toc      = true;
  src      = ./test.md;
  template = eisvogel;
  filters  = [ pandoc-citeproc ];
}
