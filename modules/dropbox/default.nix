{ config, lib, pkgs, ...}: {
  options = {
    glamdring.dropbox.enable = lib.mkEnableOption "Enable Dropbox";
  };

  config = mkIf config.glamdring.dropbox.enable {
    services.dropbox = {
      enable = true;
      path = "/storage/dropbox";
    };
  };
}
