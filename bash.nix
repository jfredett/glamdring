{ config, lib, pkgs, ...}:
{
  home.packages = [ pkgs.oh-my-posh ];

  programs.bash = {
    enableCompletion = true;
    enableVteIntegration = true;

    initExtra = ''
      set -o vi
    '';
    
    shellAliases = {
      "cd.." = "cd ..";
      psf = "ps aux | grep";
      rg = "rg --no-ignore";
    };
  };

  programs.oh-my-posh = {
    enable = true;
    useTheme = "atomicBit";
    # TODO: Custom Theme
  };
  
}