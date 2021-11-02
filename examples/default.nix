{ pkgs ? import <nixpkgs> { }
, mkDerivation ? pkgs.stdenv.mkDerivation
}:
let
  args = { inherit pkgs; };
in mkDerivation {
  name         = "mkPandoc-examples";
  version      = "0.1.0";
  phases       = ["installPhase"];
  installPhase = ''
    mkdir $out
    ln -s ${import ./simple.nix                args } $out/simple.pdf
    ln -s ${import ./toHtml.nix                args } $out/toHtml.html
    ln -s ${import ./withAdditionalPackges.nix args } $out/withAdditionalPackges.pdf
    ln -s ${import ./withBibliography.nix      args } $out/withBibliography.pdf
    ln -s ${import ./withCodeBlocks.nix        args } $out/withCodeBlocks.pdf
    ln -s ${import ./withCsl.nix               args } $out/withCsl.pdf
    ln -s ${import ./withImage.nix             args } $out/withImage.pdf
    ln -s ${import ./withLatexTemplate.nix     args } $out/withLatexTemplate.pdf
    ln -s ${import ./withVariables.nix         args } $out/withVariables.pdf
    ln -s ${import ./srcAsResourceDir.nix      args } $out/srcAsResourceDir.pdf
    ln -s ${import ./revealjs.nix              args } $out/revealjs.html
  '';
}

