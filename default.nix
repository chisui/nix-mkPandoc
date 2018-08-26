(import ./mkPandoc.nix {}) {
  name     = "test.pdf";
  version  = "0.1.0";
  toc      = true;
  src      = ./test.md;
  template = import ./eisvogel.nix {};
}
