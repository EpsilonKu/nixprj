{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-neovim.url = "github:nixos/nixpkgs/5d6f45172279af8822d44a4d748de3e3704a770b";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-neovim";
    };  };

  outputs = inputs@{ self, nixpkgs, home-manager, neovim-nightly-overlay, ... }: 
  {
 #    let 
 # overlays = [
 # (final: prev: {
 #                  neovim-nightly = prev.neovim.overrideAttrs (c: { src = inputs.neovim-nightly; });
 #                })
 #        ];
 #    in {
    nixosConfigurations = {
      hostname = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./ui/fonts.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              neovim-nightly-overlay.overlay
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.epsku = import ./home/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
   };
}
