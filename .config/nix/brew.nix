{ ... }: {
  homebrew = {
    enable = true;

    brews = [];
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
    ];
  };
}