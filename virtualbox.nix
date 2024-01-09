{ config, pkgs, lib, ... }: 
{
   virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.host.enableExtensionPack = true;

   users.extraGroups.vboxusers.members = [ "jfredett" ];
}
