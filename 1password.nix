{ config, lib, pkgs, ...}: {
 # Enable the unfree 1Password packages
  home.packages = with pkgs; [
    "1password-gui"
    "1password"
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    # TODO: Extract my username to a config option so I can change it on, e.g., the MBP
    polkitPolicyOwners = [ "jfredett" ];
  };
}
