{ home, config, pkgs, ... }:

{
  home.stateVersion = "23.05";

  imports = [
    ../home-manager/home.nix
  ];
}
