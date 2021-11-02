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
    revealjs-url = builtins.fetchTarball {
      url    = "https://registry.npmjs.org/reveal.js/-/reveal.js-4.1.3.tgz";
      sha256 = "0a93vxd49y2g0wsafghgqcpj6gszzjvv9lql5zrwrw26lc02x465";
    };
  };
  incremental = true;
  standalone  = true;
}

