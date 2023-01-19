{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      # name = "CaskaydiaCove Nerd Font";
      name = "JuliaMono Medium";
      size = 11;
    };

    theme = "Gruvbox Dark Soft";

  };
}
