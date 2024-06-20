{ config, lib, pkgs, ... }: {
  options = {
    services.emerald-city.virt-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the virt-manager service";
    };
  };

  config = lib.mkIf config.services.emerald-city.virt-manager.enable {
    programs.virt-manager.enable = true;

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = let 
        connStrings = [
          "qemu:///babylon-the-great.pandemon.ium/system?keyfile=/home/jfredett/.ssh/archimedes"
          "qemu:///dragon-of-perdition.pandemon.ium/system?keyfile=/home/jfredett/.ssh/archimedes"
        ];
      in {
        autoconnect = connStrings;
        uris = connStrings;
      };
    };
  }
}

