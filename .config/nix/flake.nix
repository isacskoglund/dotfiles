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
      nix.enable = false;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      security.pam.services.sudo_local.touchIdAuth = true;

      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.isacskoglund.home = "/Users/isacskoglund";
      # nix.configureBuildUsers = true;
      # nix.useDaemon = true;

      # Enable touch id for tmux according to: https://write.rog.gr/writing/using-touchid-with-tmux/
      environment = {
        etc."pam.d/sudo_local".text = ''
          # Managed by Nix Darwin
          auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
          auth       sufficient     pam_tid.so
        '';
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Isacs-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration 
        ./brew.nix
        ./macos.nix
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
