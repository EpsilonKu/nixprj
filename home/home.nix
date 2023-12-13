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

    elmPackages.nodejs
    nodejs
    nodePackages.npm

    nodePackages.vscode-langservers-extracted
    language-servers.packages.${pkgs.system}.jdt-language-server
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server

    dbeaver

    fontforge-gtk
    helix
    cargo

    stdenv.cc.cc.lib

    gitflow

    ulauncher
    neovide
    lazygit
    meslo-lg

    plymouth
    breeze-plymouth

    anydesk
    newm
    alacritty
    unetbootin
    graalvm-ce
    gradle

    openconnect
    openssl
    remmina

    transmission-gtk
    onlyoffice-bin
    monitor
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

    expect
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    ./kitty.nix
    ./wezterm.nix
    ./neovim
  ];

  # pkgs.mkShell {
  #
  #   buildInputs = [
  #     jetbrains.idea-community
  #   ];
  #   shellHook = ''
  #     # fixes libstdc++ issues and libgl.so issues
  #     LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/
  #   ''
  # }

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
