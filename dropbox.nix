{ config, lib, pkgs, ...}: {
  services.dropbox.enable = true;
  services.dropbox.path = "/storage/dropbox";
}
