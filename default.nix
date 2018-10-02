{ pkgs      ? import <nixpkgs> {}
, mkPandoc  ? import ./mkPandoc.nix { inherit pkgs; }
, csls      ? import ./csls.nix     { inherit pkgs; }
, templates ? import ./templates    { inherit pkgs; }
}:
{ __functor = self: mkPandoc;
  inherit csls templates; 
}
