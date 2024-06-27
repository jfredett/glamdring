{ pkgs, lib, config, ... }: {
  options.glamdring.slack = {
    enable = lib.mkEnableOption "Slack";
  }

  config = mkIf config.glamdring.slack.enable {
    home.packages = with pkgs; [
      slack
    ];
  };
}
