{config, lib, pkgs, ...}:
{
  # TODO: Turnkey service should pull these keys to /run/keys, owned by this user
  programs.ssh = let 
    ssh_dir = "~/.ssh";
  in {
    matchBlocks = {
      "pinky" = {
        identityFile = "${ssh_dir}/archimedes";
      };

      "*.emerald.city" = {
        identityFile = "${ssh_dir}/archimedes";
      };
      
      "github.oz" = {
        hostname = "github.com";
        identityFile = "${ssh_dir}/archimedes";
      };
    };
  };
}
