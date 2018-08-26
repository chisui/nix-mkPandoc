{ nixpkgs ? <nixpkgs> 
, pkgs ? import nixpkgs {}
}:
{ name
, version
, src
, template
}:

with pkgs;

let
  customTexlive = texlive.combine ({
    inherit (texlive) scheme-basic;
  } // template.texlivePackages);
in
  stdenv.mkDerivation {
    inherit name version src;

    unpackPhase = ":";
    buildInputs = [
      pandoc
      customTexlive
    ];

    buildPhase = ''
      pandoc ${src} \
        --from markdown \
        --listings \
        --toc \
        --template ${template} \
        --number-sections \
        -o result.pdf
    '';

    installPhase = ''
      mv result.pdf $out
    '';
  }

