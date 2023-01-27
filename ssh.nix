{config, lib, pkgs, ...}:
{
  # TODO: Turnkey service should pull these keys to /run/keys, owned by this user
  programs.ssh = let 
    ssh_dir = "$HOME/.ssh";
  in {
    matchBlocks = {
      "*.emerald.city" = {
        identityFile = "${ssh_dir}/.ssh/archimedes";
      };
      
      "*.github.com" = {
        identityFile = "${ssh_dir}/.ssh/archimedes";
      };
    };
  };
}