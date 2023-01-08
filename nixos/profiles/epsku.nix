{ home, config, pkgs, ... }:

{
  home.stateVersion = "22.11";

  imports = [
    ../home-manager/home.nix
  ];
}
