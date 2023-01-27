{ config, lib, pkgs, ... }:
{
  home.file = {
    dirstack = {
      target = "$HOME/gandalf/dirstack/bin/dirstack_driver";
      executable = true;
      source = ./dirstack.sh;
    };
    dirstack_include = {
      target = "/home/jfredett/gandalf/dirstack/lib/dirstack_include";
      text = ''
        dirstack() {
          case $1 in
            jump)
              if dirstack_driver peek ; then
                cd $(dirstack_driver peek)
              fi
            ;;
            pop)
              dirstack empty? && dirstack fail 1 ">>Empty Stack<<"
              dirstack jump && dirstack burn
            ;;
            *) dirstack_driver $@ ;;
          esac
        }
      '';
    };
  };
  
  home.sessionPath = [
    "/home/jfredett/gandalf/dirstack/bin"
  ];
  
  # We need this so we can alter the state of the parent shell, this acts as a
  # wrapper around the underlying script.
  programs.bash = {
    bashrcExtra = ''
      source /home/jfredett/gandalf/dirstack/lib/dirstack_include
    '';
    
    shellAliases = {
      push = "dirstack push";
      pop = "dirstack pop";
      jt = "dirstack jump";
      burn = "dirstack burn";
      swap = "dirstack swap";
    };
  };
}