{ pkgs, lib, ... }:
{

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/New_York";
}
