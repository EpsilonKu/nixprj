{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    iosevka
    julia-mono
    (nerdfonts.override { fonts = [ "CascadiaCode" "IBMPlexMono" "FiraCode"]; })
  ];
}
