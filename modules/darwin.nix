{ config, lib, pkgs, ...}: with lib; {
  config = {
    nix = {
      package = pkgs.lix;
      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
      };
      optimise = {
        automatic = true;
      };
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };

    time.timeZone = "America/New_York";

    nixpkgs.config = {
      allowUnfree = true;
    };

    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
      groff
    ];
  };
}
