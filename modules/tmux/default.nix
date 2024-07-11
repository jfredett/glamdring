{ config, lib, pkgs, ... }:
{
  options.glamdring.tmux = {
    enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.glamdring.tmux.enable {
    programs.tmux = {
      enable = true;

      keyMode = "vi";
      shortcut = "a";
      terminal = "screen-256color";
      aggressiveResize = true;
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 131072;
      extraConfig = ''
      #window splits and navigation
      bind-key v split-window -h # -c~
      bind-key s split-window #-c~

      # start new windows in the home directory. -c~ doesn't work.
      bind-key c new-window

      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key j select-pane -D
      bind-key k select-pane -U

      bind-key b break-pane
      bind-key r swap-pane -D
      bind-key R swap-pane -U

      bind-key C source-file ~/.tmux.conf

      unbind-key Z # TODO: Rebind detach to be somewhere else, I keep hitting it by accident

      ################################################################################
      ## Status Bar ##################################################################
      ################################################################################

      set -g status-right '[#(echo $HOSTNAME)] [#(date "+%d-%b-%Y %X")]'
      set -g status-right-length 60
      '';
    };

    home.sessionPath = [
      "/home/jfredett/gandalf/tmux/bin"
    ];

    home.file = {
      tmux-cl = {
        target = "/home/jfredett/gandalf/tmux/bin/cl";
        executable = true;
        text = ''
        #!/usr/bin/env bash

        clear
        # If you only run it once, it doesn't actually remove the history, just
        # hides it
        tmux clear-history
        tmux clear-history
        '';
      };

      tmux-mw = {
        target = "/home/jfredett/gandalf/tmux/bin/mw";
        executable = true;
        text = ''
        #!/usr/bin/env bash

        if [ -z "$2" ] ; then
          tmux move-window -t $1
        else
          tmux move-window -t $2 -s $1
        fi
        '';
      };

      tmux-rs = {
        target = "/home/jfredett/gandalf/tmux/bin/rs";
        executable = true;
        text = ''
        #!/usr/bin/env bash
        tmux resize-pane -$1 $2
        '';
      };

      tmux-gt = {
        target = "/home/jfredett/gandalf/tmux/bin/gt";
        executable = true;
        text = ''
        #!/usr/bin/env bash
        tmux select-window -t $1
        '';
      };

      tmux-sw = {
        target = "/home/jfredett/gandalf/tmux/bin/sw";
        executable = true;
        text = ''
        #!/usr/bin/env bash
        mw $1 9999;
        mw $2 $1;
        mw 9999 $2;
        '';
      };
    };
  };
}
