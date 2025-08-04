{ inputs, ... }:

{
  imports = [
    ./cpu/amd
    # ./cpu/intel
  ];

  option.report = {
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
    motherboard = {
      manufacturer = "ASRock";
      chipset = "";
      branding = "x470";
      variation = "";
      ram = {
        slot0 = "";
        slot1 = "";
        slot2 = "";
        slot4 = "";
      };
    };
  };
}
