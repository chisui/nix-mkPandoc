{ pkgs ? import <nixpkgs> {}
, lib ? pkgs.lib
, mkDerivation ? pkgs.stdenv.mkDerivation
}:
with lib;
with builtins;
let
  mkCsl = { name, sha256, url }: {
    name = elemAt (elemAt (split "^([^\.]+)" name) 1) 0;
    value = mkDerivation {
      inherit name;
      version = "0.1.0";
      src = fetchurl { inherit sha256 url; };
      phases = ["installPhase"];
      installPhase = "cp $src $out";
    };
  };
in listToAttrs (map mkCsl (fromJSON (readFile ./csls.json)))

