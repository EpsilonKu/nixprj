{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "BlexMono Nerd Font";
      size = 12;
    };

    theme = "Gruvbox Dark Soft";

  };
}
