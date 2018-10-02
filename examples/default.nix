{ pkgs ? import ./nixpkgs.pinned.nix
, mkDerivation ? pkgs.stdenv.mkDerivation
}:
mkDerivation {
  name       = "mkPandoc-examples";
  version    = "0.1.0";
  phases     = ["buildPhase"];
  buildPhase = ''
    mkdir $out
    cp ${import ./simple.nix {}            } $out/simple.pdf
    cp ${import ./toHtml.nix {}            } $out/toHtml.html
    cp ${import ./withBibliography.nix {}  } $out/withBibliography.pdf
    cp ${import ./withCodeBlocks.nix {}    } $out/withCodeBlocks.pdf
    cp ${import ./withCsl.nix {}           } $out/withCsl.pdf
    cp ${import ./withImage.nix {}         } $out/withImage.pdf
    cp ${import ./withLatexTemplate.nix {} } $out/withLatexTemplate.pdf
    cp ${import ./withVariables.nix {}     } $out/withVariables.pdf
  '';
}

