{ pkgs ? import <nixpkgs> { }
, mkPandoc ? import ./mkPandoc.nix { inherit pkgs; }
, csls ? import ./csls.nix { inherit pkgs; }
, template ? import ./template { inherit pkgs; }
}:
{
  __functor = self: mkPandoc;
  inherit csls template;
}
