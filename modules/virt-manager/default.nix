{ config, lib, pkgs, ... }: with lib; {
  options = {
    glamdring.virt-manager = {
      enable = mkEnableOption "Enable virt-manager";
      connections = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "List of connection strings to add to virt-manager";
      };
      # TODO: Hosts config
      # TODO: Key Config
      # TODO: Turnkey?
    };
  };

  config = let
    cfg = config.glamdring.virt-manager;
  in mkIf cfg.enable {
    home.packages = with pkgs; [ virt-manager dconf libvirt ];

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = cfg.connections;
        uris = cfg.connections;
      };
    };
  };
}

