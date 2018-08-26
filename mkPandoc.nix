{ nixpkgs ? <nixpkgs> 
, pkgs ? import nixpkgs {}
}:
{ name
, version
, src
, from ? null
, to ? null 
, listings ? true
, template ? null
, toc ? false
, csl ? null
, bibliography ? null
, additionalPandocArgs ? ""
, numberSections ? false
, texlivePackages ? {}
}:

with pkgs;

stdenv.mkDerivation {
  inherit name version src;

  unpackPhase  = ":";
  installPhase = ":";

  buildInputs = [
    pandoc
    (texlive.combine ({
      inherit (texlive) scheme-basic;
    } // template.texlivePackages // texlivePackages))
  ];

  buildPhase = ''
    pandoc ${src} \
      ${if from == null then "\\" else "--from ${from} \\"}
      ${if to   == null then "\\" else "--to   ${to} \\"}
      ${if listings then "--listings\\" else "\\"}
      ${if toc then "--toc \\" else "\\"}
      ${if bibliography == null then "\\" else "--bibliography ${bibliography}\\"}
      ${if csl == null then "\\" else "--csl ${csl}"}
      ${if (template == null) then "\\" else "--template ${template} \\"}
      ${if numberSections then "--number-sections \\" else "\\"}
      ${additionalPandocArgs}\
      -o $out
  '';
}

