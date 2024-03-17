{ pkgs, lib, ... }:
{
  imports = [
#    ./trusted-certificates.nix
#    ./users.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        "jfredett"
        "builder"
        "root"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
  ];

  environment.variables = {
    VAULT_ADDR = "https://vault.emerald.city:8200";
  };
}
