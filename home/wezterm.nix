{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    wezterm
  ];
  xdg.configFile."wezterm/wezterm.lua".text = ''
  local wezterm = require 'wezterm'
  return {
  -- enable_wayland = false, --mutter has maximize bug
  -- force_reverse_video_cursor = true,
  colors = {
    foreground = "#c2a383",
    background = "#221A0F",
    cursor_fg = "#221a02",
    cursor_bg = "#f79a32",
    cursor_border = "#f79a32",
    selection_fg = "#221a02",
    selection_bg = "#889b4a",
    scrollbar_thumb = "#c2a383",
    split = "#4c96a8",
    ansi = {
      "#201f1f",
      "#dc3958",
      "#819c3b",
      "#f79a32",
      "#733e8b",
      "#7e5053",
      "#088649",
      "#a89983",
    },
    brights = {
      "#676767",
      "#f14a68",
      "#a3b95a",
      "#f79a32",
      "#dc3958",
      "#fe8019",
      "#4c96a8",
      "#51412c",
    },
    indexed = {
      [16] = "#83a598",
      [17] = "#ea6962",
      [18] = "#418292",
      [19] = "#7E602C"
    },
    tab_bar = {
      active_tab = {
        fg_color = "#c2a383",
        bg_color = "#221a02",
      },
      inactive_tab = {
        fg_color = "#DFBF8E",
        bg_color = "#39260E",
      },
    },
  },
  font = wezterm.font_with_fallback {
    'CaskaydiaCove Nerd Font Mono',
    -- 'Fisa Code',
    -- 'JetBrains Mono',
    -- 'Cascursive',
    -- 'Lexsa',
    -- 'Victor Mono Medium',
    -- 'Maple Mono',
    -- 'IntelOne Mono',
    -- 'SF Mono',
    'FiraCode Nerd Font',
    'Iosevka',
    'JuliaMono Medium',
  },
  -- line_height = 1.1,
  -- cell_width = 0.88,
  font_size = 10,
  -- automatically_reload_config = true,
  window_padding = {
    left = "0.75cell",
    right = "0.5cell",
    top = "0.25cell",
    bottom = "0cell",
  },
  -- window_decorations = "RESIZE",
  window_frame = {
    border_left_color = "#333333",
    border_right_color = "#333333",
    border_bottom_color = "#333333",
    border_top_color = "#333333",
    inactive_titlebar_bg = "#21262e",
    active_titlebar_bg = "#252b34",
  },
  -- hide_mouse_cursor_when_typing = true,
  -- enable_tab_bar = true,
  -- use_fancy_tab_bar = true,
  -- show_tab_index_in_tab_bar = true,
  freetype_load_target = "HorizontalLcd",
  freetype_render_target = "HorizontalLcd",
  freetype_load_flags = 'NO_AUTOHINT'
  -- freetype_load_flags = 'NO_HINTING|MONOCHROME'
  }
  '';


  # xdg.configFile =
  #   {
  #     "nvim" = {
  #       recursive = true;
  #       source = ./nvim;
  #     };
  #   };

}
