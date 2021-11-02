{ pkgs      ? import <nixpkgs> { }
, mkPandoc  ? import ../default.nix { inherit pkgs; }
}:
mkPandoc {
  name     = "withCodeBlocks.pdf";
  version  = "0.1.0";
  src      = ./withCodeBlocks.md;
  listings = true;
  texlivePackages = {
    inherit (pkgs.texlive)
      xcolor;
  };
}

