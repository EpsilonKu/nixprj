{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      # name = "CaskaydiaCove Nerd Font";
      name = "JuliaMono Regular";
      size = 10;

    };
    settings = {
      modify_font  = "cell_height 2px baseline 3 underline_position 2";

    };
    keybindings = {
      "ctrl+shift+h"= "previous_tab";
      "ctrl+shift+l"="next_tab";
    };
    # disable-ligatures = "never";

    theme = "Gruvbox Dark Soft";

  };
}
