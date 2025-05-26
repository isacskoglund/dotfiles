{
  description = "Nix and NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
	  nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ 
    self, 
    nixpkgs,
    home-manager,
    nix-darwin,
    nix-homebrew,
    ...
  }: {
    darwinConfigurations = {
      "isac-mba-m1" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/isac-mba-m1
        ];
        specialArgs = {
          inputs = inputs;
        };
      };
    };

    nixosConfigurations = {
      "homelab-01" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./hosts/homelab-01];
      };

    };
  };
}