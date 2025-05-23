{...}: {
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

  # This is needed to restart affected macOS services after applying:
  system.activationScripts.postUserActivation.text = ''
    killall Dock || true
    killall SystemUIServer || true
  '';
}