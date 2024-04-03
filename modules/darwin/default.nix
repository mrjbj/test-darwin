{pkgs, ...}: {
  # here go the darwin preferences and config items
  environment = {
    loginShell = pkgs.zsh;
    pathsToLink = ["/Applications"];
    shells = with pkgs; [bash zsh];
    systemPackages = [pkgs.coreutils];
    systemPath = ["/opt/homebrew/bin"];
  };

  fonts = {
    fontDir.enable = true; # DANGER
    fonts = [(pkgs.nerdfonts.override {fonts = ["Meslo"];})];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  programs.zsh.enable = true;
  system = {
    defaults = {
      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
      };
      dock.autohide = true;
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    stateVersion = 4;
  };
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {};
    casks = ["raycast" "amethyst"];
    taps = ["fujiapple852/trippy"];
    brews = ["trippy"];
  };
  services.nix-daemon.enable = true;
  users.users.mrjbj.home = "/Users/mrjbj";
}
