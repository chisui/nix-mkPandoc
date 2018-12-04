{ pkgs 
, lib ? pkgs.lib
, texlive ? pkgs.texlive
, pandoc ? pkgs.pandoc
, mkDerivation ? pkgs.stdenv.mkDerivation
}:
{ src, name
, documentFile ? src
, version ? "0.1.0"
, to ? null
# additional build inputs
, buildInputs ? []
# additional texlive packages passed to texlive.combine
, texlivePackages ? {}
# a list of pandoc filters. Each of these will result in a `--filter` argument
# to pandoc. The filters themselves have to be deriviations themselves and are
# added to the buildInputs. The name is either the contents of 
# `pandocFilterName` on the filter or the derivation name if no explict name
# was given.
, filters ? []
# The template has to point to a latex file and has to list all required
# texlive packages in an attribute called `texlivePackages`.
, template ? null
# Overrides for yaml metadata. Each non null entry in the record will result in
# a `--metadata=<KEY>:<VALUE>` argument. Boolean entries will result in a
# `--metadata=<KEY>` flag if the value is `true` otherwise it will be absent
, metadatas ? {}
# Template variables. Each entry in the record will result in a
# `--variable=<KEY>:<VALUE>` argument. Boolean entries will result in a
# `--variable=<KEY>` flag if the value is `true` otherwise it will be absent
, variables ? {}
# one to one mapping for pandoc arguments
, ...
}@args:
let
  inherit (builtins)
    isBool toJSON concatLists parseDrvName elem concatStringsSep;
  inherit (lib) 
    optional hasSuffix mapAttrsToList filterAttrs; 

  customTexlive = optional (to == "latex" || hasSuffix ".pdf" name) (
    texlive.combine (
      { inherit (texlive) scheme-basic; }
      // (if template != null
        then template.texlivePackages or {}
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
      normalArg =      { arg = n: "--${n}";        val = v: " ${v}"; };
      varArg    = pre: { arg = n: "--${pre} ${n}"; val = v: ":${v}"; };
      isRelevantArg = n: v: ! elem n [
        "name" "version" "src" "srcs" "documentFile" "buildInputs"
        "texlivePackages" "filters" "metadatas" "variables"
      ];
      toFilterName = f: f.pandocFilterName or (parseDrvName f.name).name;
    in mkArgs normalArg (filterAttrs isRelevantArg args)
    ++ mkArgs (varArg "metadata") metadatas
    ++ mkArgs (varArg "variable") variables
    ++ map (d: "--filter ${toFilterName d}") filters
    ++ ["-o $out" documentFile];
  pandocCmd = "pandoc ${concatStringsSep " " pandocArgs}";
in mkDerivation {
  inherit name version src;
  buildInputs = [ pandoc ] ++ buildInputs ++ filters ++ customTexlive;
  phases = optional (src != documentFile) "unpackPhase" ++ ["buildPhase"];
  buildPhase = pandocCmd;
  shellHook = "export PANDOC_CMD=${pandocCmd}";
}
