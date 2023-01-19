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
    # disable-ligatures = "never";

    theme = "Gruvbox Dark Soft";

  };
}
