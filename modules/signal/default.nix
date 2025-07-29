{ pkgs, lib, config, ... }: {
  options.glamdring.signal = {
    enable = lib.mkEnableOption "Signal";
  };

  config = lib.mkIf config.glamdring.signal.enable {
    home.packages = with pkgs; [
      signal-desktop
      signal-cli
      signal-export
      # signalbackup-tools
      # signal-backup-deduplicator
    ];
  };
}
