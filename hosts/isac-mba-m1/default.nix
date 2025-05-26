{inputs, ...}:
{
	imports = [
		./macos.nix
		./brew.nix
        inputs.nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
			enableRosetta = true;
			user = "isacskoglund";
			autoMigrate = true;
          };
        }
        inputs.home-manager.darwinModules.home-manager {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.users.isacskoglund = import ./home.nix;
		}
	];
}