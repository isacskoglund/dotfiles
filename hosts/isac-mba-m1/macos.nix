{inputs, pkgs, ...}: {
  system.defaults = {
    NSGlobalDomain = {
      KeyRepeat = 1;                # Faster repeat
      InitialKeyRepeat = 10;       # Lower delay before repeat
    };

    dock = {
      autohide = true;
      tilesize = 36;               # Smaller Dock
      magnification = false;       # Optional: disable magnification
      show-recents = false;
    };
  };

  nix.enable = false;
  nix.settings.experimental-features = "nix-command flakes";
  programs.zsh.enable = true;
  users.users.isacskoglund.home = "/Users/isacskoglund";
  system = {
    primaryUser = "isacskoglund";
    stateVersion = 5;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    # Show hidden files in Finder
    defaults.finder.AppleShowAllFiles = true;
    # Show full path in Finder title bar
    defaults.finder._FXShowPosixPathInTitle = true;
  };
  security.pam.services.sudo_local.touchIdAuth = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Enable touch id for tmux according to: https://write.rog.gr/writing/using-touchid-with-tmux/
  environment = {
    etc."pam.d/sudo_local".text = ''
        # Managed by Nix Darwin
        auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
        auth       sufficient     pam_tid.so
    '';
  };
}