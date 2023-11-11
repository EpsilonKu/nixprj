{ language-servers, nixpkgs-f2k, nixpkgs, ... }:
{ config, pkgs, inputs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kurenshe";
  home.homeDirectory = "/home/kurenshe";
  # customNodePackages = pkgs.callPackage ./customNodePackages { };

  # home.file."jdks/openjdk17".source = pkgs.jdk;
  home.packages = with pkgs; [                           
    # lua52Packages.lgi
    # language-servers.packages.${pkgs.system}.angular-language-server
    # nixpkgs-f2k.packages.${pkgs.system}.awesome-git
    nodePackages.vscode-langservers-extracted
    language-servers.packages.${pkgs.system}.jdt-language-server
    elmPackages.nodejs
    # newm.packages.${pkgs.system}.newm
    # newm.packages.x86_64-linux.newm

    nodejs
    nodePackages.npm
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    nodePackages.gulp
    dbeaver

    fontforge-gtk

    gitflow

    ulauncher
    neovide
    lazygit
    # wl-clipboard

    plymouth
    breeze-plymouth
    anydesk
    newm
    alacritty
    unetbootin

    # steam
    # steam-run

    transmission-gtk
    onlyoffice-bin

    monitor

    # jdk
    openjdk17
    # jdk11
    # jdk8

    postman
    github-desktop

    jetbrains.idea-community

    chromium
    google-chrome

    filezilla

    obs-studio
    pgsync
    coturn
    stuntman
    janus-gateway
    docker-compose

    # nodejs
    # nodePackages.npm
    # nodePackages.typescript
    # nodePackages.node2nix

  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    ./kitty.nix
    ./wezterm.nix
    ./neovim
    # ./newm
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
