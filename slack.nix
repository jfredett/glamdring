{ pkgs, lib, config, ... }: {
  home.packages = with pkgs; [
    slack
  ];
}