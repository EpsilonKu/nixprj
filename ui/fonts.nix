{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    julia-mono
    (nerdfonts.override { fonts = [ "CascadiaCode" "IBMPlexMono" ]; })
  ];
}
