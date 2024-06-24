{ config, lib, pkgs, ... }: {
  options = {
    services.emerald-city.virt-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the virt-manager service";
    };
  };

  config = lib.mkIf config.services.emerald-city.virt-manager.enable {
    home.packages = with pkgs; [ virt-manager dconf libvirt ];

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = let 
        connStrings = [
          "qemu+ssh://jfredett@babylon-the-great.pandemon.ium:22/system?keyfile=/home/jfredett/.ssh/archimedes"
          "qemu+ssh://jfredett@dragon-of-perdition.pandemon.ium:22/system?keyfile=/home/jfredett/.ssh/archimedes"
        ];
      in {
        autoconnect = connStrings;
        uris = connStrings;
      };
    };
  };
}

