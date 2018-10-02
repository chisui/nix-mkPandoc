let
  mkPandoc = import (builtins.fetchTarball {
    url = "https://github.com/chisui/nix-mkPandoc/archive/master.tar.gz";
  }) {};
in mkPandoc {
  name    = "doc.pdf";
  version = "0.1.0";
  src     = ./simple.md;
}
