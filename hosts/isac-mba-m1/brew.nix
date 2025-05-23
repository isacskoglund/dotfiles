{ nix-homebrew ... }: {
  nix-homebrew.darwinModules.nix-homebrew {
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = "isacskoglund";
      autoMigrate = true;
    };
  }

  homebrew = {
    enable = true;
    brews = [
      "bitwarden-cli"
    ];
    casks = [
      "alacritty"
      "google-chrome"
      "brave-browser"
      "font-jetbrains-mono-nerd-font"
      "karabiner-elements"
      "rectangle"
      "skim"
      "visual-studio-code"
      "cursor"
      "tunnelblick"
      "bitwarden"
    ];
  };
}