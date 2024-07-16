{ config, pkgs, ... }: {
  imports = [ 
    ./hardware.nix
    ./network.nix
    ./storage.nix
    ./config.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

}
