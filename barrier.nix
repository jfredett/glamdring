{ config, lib, pkgs, ... }: {
  # TODO: Parameterize, Modularize, and generally make suck less.

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
        ${pkgs.barrier}/bin/barrierc --disable-crypto --display :0 --debug INFO -f 172.19.0.17
      '';
      Restart = "always";
    };
  };


}
