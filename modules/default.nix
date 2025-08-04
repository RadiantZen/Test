{ inputs, ... }:

{
  imports = inputs.nifty.lib.listDefaultNixFilesRecursive ./.;

  report = {
    cpu = {
      manufacturer = "amd";
      model = "6700 XT";
      architecture = "Zen 3";
    };
    gpu = {
      design = "amd";
      generation = "RDNA 2";
      architecture = "Navi 22";
      model = "6700 XT";
      manufacturer = "xfx";
      variation = "QICK 309";
    };
  };
}
