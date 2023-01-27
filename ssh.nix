{config, lib, pkgs, ...}:
{
  # TODO: Turnkey service should pull these keys to /run/keys, owned by this user
  programs.ssh = {
    matchBlocks = {
      "*.emerald.city" = {
        identityFile = "/home/jfredett/.ssh/archimedes";
      };
    };
  };
}