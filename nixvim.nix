{ config, pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    options = {
      relativenumber = false;
      incsearch = true;
    };


  };
}
