{config, lib, pkgs, ...}: {
  options.glamdring.ssh = {
    enable = lib.mkEnableOption "Enable SSH configuration";
  };

  config = lib.mkIf config.glamdring.ssh.enable {
    # TODO: Turnkey service should pull these keys to /run/keys, owned by this user
    programs.ssh = let
      ssh_dir = "~/.ssh";
    in {
      enable = true;
      matchBlocks = {
        "pinky" = {
          identityFile = "${ssh_dir}/archimedes";
        };

        "*.pandemon.ium" = {
          checkHostIP = false;
          identityFile = "${ssh_dir}/archimedes";
        };

        "*.emerald.city" = {
          checkHostIP = false;
          identityFile = "${ssh_dir}/archimedes";
        };

        "github.work" = {
          hostname = "github.com";
          identityFile = "${ssh_dir}/merative-gh";
        };

        "github.oz" = {
          hostname = "github.com";
          identityFile = "${ssh_dir}/archimedes";
        };
      };
    };
  };
}
