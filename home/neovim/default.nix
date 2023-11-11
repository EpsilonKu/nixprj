{ config
, pkgs
, lib
, ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    neovim
    lua51Packages.mpack
    xclip
    ripgrep
    sumneko-lua-language-server
    gcc
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  # xdg.configFile =
  #   {
  #     "nvim" = {
  #       recursive = true;
  #       source = ./nvim;
  #     };
  #   };

}
