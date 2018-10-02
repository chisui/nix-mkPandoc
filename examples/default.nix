{ pkgs ? import ./nixpkgs.pinned.nix
, mkDerivation ? pkgs.stdenv.mkDerivation
}:
mkDerivation {
  name         = "mkPandoc-examples";
  version      = "0.1.0";
  phases       = ["installPhase"];
  installPhase = ''
    mkdir $out
    ln -s ${import ./simple.nix            {} } $out/simple.pdf
    ln -s ${import ./toHtml.nix            {} } $out/toHtml.html
    ln -s ${import ./withBibliography.nix  {} } $out/withBibliography.pdf
    ln -s ${import ./withCodeBlocks.nix    {} } $out/withCodeBlocks.pdf
    ln -s ${import ./withCsl.nix           {} } $out/withCsl.pdf
    ln -s ${import ./withImage.nix         {} } $out/withImage.pdf
    ln -s ${import ./withLatexTemplate.nix {} } $out/withLatexTemplate.pdf
    ln -s ${import ./withVariables.nix     {} } $out/withVariables.pdf
  '';
}

