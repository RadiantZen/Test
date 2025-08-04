{
  boot = {
    kernel = {
      sysctl = {
        "vm.swappiness" = 180; # Default 60
        #"vm.vfs_cache_pressure" = 200; # Default 100
        "vm.page-cluster" = 0; # Default 3
        "vm.watermark_boost_factor" = 0; # Default 15000
        "vm.watermark_scale_factor" = 125; # Default 10
        "vm.dirty_ratio" = 50; # Default 20
        "vm.dirty_background_ratio" = 10; # Default 10
      };
    };
  };

  swapDevices = [ ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 150;
  };
}
