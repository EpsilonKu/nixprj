{ language-servers, nixpkgs-f2k, nixpkgs, ... }:
{ config, pkgs, inputs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "epsku";
  home.homeDirectory = "/home/epsku";
  # customNodePackages = pkgs.callPackage ./customNodePackages { };

  home.packages = with pkgs; [                           
    # lua52Packages.lgi
    # language-servers.packages.${pkgs.system}.angular-language-server
    # nixpkgs-f2k.packages.${pkgs.system}.awesome-git
    nodePackages.vscode-langservers-extracted
    elmPackages.nodejs

    htop
    wezterm

    steam
    steam-run

    transmission-gtk
    onlyoffice-bin

    jdk
    # jdk11
    # jdk8

    postman
    github-desktop

    jetbrains.idea-ultimate
    jetbrains.datagrip
    jetbrains.webstorm

    vivaldi
    chromium

    # nodejs
    # nodePackages.npm
    # nodePackages.typescript
    # nodePackages.node2nix

  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs = {
      java.enable = true;
      # neovim = {
      #   enable = true;
      #   defaultEditor = true;
      # };
  };

  imports = [
    ./kitty.nix
    ./neovim
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
