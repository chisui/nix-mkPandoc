{ nixpkgs ? <nixpkgs>
, pkgs ? import nixpkgs {}
, lib ? pkgs.lib
, texlive ? pkgs.texlive
, pandoc ? pkgs.pandoc
, mkDerivation ? pkgs.stdenv.mkDerivation
}:
{ name, version, src
, documentFile ? src
# additional build inputs
, buildInputs ? []
# additional texlive packages passed to texlive.combine
, texlivePackages ? {}
# raw pandoc args that aren't covered by arguments to mkPandoc (yet)
, additionalPandocArgs ? []
# a list of pandoc filters. Each of these will result in a `--filter` argument
# to pandoc. The filters themselves have to be deriviations themselves and are
# added to the buildInputs. The name is either the contents of 
# `pandocFilterName` on the filter or the derivation name if no explict name was given.
, filters ? []
# The template has to point to a latex file and has to list all required
# texlive packages in an attribute called `texlivePackages`.
, template ? null
# Overrides for yaml metadata. Each non null entry in the record will result in a
# `--metadata=<KEY>:<VALUE>` argument. Boolean entries will result in a
# `--metadata=<KEY>` flag if the value is `true` otherwise it will be absent
, metadatas ? {}
# Template variables. Each entry in the record will result in a
# `--variable=<KEY>:<VALUE>` argument. Boolean entries will result in a
# `--variable=<KEY>` flag if the value is `true` otherwise it will be absent
, variables ? {}
# one to one mapping for pandoc arguments
, from ? null
, to ? null
, listings ? true
, toc ? false
, csl ? null
, bibliography ? null
, number-sections ? false
, top-level-division ? null
, verbose ? false
, ...
}@args:
let
  inherit (builtins) isBool toJSON concatLists parseDrvName elem concatStringsSep;
  inherit (lib) optional hasSuffix mapAttrsToList filterAttrs; 

  customTexlive = optional (to == "latex" || hasSuffix ".pdf" name) (
    texlive.combine (
      { inherit (texlive) scheme-basic; }
      // (if template != null
        then template.texlivePackages or []
        # default tempalte packages
        else { inherit (texlive) lm collection-fontsrecommended listings; }
      )
      // texlivePackages
    )
  );

  pandocArgs = 
    let 
      mkArgs = { arg, val }: attrs:
        let mkArg = name: value:
          if isBool value then optional value "${arg name}"
          else optional (value != null) "${arg name}${val (toJSON value)}";
        in concatLists (mapAttrsToList mkArg attrs);
      normalArg =   { arg = n: "--${n}";        val = v: " ${v}"; };
      varArg = pre: { arg = n: "--${pre} ${n}"; val = v: ":${v}"; };
      toFilterName = f: f.pandocFilterName or (parseDrvName f.name).name;
    in mkArgs normalArg (filterAttrs (n: v: elem n [ 
        "from" "to" "bibliography" "csl" "template" "top-level-division"
        "listings" "toc" "number-sections" "verbose" "include-before-body"
      ]) args)
      ++ mkArgs (varArg "metadata") metadatas
      ++ mkArgs (varArg "variable") variables
      ++ map (d: "--filter ${toFilterName d}") filters
      ++ additionalPandocArgs
      ++ ["-o $out" documentFile];
in mkDerivation {
  inherit name version src;
  buildInputs = [ pandoc ] ++ buildInputs ++ filters ++ customTexlive;
  phases = ["buildPhase"] ++ optional (src != documentFile) "unpackPhase";
  buildPhase = "pandoc ${concatStringsSep " " pandocArgs}";
}
