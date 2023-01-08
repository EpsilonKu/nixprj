{ pkgs, ... }:

{
  home.sessionVariables =
    {
      "BROWSER" = "firefox";
    };

  imports = [
    ./kitty.nix
  ];
}
