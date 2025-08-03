{
  description = "Hardware detection";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      forAllSystems =
        function: nixpkgs.lib.genAttrs (import systems) (system: function nixpkgs.legacyPackages.${system});

      treefmtEval = forAllSystems (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

      mkLib =
        nixpkgs:
        nixpkgs.lib.extend (
          final: prev: {
            ixnay = {
              listNixFilesRecursive =
                path: prev.filter (f: prev.hasSuffix ".nix" f) (prev.filesystem.listFilesRecursive path);
              listNonNixFilesRecursive =
                path: prev.filter (f: !prev.hasSuffix ".nix" f) (prev.filesystem.listFilesRecursive path);
              listDefaultNixFilesRecursive =
                path: prev.filter (f: prev.hasSuffix "default.nix" f) (prev.filesystem.listFilesRecursive path);
            };
          }
        );
      lib = (mkLib nixpkgs);
    in
    {
      formatter = forAllSystems (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      checks = forAllSystems (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell { packages = [ ]; };
      });

      nixosModule = {
        default = {
          specialArgs = { inherit inputs nixpkgs lib; };
          imports = [ ./modules ];
        };
      };
    };
}
