{
  inputs.flake-utils.url = "flake-utils";
  inputs.nixpkgs.url = "nixpkgs";
  inputs.mini-compile-commands = {
    # nix flake update mini-compile-commands
    url = "github:Alan-Chen99/mini_compile_commands";
    flake = false;
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    mini-compile-commands,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages."${system}";
      mcc-env = (pkgs.callPackage mini-compile-commands {}).wrap pkgs.stdenv;
      lilypond =
        (pkgs.lilypond.override
          {
            stdenv = mcc-env;
          })
        .overrideAttrs (final: prev: {
          CXXFLAGS = "${prev.CXXFLAGS or ""} -std=c++20";
          src = builtins.path {
            path = ./.;
            name = "source";
          };
          MCC_BUILD_DIR = "$out/${final.pname}-${final.version}-src";
          MCC_KEEP_REGEXP = ''
            \.c$|
            \.cc$|
            \.h$|
            \.hh$|
            \.icc|
            \.tcc$
          '';
        });
    in {
      packages.default = lilypond;
      devShells.default = lilypond.overrideAttrs (final: prev: {
        NIX_BUILD_CORES = 2;
        src = null;
        nativeBuildInputs =
          prev.nativeBuildInputs
          ++ [
            pkgs.bashInteractive
          ];
        CXXFLAGS = "${prev.CXXFLAGS or ""} -O0";
        hardeningDisable = ["fortify"];
        shellHook = ''
          echo "running shellhook"
          unset FONTCONFIG_FILE
          export SHELL="${pkgs.bashInteractive}/bin/bash";
        '';
      });
    });
}
