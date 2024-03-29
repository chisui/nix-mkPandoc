{ pkgs }:
(pkgs.fetchurl {
  name = "eisvogel.latex";
  url = "https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/50ad594fc57f07cbf3c6a67befb771b5e12c07e7/eisvogel.tex";
  sha256 = "1wlcbvhcg19cn88vvvsjiz9s3j4ydsigcr2ymdhpynnvpfmybdzf";
}) // {
  texlivePackages = {
    inherit (pkgs.texlive)
      caption
      collection-fontsrecommended
      csquotes
      etoolbox
      float
      koma-script
      l3kernel
      l3packages
      listings
      lm
      ly1
      mdframed
      mweights
      needspace
      pagecolor
      setspace
      sourcecodepro
      sourcesanspro
      titling
      xcolor
      xkeyval
      zref;
  };
}
