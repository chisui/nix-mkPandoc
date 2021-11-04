{ pkgs ? import <nixpkgs> { }
}@args: {
  default = {
    texlivePackages = {
      inherit (pkgs.texlive)
        collection-fontsrecommended
        listings
        lm
        xcolor;
    };
  };
  eisvogel = import ./eisvogel.nix args;
}
