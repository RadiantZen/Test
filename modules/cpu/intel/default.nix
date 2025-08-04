{ config, lib, inputs, ... }:

{
  options = {
    sleuth.cpu.intel.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable Intel CPU Support.";
      default = (config.report.cpu.manufacturer == "intel");
      example = true;
    };
  };

  config = lib.mkIf config.sleuth.cpu.intel.enable {
    imports = inputs.nifty.lib.listNixFilesRecursive ./modules;
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
