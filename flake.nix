{
  description = "Hardware detection";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nifty = {
      url = "github:RadiantZen/nifty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ... }:
    {
      formatter = inputs.nifty.formatter;

      checks = inputs.nifty.lib.forAllSystems (pkgs: {
        formatting = inputs.nifty.lib.treefmtEval.${pkgs.system}.config.build.check self;
      });

      devShells = inputs.nifty.lib.forAllSystems (pkgs: {
        default = pkgs.mkShell { packages = [ ]; };
      });

      nixosModule = {
        default = {
          imports = [ ./modules ];
        };
      };
    };
}
