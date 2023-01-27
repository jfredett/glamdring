{config, lib, pkgs, ...}:
{
  # TODO: Turnkey service should pull these keys to /run/keys, owned by this user
  programs.ssh = let 
    ssh_dir = "~/.ssh";
  in {
    matchBlocks = {
      "*.emerald.city" = {
        identityFile = "${ssh_dir}/archimedes";
      };
      
      "github.com" = {
        identityFile = "${ssh_dir}/archimedes";
      };
    };
  };
}