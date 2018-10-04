{ pkgs
, texlive ? pkgs.texlive
, mkDerivation ? pkgs.stdenv.mkDerivation
, fetchurl ? pkgs.fetchurl
}:
mkDerivation {
  name    = "eisvogel.latex";
  version = "0.0.1";

  src = fetchurl {
    url    = "https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/50ad594fc57f07cbf3c6a67befb771b5e12c07e7/eisvogel.tex";
    sha256 = "1wlcbvhcg19cn88vvvsjiz9s3j4ydsigcr2ymdhpynnvpfmybdzf";
  };

  phases = ["installPhase"];
  installPhase = "cp $src $out";
} // {
  texlivePackages = {
    inherit (texlive)
      collection-fontsrecommended
      pagecolor
      koma-script
      csquotes
      mdframed
      needspace
      sourcesanspro
      ly1
      mweights
      sourcecodepro
      titling
      lm
      listings
      float
      xcolor
      setspace
      etoolbox
      caption
      l3packages
      l3kernel
      xkeyval;
  };
}

