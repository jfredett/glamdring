{ config, lib, pkgs, ... }: {
  options.glamdring.barrier = {
    enable = lib.mkEnableOption "Enable Barrier";
    server = lib.mkOption {
      type = lib.types.str;
    };
    debugLevel = lib.mkOption {
      type = lib.types.str;
      default = "INFO";
    };
  };

  config = let
    cfg = config.glamdring.barrier;
  in lib.mkIf cfg.enable {
    home.packages = with pkgs; [ barrier ];

    systemd.user.services.barrier-client = {
      Unit = {
        Description = "Barrier Client Service";
        After = [ "network.target" ];
      };
      Install = {
        WantedBy = [ "multi-user.target" ];
      };
      Service = {
        ExecStart = with pkgs; writeShellScript "barrier-client-login.sh" ''
        #!/run/current-system/sw/bin/bash
        ${pkgs.barrier}/bin/barrierc --disable-crypto --display :0 --debug ${cfg.debugLevel} -f ${cfg.server}
        '';
        Restart = "always";
      };
    };
  };
}
