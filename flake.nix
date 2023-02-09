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
    };

    language-servers.url = "sourcehut:~bwolf/language-servers.nix";
    language-servers.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nixpkgs-f2k.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    neovim-nightly-overlay,
    ...
  }: {

    nixosConfigurations = {
      hostname = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs ; };
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
            home-manager.users.epsku = import ./home/home.nix inputs;
          }
        ];
      };
    };
  };
}
