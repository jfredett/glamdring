{ config, lib, pkgs, ...}: {
  options.glamdring._1password = {
    enable = lib.mkEnableOption "1password";
    withGUI = lib.mkOption {
      type = "boolean";
      default = true;
      description = "Enable the 1password GUI";
    };
    username = lib.mkOption {
      type = "string";
      default = "jfredett";
      description = "The username to use for 1password";
    };
  };

  config = lib.mkIf config.glamdring._1password.enable {
    # TODO: This is only available at the system level, not w/i home manager, even though I'm pretty
    # sure it should be in HM.
    environment.systemPackages = with pkgs; [
      _1password-gui
      _1password
      # BUG: This seems to be broken?
      #git-credential-1password
    ];

    programs._1password.enable = config.glamdring._1password.withGUI;
    programs._1password-gui = {
      enable = true;
      # Certain features, including CLI integration and system authentication support,
      # require enabling PolKit integration on some desktop environments (e.g. Plasma).
      polkitPolicyOwners = [ config.glamdring._1password.username ];
    };
  };
}
