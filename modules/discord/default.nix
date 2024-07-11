{ pkgs, lib, config, ... }: {
  options = {
    glamdring.discord.enable = lib.mkEnableOption "Enable Discord";
  };

  config = lib.mkIf config.glamdring.discord.enable {
    home.packages = [
      pkgs.discord
    ];
  };
}
