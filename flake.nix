# https://www.youtube.com/watch?v=LE5JR4JcvMg
# 1. run this flake to bootstrap development environment
#   ->  nix run github:zmre/pwzsh
# 2. nix build to build this config
#   -> nix build .#darwinConfigurations.Jasons-Virtual-Machine.system
# 3. initialize darwin for system configuration build the first time
#   ->  ./result/sw/bin/darwin-rebuild switch --flake .
# 4. Other useful commands
#     nix shell nixpkgs#git (if get need to install xcode for git)
{
  description = "my minimal flake";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # tricked out nvim from zmre video
    # pwnvim.url = "github:zmre/pwnvim";
    # lazyvim.url = "github:zmre/pwnvim";

    # lazyvim.url = "github:mrjbj/lazyvim-nixvim";
    # lazyvim = { url = "path:../lazyvim-nixvim"; flake = true; }; 
    # lazyvim.inputs.nixpkgs.follows = "nixpkgs";

    neovim-jbj = {
      url = "git+ssh://git@github.com/mrjbj/neovim-jbj.git?ref=main"; 
      #url = "github:mrjbj/neovim-jbj";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    neovim-jbj,
    ...
  }: {
    darwinConfigurations.Jasons-Virtual-Machine = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import nixpkgs {system = "aarch64-darwin";};
      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit neovim-jbj;};
            # convention for merging modules in a modular configuration system
            users.mrjbj.imports = [./modules/home-manager];
          };
        }
      ];
    };
  };
}
