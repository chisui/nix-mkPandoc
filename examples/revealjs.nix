{ pkgs     ? import <nixpkgs> { }
, mkPandoc ? import ../default.nix { inherit pkgs; }
}:
mkPandoc {
  name      = "revealjs.html";
  version   = "0.1.0";
  src       = ./revealjs.md;
  to        = "revealjs";
  variables = {
    theme = "serif";
    revealjs-url = "https://github.com/hakimel/reveal.js";
  };
  incremental = true;
  standalone  = true;
}

