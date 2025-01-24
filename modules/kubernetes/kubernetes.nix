{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.kubernetes = {
      enable = mkEnableOption "Enable the Kubernetes tools";
    };
  };

  config = let
    cfg = config.glamdring.kubernetes;
    condition = cfg.enable;
  in mkIf condition {
    home.packages = with pkgs; [
        kubectl
        kubectx
        k9s
    ];
  };
}
