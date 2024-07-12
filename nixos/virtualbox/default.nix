# TODO: Move to ereshkigal?
{ config, pkgs, lib, ... }: {
  options.glamdring.virtualbox = {
    enable = lib.mkEnableOption "Enable VirtualBox";
  };

  config = lib.mkIf config.glamdring.virtualbox.enable {
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;

    users.extraGroups.vboxusers.members = [ "jfredett" ];
  };
}
