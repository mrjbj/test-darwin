{
  pkgs,
  neovim-jbj,
  ...
}: {
  home = {
    file."inputrc".source = ./dotfiles/inputrc;
    file.".zsh_aliases".source = ./dotfiles/zsh_aliases; 
    packages = with pkgs; [
      ripgrep
      fd
      curl
      less
      lf
      zenith
      fd
      zoxide
      joshuto
      dust
      procs
      doggo
      broot
      jq
      gping
      yazi
      mise
      neovim-jbj
    ];
    sessionVariables = {
      PAGER = "less";
      CLICLOLOR = 1;
      EDITOR = "nvim";
    };
    stateVersion = "24.05";
  };

  # specify my home-manager configs
  programs = {
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    eza.enable = true;

    git = {
      enable = true;
      userName = "Jason Jones";
      userEmail = "jason@brucejones.biz";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        ssh-add --apple-use-keychain ~/.ssh/id_rsa_github
        eval "$(zoxide init --cmd cd zsh)"
        source ~/.zsh_aliases
      '';
 #     shellAliases = {
 #       ls = "eza --color=auto -F";
 #       cat = "bat";
 #       br = "broot";
 #       nixswitch = "darwin-rebuild switch --flake ~/GitData/nix/macos/.#Jasons-Virtual-Machine";
 #       nixup = "pushd ~/GitData/nix/macos; nix flake update; nixswitch; popd;";
 #     };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    alacritty = {
      enable = true;
      settings.font.normal.family = "MesloLGS Nerd Font Mono";
      settings.font.size = 16;
    };
  };
}
