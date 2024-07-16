{ config, pkgs, ... }: {
  networking.hostName = "maiasaura";

  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  networking = {
    nftables.enable = true;
    firewall = {
      allowedTCPPorts = [ 22 ];
      interfaces = {
        enp60s0 = {
          allowedTCPPorts = [ 22 ];
        };
      };
    };

    useDHCP = false;

    interfaces = {
      wlp61s0 = {
        useDHCP = false;
        ipv4 = {
          addresses = [{
            address = "192.168.1.5";
            prefixLength = 24;
          }];
          routes = [
            { address = "192.168.1.0"; via = "192.168.1.1"; prefixLength = 24; }
          ];
        };
      };
    };

    wireless = {
      userControlled.enable = true;
      enable = true;
      interfaces = [ "wlp61s0" ];
      networks = {
        "Emerald City" = {
          # BUG: Hardcoded secret
          psk = "HBJB1972";
        };
      };
    };
  };
}
