{ config, lib, pkgs, ...}: {
  # TODO: This is only available at the system level, not w/i home manager, even though I'm pretty
  # sure it should be in HM.
  environment.systemPackages = with pkgs; [
    _1password-gui
    _1password
    #git-credential-1password
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
