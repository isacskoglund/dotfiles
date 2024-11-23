{
  description = "Home Manager configuration of isacskoglund";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
  }:
  let
    configuration = { pkgs, ... }: {
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.isacskoglund.home = "/Users/isacskoglund";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Isacs-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration 
		nix-homebrew.darwinModules.nix-homebrew {
		  nix-homebrew = {
		    enable = true;
			enableRosetta = true;
			user = "isacskoglund";
			autoMigrate = true;
		  };
		}
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.isacskoglund = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Isacs-MacBook-Air".pkgs;
  };
}
