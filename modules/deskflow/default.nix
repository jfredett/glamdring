{ config, lib, pkgs, ... }: with lib; {
  options.glamdring.deskflow = {
    enable = mkEnableOption "Enable Deskflow";
    server = mkOption {
      type = types.str;
    };
    debugLevel = mkOption {
      type = types.str;
      default = "INFO";
    };
  };

  config = let
    cfg = config.glamdring.deskflow;
  in mkIf cfg.enable {
      home.packages = with pkgs; [ deskflow ];

      # home.file.".config/path/to/file" = {
      #   text = ''
      #     content
      #   '';
      # };


      systemd.user.services.deskflow-client = {
        Unit = {
          Description = "Deskflow Client Service";
          After = [ "network.target" ];
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
        Service = {
          ExecStart = with pkgs; writeShellScript "deskflow-client-login.sh" ''
            #!/run/current-system/sw/bin/bash
            ${pkgs.deskflow}/bin/deskflow-client -f -d ${cfg.debugLevel} ${cfg.server}
          '';
          Restart = "always";
        };
      };
    };
}
