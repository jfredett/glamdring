# The minimum possible glamdring configuration.
{ ... }:
{

  imports = [
    ./modules
  ];

  glamdring = {
    bash.enable = true;
    ssh.enable = true;
    tmux.enable = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

  home.packages = [
  ];

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
