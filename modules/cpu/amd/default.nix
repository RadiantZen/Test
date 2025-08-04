{ config, lib, inputs, ... }:

{
  options = {
    sleuth.cpu.amd.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable AMD CPU Support.";
      # default = (config.report.cpu.manufacturer == "amd");
      default = true;
      example = true;
    };
  };

  config = lib.mkIf config.sleuth.cpu.amd.enable {
    # imports = inputs.nifty.lib.listNixFilesRecursive ./modules;
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    services = {
      fwupd = {
        enable = true;
      };
    };
  };

}
